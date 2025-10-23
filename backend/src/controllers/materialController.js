const db = require('../models/db');

exports.crearSolicitud = async (req, res) => {
  const { usuario_id, tipo_material, cantidad, descripcion } = req.body;
  if (!usuario_id || !tipo_material || !cantidad) {
    return res.status(400).json({ message: 'Usuario, tipo de material y cantidad son obligatorios' });
  }
  try {
    await db.query(
      'INSERT INTO solicitudes_materiales (usuario_id, tipo_material, cantidad, descripcion) VALUES (?, ?, ?, ?)',
      [usuario_id, tipo_material, cantidad, descripcion || null]
    );
    res.status(201).json({ message: 'Solicitud creada correctamente' });
  } catch (error) {
    res.status(500).json({ message: 'Error al crear solicitud', error });
  }
};

exports.obtenerSolicitudes = async (req, res) => {
  const { usuarioId } = req.query;
  try {
    const [solicitudes] = await db.query(
      'SELECT * FROM solicitudes_materiales WHERE usuario_id = ? ORDER BY fecha DESC',
      [usuarioId]
    );
    res.json(solicitudes);
  } catch (error) {
    res.status(500).json({ message: 'Error al obtener solicitudes', error });
  }
};

exports.actualizarSolicitud = async (req, res) => {
  const { id } = req.params;
  const { estado, fecha_resolucion } = req.body;
  try {
    await db.query(
      'UPDATE solicitudes_materiales SET estado = ?, fecha_resolucion = ? WHERE id = ?',
      [estado, fecha_resolucion, id]
    );
    res.json({ message: 'Solicitud actualizada correctamente' });
  } catch (error) {
    res.status(500).json({ message: 'Error al actualizar solicitud', error });
  }
};

