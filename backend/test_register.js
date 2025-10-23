const axios = require('axios');

async function testRegister() {
  try {
    const response = await axios.post('http://localhost:3001/api/register', {
      nombre: 'Prueba',
      email: 'prueba@correo.com',
      password: '123456',
      rol: 'docente'
    });
    console.log('Respuesta:', response.data);
  } catch (error) {
    if (error.response) {
      console.log('Error:', error.response.data);
    } else {
      console.log('Error:', error.message);
    }
  }
}

testRegister();
