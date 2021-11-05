const { io } = require('../index');
const { isUserValid, connnectUser, disconnectUser, saveMessage } = require('../controllers/sockets');

/**
 * @description Socket connection
 * @param {Object} socket
 * @returns {void}
 */
io.on('connection', async function (client) {
  const userId = isUserValid(client);
  connnectUser(userId);


  client.join(userId);

  client.on('message-user', async (payload) => {
    await saveMessage(payload);
    client.to(payload.to).emit('user-message', payload);
  })

  client.on('disconnect', () => {
    disconnectUser(userId);
  })

});
