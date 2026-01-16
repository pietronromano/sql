const express = require('express');
const ClienteRepo = require('../repos/cliente-repo');

const router = express.Router();

router.get('/clientes', async (req, res) => {
  // Run a query to get all clientes
  const clientes = await ClienteRepo.find();
 
  // Send the result back to the person
  // who made this request
  res.send(clientes);
});

router.get('/clientes/:id_cliente', async (req, res) => {
  const { id_cliente } = req.params;

  const cliente = await ClienteRepo.findById(id_cliente);

  if (cliente) {
    res.send(cliente);
  } else {
    res.sendStatus(404);
  }
});

router.post('/clientes', async (req, res) => {
  const { nombres, apellidos, nif, fechaAlta, activo, comentarios } = req.body;

  const cliente = await ClienteRepo.insert(nombres, apellidos, nif, fechaAlta, activo, comentarios);

  res.send(cliente);
});

router.put('/clientes/:id_cliente', async (req, res) => {
  const { id_cliente } = req.params;
  const { nombres, apellidos } = req.body;

  const cliente = await ClienteRepo.update(id_cliente, nombres, apellidos);

  if (cliente) {
    res.send(cliente);
  } else {
    res.sendStatus(404);
  }
});

router.delete('/clientes/:id_cliente', async (req, res) => {
  const { id_cliente } = req.params;

  const cliente = await ClienteRepo.delete(id_cliente);

  if (cliente) {
    res.send(cliente);
  } else {
    res.sendStatus(404);
  }
});

module.exports = router;
