const protobuf = require("@citizenfx/protobufjs");

const playerDatas = {};

// #OLDCODE
// let slotsUsed = 0;

// #OLDCODE
// function assignSlotId() {
// 	for (let i = 0; i < 32; i++) {
// 		if (!(slotsUsed & (1 << i))) {
// 			slotsUsed |= (1 << i);
// 			return i;
// 		}
// 	}
//	
// 	return -1;
// }

// #OLDCODE
// let hostIndex = -1;

const accIds = [ ];

const NUM_SESSIONS = 3;

const sessionsData = { };

// This might not be freed if the player is dropped before actually connecting.
const playersTargetSession = { };

// Populate our sessions data.
{
	for (let i = 0; i < NUM_SESSIONS; i++)
	{
		sessionsData[i] = {
			hostIndex: -1,
			slotsUsed: 0,
			players: [ ],
		}
	}
}

function getSessionHostIndex(sessionId)
{
	return sessionsData[sessionId].hostIndex;
}

function setSessionHostIndex(sessionId, hostIndex)
{
	sessionsData[sessionId].hostIndex = hostIndex;
}

// function getSessionSlotsUsed(sessionId)
// {
// 	return sessionsData[sessionId].slotsUsed;
// }

function getSessionPlayers(sessionId)
{
	return sessionsData[sessionId].players;
}

function getPlayerSession(source)
{
	if (playerDatas[source])
	{
		return playerDatas[source].sessionId;
	}
}

function isPlayerAckOnSession(source, sessionId)
{
	return sessionsData[sessionId].players.indexOf(source) != -1;
}

function ackPlayerOnSession(source, sessionId)
{
	if (!isPlayerAckOnSession(source, sessionId))
	{
		sessionsData[sessionId].players.push(source);

		playerDatas[source].sessionId = sessionId;

		console.log(`Session ${sessionId} Ack Player(${source}).`);
	}
}

function unAckPlayerFromSession(source, sessionId)
{
	const index = getSessionPlayers(sessionId).indexOf(source);

	if (index != -1)
		sessionsData[sessionId].players.splice(index);

	console.log(`Session ${sessionId} UnAck Player(${source}).`);
}

function assignSlotIdForSession(sessionId)
{
	for (let i = 0; i < 32; i++) 
	{
		if (!(sessionsData[sessionId].slotsUsed & (1 << i))) 
		{
			sessionsData[sessionId].slotsUsed |= (1 << i);
			return i;
		}
	}
	
	return -1;
}

exports("setPlayerTargetSession", (source, sessionId) => 
{
	if (!playerDatas[source])
		playersTargetSession[source] = sessionId;
});

exports("getPlayerTargetSession", (source ) => 
{
	if (playersTargetSession[source])
		return playersTargetSession[source];

	return undefined;
});

exports("getSessionPlayers", getSessionPlayers);

exports("getPlayerSession", getPlayerSession);

exports("getSessionHost", (sessionId) =>
{
	const hostIndex = getSessionHostIndex(sessionId);

	if (hostIndex != -1)
	{
		
	}

	return -1;
});

protobuf.load(GetResourcePath(GetCurrentResourceName()) + "/rline.proto", function(err, root) {
	if (err) {
		console.log(err);
		return;
	}
	
	const RpcMessage = root.lookupType("rline.RpcMessage");
	const RpcResponseMessage = root.lookupType("rline.RpcResponseMessage");
	const InitSessionResponse = root.lookupType("rline.InitSessionResponse");
	const InitPlayer2_Parameters = root.lookupType("rline.InitPlayer2_Parameters");
	const InitPlayerResult = root.lookupType("rline.InitPlayerResult");
	const GetRestrictionsResult = root.lookupType("rline.GetRestrictionsResult");
	const QueueForSession_Seamless_Parameters = root.lookupType("rline.QueueForSession_Seamless_Parameters");
	const QueueForSessionResult = root.lookupType("rline.QueueForSessionResult");
	const QueueEntered_Parameters = root.lookupType("rline.QueueEntered_Parameters");
	const scmds_Parameters = root.lookupType("rline.scmds_Parameters");

	function toArrayBuffer(buf) {
		var ab = new ArrayBuffer(buf.length);
		var view = new Uint8Array(ab);
		for (var i = 0; i < buf.length; ++i) {
			view[i] = buf[i];
		}
		return ab;
	}

	function emitMsg(target, data) {
		emitNet('__cfx_internal:pbRlScSession', target, toArrayBuffer(data));
	}

	function emitSessionCmds(target, cmd, cmdname, msg) {
		const stuff = {};
		stuff[cmdname] = msg;
	
		emitMsg(target, RpcMessage.encode({
			Header: {
				MethodName: 'scmds'
			},
			Content: scmds_Parameters.encode({
				sid: {
					value: {
						a: 2,
						b: 2
					}
				},
				ncmds: 1,
				cmds: [
					{
						cmd,
						cmdname,
						...stuff
					}
				]
			}).finish()
		}).finish());
	}

	function emitAddPlayer(target, msg) {
		emitSessionCmds(target, 2, 'AddPlayer', msg);
	}
	
	function emitRemovePlayer(target, msg) {
		emitSessionCmds(target, 3, 'RemovePlayer', msg);
	}
	
	function emitHostChanged(target, msg) {
		emitSessionCmds(target, 5, 'HostChanged', msg);
	}
	
	onNet('playerDropped', () => {
		try {
			const oData = playerDatas[source];

			delete playerDatas[source];

			delete playersTargetSession[source];

			// #OLDCODE
			// if (oData && hostIndex === oData.slot) {
			// 	const pda = Object.entries(playerDatas);
				
			// 	if (pda.length > 0) {
			// 		hostIndex = pda[0][1].slot | 0; // TODO: actually use <=31 slot index *and* check for id
					
			// 		for (const [ id, data ] of Object.entries(playerDatas)) {
			// 			emitHostChanged(id, {
			// 				index: hostIndex
			// 			});
			// 		}
			// 	} else {
			// 		hostIndex = -1;
			// 	}
			// }

			if (!oData)
				return;

			if(oData.req.requestor.acctId != undefined)
				ReleaseAcctId(oData.req.requestor.acctId);

			const sessionId = oData.sessionId;

			// If the player doesn't have a assigned sessionId then when return.
			if(!sessionId)
				return;

			unAckPlayerFromSession(source, sessionId);

			let sessionPlayers = getSessionPlayers(sessionId);

			if (oData && getSessionHostIndex(sessionId) == oData.slot)
			{
				if (sessionPlayers.length > 0 )
				{
					const hostIndex = sessionPlayers[0].slot | 0;

					setSessionHostIndex(sessionId, hostIndex);

					for (const id of sessionPlayers)
					{
						emitHostChanged(id, {
							index: hostIndex	
						})
					}
				}
				else
				{
					setSessionHostIndex(sessionId, -1);
				}
			}
			
			if (oData.slot > -1) {
				sessionsData[sessionId].slotsUsed &= ~(1 << oData.slot);

				// #OLDCODE	
				// slotsUsed &= ~(1 << oData.slot);
			}
		
			// Just to make sure our players haven't changed in the mean time.
			sessionPlayers = getSessionPlayers(sessionId);

			for (const id of sessionPlayers)
			{
				emitRemovePlayer(id, {
					id: oData.id
				});
			}

			// #OLDCODE
			// for (const [ id, data ] of Object.entries(playerDatas)) {
			// 	emitRemovePlayer(id, {
			// 		id: oData.id
			// 	});
			// }
		} catch (e) {
			console.log(e);
			console.log(e.stack);
		}
	});
	
	function makeResponse(type, data) {
		return {
			Header: {
			},
			Container: {
				Content: type.encode(data).finish()
			}
		};
	}
	
	function IsSharedAcctId(acctId) {
		return accIds.indexOf(acctId) != -1;
	}
	
	function ReleaseAcctId(acctId) {
		var search = accIds.indexOf(acctId);
		
		if(search != -1)
			accIds.splice(search);
	}

	const handlers = {
		async InitSession(source, data) {
			return makeResponse(InitSessionResponse, {
				sesid: Buffer.alloc(16),
				/*token: {
					tkn: 'ACSTOKEN token="meow",signature="meow"'
				}*/
			});
		},
		
		async InitPlayer2(source, data) {
			const req = InitPlayer2_Parameters.decode(data);
			
			playerDatas[source] = {
				gh: req.gh,
				peerAddress: req.peerAddress,
				discriminator: req.discriminator,
				slot: -1
			};

			return makeResponse(InitPlayerResult, {
				code: 0
			});
		},
		
		async GetRestrictions(source, data) {
			return makeResponse(GetRestrictionsResult, {
				data: {
				
				}
			});
		},
		
		async ConfirmSessionEntered(source, data) {
			return {};
		},
		
		async QueueForSession_Seamless(source, data) {
			const req = QueueForSession_Seamless_Parameters.decode(data);
			
			let acctId = req.requestId.requestor.acctId;

            if(IsSharedAcctId(acctId)) {
				DropPlayer(source, 'Conta R* compartilhada.');
				return;
			}

			let targetSessionId = 0;

			// #DEBUG
			targetSessionId = (Math.floor(Math.random() * 3) + 1) - 1;  

			if (playersTargetSession[source])
			{
				targetSessionId = playersTargetSession[source];
				
				delete playersTargetSession[source];
			}

			playerDatas[source].req    = req.requestId;
			playerDatas[source].id     = req.requestId.requestor;
			// #OLDCODE
			// playerDatas[source].slot   = assignSlotId();
			playerDatas[source].slot   = assignSlotIdForSession(targetSessionId);
			playerDatas[source].acctId = acctId;
	
			accIds.push(playerDatas[source].acctId);
			
			setTimeout(() => {
				emitMsg(source, RpcMessage.encode({
					Header: {
						MethodName: 'QueueEntered'
					},
					Content: QueueEntered_Parameters.encode({
						queueGroup: 69,
						requestId: req.requestId,
						optionFlags: req.optionFlags
					}).finish()
				}).finish());
				
				if (getSessionHostIndex(targetSessionId) === -1)
					setSessionHostIndex(targetSessionId, playerDatas[source].slot | 0);

				// #OLDCODE
				// if (hostIndex === -1) {
				// 	hostIndex = playerDatas[source].slot | 0;
				// }
				
				emitSessionCmds(source, 0, 'EnterSession', {
					index: playerDatas[source].slot | 0,
					hindex: getSessionHostIndex(targetSessionId),
					sessionFlags: 0,
					mode: 0,
					// #OLDCODE
					// size: Object.entries(playerDatas).filter(a => a[1].id).length,
					size: getSessionPlayers(targetSessionId).length,
					teamIndex: 0,
					transitionId: {
						value: {
							a: 0,//2,
							b: 0
						}
					},
					sessionManagerType: 0,
					slotCount: 32
				});
				
				setTimeout(() => {
					// tell player about everyone, and everyone about player
					
					ackPlayerOnSession(source, targetSessionId);

					const meData = playerDatas[source];
					
					const aboutMe = {
						id: meData.id,
						gh: meData.gh,
						addr: meData.peerAddress,
						index: playerDatas[source].slot | 0
					};
					
					for (const id of getSessionPlayers(targetSessionId))
					{
						if (id == source) 
							continue;

						const data = playerDatas[id];

						if (!data)
							continue;

						emitAddPlayer(source, {
							id: data.id,
							gh: data.gh,
							addr: data.peerAddress,
							index: data.slot | 0
						});
						
						emitAddPlayer(id, aboutMe);
					}

					// #OLDCODE
					// for (const [ id, data ] of Object.entries(playerDatas)) {
					// 	if (id == source || !data.id || data.sessionId !== sessionId) continue;
					
					// 	emitAddPlayer(source, {
					// 		id: data.id,
					// 		gh: data.gh,
					// 		addr: data.peerAddress,
					// 		index: data.slot | 0
					// 	});
						
					// 	emitAddPlayer(id, aboutMe);
					// }
				}, 150);
			}, 50);
			
			return makeResponse(QueueForSessionResult, {
				code: 1
			});
		},
	};

	async function handleMessage(source, method, data) {
		if (handlers[method]) {
			return await handlers[method](source, data);
		}

		return {};
	}
	
	onNet('__cfx_internal:pbRlScSession', async (data) => {
		const s = source;
		
		try {
			const message = RpcMessage.decode(new Uint8Array(data));
			const response = await handleMessage(s, message.Header.MethodName, message.Content);
			
			if (!response || !response.Header) {
				return;
			}
			
			response.Header.RequestId = message.Header.RequestId;
			
			emitMsg(s, RpcResponseMessage.encode(response).finish());
		} catch (e) {
			console.log(e);
			console.log(e.stack);
		}
	});
});