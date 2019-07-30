#!/usr/bin/env node

var amqp = require("amqplib/callback_api");
var mysql = require("mysql");

// info my lab
var RABBITMQ_HOST = process.env.RABBITMQ_HOST || "rabbitmq";
var RABBITMQ_PORT = process.env.RABBITMQ_PORT || 5672;
var RABBITMQ_QUEUE = process.env.RABBITMQ_QUEUE || "hello";

// info my lab
var db = mysql.createConnection({
  host: process.env.MYSQL_HOST || "mysql",
  user: process.env.MYSQL_USER || "root",
  // add password export env or password config
  password: process.env.MYSQL_PASSWORD || "teste12321",
  database: process.env.MYSQL_DB || "hello"
});

console.log(
  "Connecting to RabbitMQ at %s port %s...",
  RABBITMQ_HOST,
  RABBITMQ_PORT
);

//
var url = "amqp://teste:teste12321@" + RABBITMQ_HOST + ":" + RABBITMQ_PORT + "/";

// All parameters necessary to connect and use
amqp.connect(url, function(err, conn) {
  console.log("Connected to RabbitMQ at %s", url);

  // this will fail if the queue is still not ready to accept consumers!
  conn.createChannel(
    function(err, ch) {
      if (err) throw err;
      ch.assertQueue(RABBITMQ_QUEUE, { durable: false });
      console.log("Consuming queue: %s", RABBITMQ_QUEUE);

      ch.consume(RABBITMQ_QUEUE, function(msg) {
        console.log("Received message: %s", msg.content.toString());
        db.query(
	  //
          'INSERT INTO Messages SET ?',
          { message: msg.content.toString() },
	  function(err, result) {
            if (err) throw err;
            console.log(result);
          }
        );
      });
    },
    { noAck: true }
  );
});

