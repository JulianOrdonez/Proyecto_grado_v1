const db = require('../models/db');

exports.agregarComentario = async (req, res) => {
  const { id } = req.params;
  const { usuario_id, comentario, archivo_url } = req.body;
  if (!usuario_id || !comentario) {
    return res.status(400).json({ message: 'Usuario y comentario son obligatorios' });
  }
  try {
    await db.query(
      'INSERT INTO reporte_comentarios (reporte_id, usuario_id, comentario, archivo_url) VALUES (?, ?, ?, ?)',
      [id, usuario_id, comentario, archivo_url || null]
    );
    res.status(201).json({ message: 'Comentario agregado correctamente' });
  } catch (error) {
    res.status(500).json({ message: 'Error al agregar comentario', error });
  }
};

exports.obtenerHistorial = async (req, res) => {
  const { id } = req.params;
  try {
    const [comentarios] = await db.query(
      'SELECT rc.*, u.nombre as usuario FROM reporte_comentarios rc JOIN usuarios u ON rc.usuario_id = u.id WHERE rc.reporte_id = ? ORDER BY rc.fecha ASC',
      [id]
    );
    res.json(comentarios);
  } catch (error) {
    res.status(500).json({ message: 'Error al obtener historial', error });
  }
};

