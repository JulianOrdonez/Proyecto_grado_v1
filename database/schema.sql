CREATE TABLE roles (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL UNIQUE
);

CREATE TABLE usuarios (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL,
    rol_id INT,
    FOREIGN KEY (rol_id) REFERENCES roles(id)
);

CREATE TABLE dispositivos (
    id INT AUTO_INCREMENT PRIMARY KEY,
    tipo VARCHAR(50) NOT NULL,
    ubicacion VARCHAR(100) NOT NULL,
    estado VARCHAR(20) NOT NULL,
    consumo DECIMAL(10,2) DEFAULT 0
);

CREATE TABLE reportes (
    id INT AUTO_INCREMENT PRIMARY KEY,
    usuario_id INT,
    salon VARCHAR(50) NOT NULL,
    descripcion TEXT,
    estado VARCHAR(20) DEFAULT 'pendiente',
    fecha DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (usuario_id) REFERENCES usuarios(id)
);

CREATE TABLE logs_consumo (
    id INT AUTO_INCREMENT PRIMARY KEY,
    dispositivo_id INT,
    timestamp DATETIME DEFAULT CURRENT_TIMESTAMP,
    consumo DECIMAL(10,2),
    FOREIGN KEY (dispositivo_id) REFERENCES dispositivos(id)
);

