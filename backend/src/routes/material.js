const express = require('express');
const router = express.Router();
const materialController = require('../controllers/materialController');

router.post('/solicitudes-materiales', materialController.crearSolicitud);
router.get('/solicitudes-materiales', materialController.obtenerSolicitudes);
router.put('/solicitudes-materiales/:id', materialController.actualizarSolicitud);

module.exports = router;

