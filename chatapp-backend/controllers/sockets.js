const { verifyJWT } = require("../helpers/jwt");
const User = require("../models/user");

const Message = require("../models/message");

const isUserValid = (client) => {
  const [isValid, user] = verifyJWT(client.handshake.headers['x-token']);

  if (!isValid) {
    client.disconnect();
    return;
  }

  return user;
}

const connnectUser = async (uid) => {
  const user = await User.findById(uid);
  if (!user) {
    return;
  }

  user.online = true;
  await user.save();

  return user;
}

const disconnectUser = async (uid) => {
  const user = await User.findById(uid);
  if (!user) {
    return;
  }

  user.online = false;
  await user.save();

  return user;
}

const saveMessage = async (paylod) => {
  try {
    const message = new Message(paylod);
    await message.save();
    return true;
  } catch (e) {
    console.log(e);
    return false;
  }
}

module.exports = {
  isUserValid,
  connnectUser,
  disconnectUser,
  saveMessage
}