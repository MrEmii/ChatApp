const { response } = require("express");
const User = require('../models/user')
const bcrypt = require('bcryptjs');
const { generateJWT } = require("../helpers/jwt");

const crearUsuario = async (req, res = response) => {

  const { email, password } = req.body;

  try {

    const isExisting = await User.findOne({ email });

    if (isExisting) return res.status(400).send({
      ok: false,
      msg: "Ese correo ya ta"
    })

    const user = new User(req.body);

    const salt = bcrypt.genSaltSync();

    user.password = bcrypt.hashSync(password, salt);

    await user.save();

    const token = await generateJWT(user.id);

    res.send({
      ok: true,
      msg: 'Usuario creado UwU',
      user: user.toJSON(),
      token
    })

  } catch (err) {
    console.log(err);
    return res.status(500).send({
      ok: false,
      msg: "Mal ahí loco un re error"
    })
  }

}

const login = async (req, res = response) => {

  const { email, password } = req.body;

  try {
    const user = await User.findOne({ email });

    if (!user) return res.status(400).send({ ok: false, msg: 'Upa y ese correo?' })

    const passwordMatch = bcrypt.compareSync(password, user.password);

    if (!passwordMatch) return res.status(400).send({ ok: false, msg: 'flashaste banda con esa' });

    const token = await generateJWT(user.id);


    res.send({
      ok: true,
      msg: 'Usuario re encontrado UwU',
      user: user.toJSON(),
      token
    })

  } catch (error) {
    console.log(err);
    return res.status(500).send({
      ok: false,
      msg: "Mal ahí loco un re error"
    })
  }


}

const renewToken = async (req, res) => {

  try {

    const token = await generateJWT(req.id);

    const user = await User.findById(req.id)

    res.send({
      ok: true,
      msg: 'Cheeeto ese id',
      user: user.toJSON(),
      token
    })
  } catch (error) {
    console.log(error);
    return res.status(500).send({
      ok: false,
      msg: "Mal ahí loco un re error"
    })
  }
}

module.exports = {
  crearUsuario,
  login,
  renewToken
}