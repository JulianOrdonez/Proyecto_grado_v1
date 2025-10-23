const express = require('express');
const router = express.Router();
const authController = require('../controllers/authController');

router.post('/register', authController.register);
router.post('/login', authController.login);
router.get('/usuarios', authController.getUsuarios);
router.put('/usuarios/:id', authController.cambiarRol);
router.delete('/usuarios/:id', authController.eliminarUsuario);

module.exports = router;
