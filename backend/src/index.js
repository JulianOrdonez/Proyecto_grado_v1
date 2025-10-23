const express = require('express');
const cors = require('cors');
const authRoutes = require('./routes/auth');
const reporteRoutes = require('./routes/reporte');
const comentarioRoutes = require('./routes/comentario');
const notificacionRoutes = require('./routes/notificacion');
const materialRoutes = require('./routes/material');

const app = express();
app.use(express.json());
app.use(cors());

app.use((req, res, next) => {
  console.log(`Petición recibida: ${req.method} ${req.url}`);
  next();
});

app.use('/api', authRoutes);
app.use('/api/reportes', reporteRoutes);
app.use('/api', comentarioRoutes);
app.use('/api', notificacionRoutes);
app.use('/api', materialRoutes);

const PORT = process.env.PORT || 3001;
app.listen(PORT, () => {
  console.log(`Servidor backend escuchando en el puerto ${PORT}`);
});
