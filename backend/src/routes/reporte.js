const express = require('express');
const router = express.Router();
const reporteController = require('../controllers/reporteController');

router.post('/', reporteController.crearReporte);
router.get('/', reporteController.listarReportes);
router.put('/:id', reporteController.actualizarEstado);

module.exports = router;
