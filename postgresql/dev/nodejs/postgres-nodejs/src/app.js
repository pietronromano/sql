const express = require('express');
const clientesRouter = require('./routes/clientes');

module.exports = () => {
  const app = express();

  app.use(express.json());
  app.use(clientesRouter);

  return app;
};
