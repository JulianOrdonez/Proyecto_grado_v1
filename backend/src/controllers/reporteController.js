const db = require('../models/db');

exports.crearReporte = async (req, res) => {
  const { usuario_id, salon, descripcion, estado, edificio, dependencia, tipo_aula, sillas } = req.body;
  console.log('Datos recibidos para crear reporte:', req.body);
  if (!usuario_id || !salon || !descripcion || !edificio || !dependencia || !tipo_aula || sillas === undefined || sillas === null) {
    return res.status(400).json({ message: 'Todos los campos son obligatorios' });
  }
  try {
    const resultado = await db.query(
      'INSERT INTO reportes (usuario_id, salon, descripcion, estado, edificio, dependencia, tipo_aula, sillas) VALUES (?, ?, ?, ?, ?, ?, ?, ?)',
      [usuario_id, salon, descripcion, estado || 'pendiente', edificio, dependencia, tipo_aula, sillas]
    );
    console.log('Resultado de la inserción:', resultado);
    res.status(201).json({ message: 'Reporte creado correctamente' });
  } catch (error) {
    console.error('Error al crear reporte:', error);
    res.status(500).json({ message: 'Error al crear reporte', error });
  }
};

exports.listarReportes = async (req, res) => {
  const { estado, fecha, aula, tipo_aula, usuario_id } = req.query;
  let sql = 'SELECT r.*, u.nombre as usuario FROM reportes r JOIN usuarios u ON r.usuario_id = u.id';
  const filtros = [];
  const params = [];
  if (estado) {
    filtros.push('r.estado = ?');
    params.push(estado);
  }
  if (fecha) {
    filtros.push('DATE(r.fecha) = ?');
    params.push(fecha);
  }
  if (aula) {
    filtros.push('r.salon LIKE ?');
    params.push(`%${aula}%`);
  }
  if (tipo_aula) {
    filtros.push('r.tipo_aula = ?');
    params.push(tipo_aula);
  }
  if (usuario_id) {
    filtros.push('r.usuario_id = ?');
    params.push(usuario_id);
  }
  if (filtros.length > 0) {
    sql += ' WHERE ' + filtros.join(' AND ');
  }
  sql += ' ORDER BY r.fecha DESC';
  try {
    const [reportes] = await db.query(sql, params);
    res.json(reportes);
  } catch (error) {
    res.status(500).json({ message: 'Error al obtener reportes', error });
  }
};

exports.actualizarEstado = async (req, res) => {
  const { id } = req.params;
  const { estado } = req.body;
  if (!estado) {
    return res.status(400).json({ message: 'El estado es obligatorio' });
  }
  try {
    await db.query('UPDATE reportes SET estado = ? WHERE id = ?', [estado, id]);
    res.json({ message: 'Estado actualizado correctamente' });
  } catch (error) {
    res.status(500).json({ message: 'Error al actualizar estado', error });
  }
};
