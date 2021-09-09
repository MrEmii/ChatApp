const jwt = require('jsonwebtoken');

const generateJWT = (id) => {
  return new Promise((resolve, reject) => {
    const payload = { id }

    jwt.sign(payload, "pepeargentino", {
      expiresIn: '48h'
    }, (err, token) => {
      if (err) {
        return reject({ok: false, msg: "Salió mal el token papuchoo"})
      }
      resolve(token)

    });
  })
}

module.exports = {
  generateJWT
}