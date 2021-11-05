const { response } = require("express")
const user = require("../models/user")

const getUsers = async (req, res = response) => {
  const desde = Number(req.query.desde) || 0;
  const hasta = Number(req.query.hasta) || 5;

  const users = await user.find({
    _id: { $ne: req.id },
  })
  .sort("-online")
  .skip(desde)
  .limit(hasta);

  return res.json({
    ok: true,
    users,
    desde,
    hasta,
  })
}

module.exports = {
  getUsers
}