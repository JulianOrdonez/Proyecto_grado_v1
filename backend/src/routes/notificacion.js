const express = require('express');
const router = express.Router();
const notificacionController = require('../controllers/notificacionController');

router.post('/notificaciones', notificacionController.crearNotificacion);
router.get('/notificaciones', notificacionController.obtenerNotificaciones);
router.put('/notificaciones/:id/leida', notificacionController.marcarLeida);

module.exports = router;

