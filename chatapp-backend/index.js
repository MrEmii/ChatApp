const express = require('express');
const path = require('path');
require('dotenv').config();

//db server
const { db } = require('./db/config')

db().then(() => {

  // App de Express
  const app = express();

  app.use(express.json())

  // Node Server
  const server = require('http').createServer(app);
  module.exports.io = require('socket.io')(server);
  require('./sockets/socket');

  // Path público
  const publicPath = path.resolve(__dirname, 'public');
  app.use(express.static(publicPath));

  app.use("/auth", require("./routes/auth"));

  server.listen(process.env.PORT, (err) => {

    if (err) throw new Error(err);

    console.log('Servidor corriendo en puerto', process.env.PORT);

  });

});

