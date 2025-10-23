const db = require('../models/db');

exports.crearNotificacion = async (req, res) => {
  const { usuario_id, mensaje, tipo } = req.body;
  if (!usuario_id || !mensaje) {
    return res.status(400).json({ message: 'Usuario y mensaje son obligatorios' });
  }
  try {
    await db.query(
      'INSERT INTO notificaciones (usuario_id, mensaje, tipo) VALUES (?, ?, ?)',
      [usuario_id, mensaje, tipo || null]
    );
    res.status(201).json({ message: 'Notificación creada correctamente' });
  } catch (error) {
    res.status(500).json({ message: 'Error al crear notificación', error });
  }
};

exports.obtenerNotificaciones = async (req, res) => {
  const { usuarioId } = req.query;
  try {
    const [notificaciones] = await db.query(
      'SELECT * FROM notificaciones WHERE usuario_id = ? ORDER BY fecha DESC',
      [usuarioId]
    );
    res.json(notificaciones);
  } catch (error) {
    res.status(500).json({ message: 'Error al obtener notificaciones', error });
  }
};

exports.marcarLeida = async (req, res) => {
  const { id } = req.params;
  try {
    await db.query('UPDATE notificaciones SET leida = TRUE WHERE id = ?', [id]);
    res.json({ message: 'Notificación marcada como leída' });
  } catch (error) {
    res.status(500).json({ message: 'Error al marcar notificación', error });
  }
};

