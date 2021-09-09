/**
 * path: auth
 */

const { Router } = require('express');
const { check } = require('express-validator');
const { crearUsuario, login, renewToken } = require('../controllers/auth');
const { validarCampos, validarJWT } = require('../middlewares/validators');

const router = Router();

router.post("/new", [
  check('nombre', 'Faltó nombre pa').not().isEmpty(),
  check('email', 'Tu mial ta mal loco').isEmail(),
  check('password', 'Faltó la contra pa').not().isEmpty(),
  validarCampos
], crearUsuario);

router.post("/login", [
  check('email', 'Tu mial ta mal loco').isEmail(),
  check('password', 'Faltó la contra pa').not().isEmpty(),
  validarCampos
], login);

router.post("/renew", [
  validarJWT
],  renewToken);

module.exports = router;