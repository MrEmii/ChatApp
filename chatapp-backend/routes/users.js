/**
 * path: users
 */

 const { Router } = require('express');
const { getUsers } = require('../controllers/users');
 const { validarCampos, validarJWT } = require('../middlewares/validators');

 const router = Router();

 router.get("/", validarJWT, getUsers);

 module.exports = router;