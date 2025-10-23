const express = require('express');
const router = express.Router();
const comentarioController = require('../controllers/comentarioController');

router.post('/reportes/:id/comentarios', comentarioController.agregarComentario);
router.get('/reportes/:id/historial', comentarioController.obtenerHistorial);

module.exports = router;

