const { response } = require("express");
const Message = require("../models/message");

const getMessages = async (req, res = response) => {
  const from = req.id;
  const to = req.params.to;

  const messages = await Message.find({
    $or: [{ from, to }, { from: to, to: from }],
  })
  .sort({ createdAt: 'desc' })
  .limit(30);


  res.json({
    ok: true,
    from,
    messages: messages,
  });
}

module.exports = {
  getMessages
}