const { validationResult, check } = require("express-validator");
const jwt = require('jsonwebtoken');

const validarCampos = (req, res, next) => {
  const errores = validationResult(req);

  if (!errores.isEmpty()) {
    return res.status(400).send({
      ok: false,
      errors: errores.mapped()
    })
  }

  next();
}

const validarJWT = (req, res, next) => {
  const token = req.headers['x-token'];

  if (!token) res.status(400).send({ ok: false, msg: 'WTF Y TU TOKEN' })

  try {
    const { id } = jwt.verify(token, 'pepeargentino');

    req.id = id;

    next();
  } catch (err) {
    console.log(err);
    res.status(400).send({ ok: false, msg: 'nah vola de acá que tu token ni anda' })
  }

}

module.exports = {
  validarCampos,
  validarJWT
}