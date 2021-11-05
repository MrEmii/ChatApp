/**
 * path: messages
 */

const { Router } = require('express');
const { getMessages } = require('../controllers/messages');
const { validarJWT } = require('../middlewares/validators');

const router = Router();

router.get("/:to", validarJWT, getMessages);

module.exports = router;