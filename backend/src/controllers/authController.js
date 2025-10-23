const db = require('../models/db');
const bcrypt = require('bcryptjs');

exports.register = async (req, res) => {
  const { nombre, email, password, rol } = req.body;
  if (!nombre || !email || !password || !rol) {
    return res.status(400).json({ message: 'Todos los campos son obligatorios' });
  }
  try {
    // Buscar el rol
    const [roles] = await db.query('SELECT id FROM roles WHERE nombre = ?', [rol]);
    if (roles.length === 0) {
      return res.status(400).json({ message: 'Rol no válido' });
    }
    const rol_id = roles[0].id;
    // Encriptar contraseña
    const hashedPassword = await bcrypt.hash(password, 10);
    // Insertar usuario
    await db.query('INSERT INTO usuarios (nombre, email, password, rol_id) VALUES (?, ?, ?, ?)', [nombre, email, hashedPassword, rol_id]);
    res.status(201).json({ message: 'Usuario registrado correctamente' });
  } catch (error) {
    if (error.code === 'ER_DUP_ENTRY') {
      return res.status(409).json({ message: 'El correo ya está registrado' });
    }
    res.status(500).json({ message: 'Error en el servidor', error });
  }
};

exports.login = async (req, res) => {
  console.log('Petición de login recibida:', req.body);
  const { email, password } = req.body;
  if (!email || !password) {
    return res.status(400).json({ message: 'Email y contraseña son obligatorios' });
  }
  try {
    const [users] = await db.query('SELECT u.*, r.nombre as rol FROM usuarios u JOIN roles r ON u.rol_id = r.id WHERE u.email = ?', [email]);
    if (users.length === 0) {
      return res.status(401).json({ message: 'Usuario no encontrado' });
    }
    const user = users[0];
    const validPassword = await bcrypt.compare(password, user.password);
    if (!validPassword) {
      return res.status(401).json({ message: 'Contraseña incorrecta' });
    }
    res.json({ id: user.id, nombre: user.nombre, email: user.email, rol: user.rol });
  } catch (error) {
    res.status(500).json({ message: 'Error en el servidor', error });
  }
};

exports.getUsuarios = async (req, res) => {
  try {
    const [usuarios] = await db.query(
      'SELECT u.id, u.nombre, u.email, r.nombre as rol FROM usuarios u JOIN roles r ON u.rol_id = r.id'
    );
    res.json(usuarios);
  } catch (error) {
    res.status(500).json({ message: 'Error al obtener usuarios', error });
  }
};

exports.cambiarRol = async (req, res) => {
  const { id } = req.params;
  const { rol } = req.body;
  if (!rol) {
    return res.status(400).json({ message: 'El rol es obligatorio' });
  }
  try {
    const [roles] = await db.query('SELECT id FROM roles WHERE nombre = ?', [rol]);
    if (roles.length === 0) {
      return res.status(400).json({ message: 'Rol no válido' });
    }
    const rol_id = roles[0].id;
    await db.query('UPDATE usuarios SET rol_id = ? WHERE id = ?', [rol_id, id]);
    res.json({ message: 'Rol actualizado correctamente' });
  } catch (error) {
    res.status(500).json({ message: 'Error al actualizar rol', error });
  }
};

exports.eliminarUsuario = async (req, res) => {
  const { id } = req.params;
  console.log('Intentando eliminar usuario con id:', id);
  try {
    const resultado = await db.query('DELETE FROM usuarios WHERE id = ?', [id]);
    console.log('Resultado de la consulta:', resultado);
    res.json({ message: 'Usuario eliminado correctamente' });
  } catch (error) {
    console.error('Error al eliminar usuario:', error);
    res.status(500).json({ message: 'Error al eliminar usuario', error });
  }
};
