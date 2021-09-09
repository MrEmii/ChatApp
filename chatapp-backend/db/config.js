const mongoose = require('mongoose');

const properties = {
  user: "chek",
  pass: "97wnhrljZY87LsuKJSDda88SZDUrw9nvfjcaUwwv7njARxvigXgEKmwQYrWkj1DqsWIQPIcQReSS1XW5b7Nd3Kl5bGCoZcQw6gb6QHptF1e3YhNpvH8jG0WUWqPxfxWk297rQK6WUgtiuBq5Vc17hcXDiGr7fTsT94ftxTx1mt05dYcgeNkyLz76HKkWhnTWS7fPiDz9Ybi3Vy5ltN9o5LgOoOhM8uKAQQtyl5UGWVkp7QANLi9NqE9OW6z6O5wm",
  ip: "e.undervolt.io",
  db: "admin",
  database: "chatapp",
}

const db = async () => {
  try {
    await mongoose.connect(`mongodb://${properties.user}:${properties.pass}@${properties.ip}:27017?authSource=admin&retryWrites=true&w=majority`, {
      useNewUrlParser: true,
      useCreateIndex: true,
      useUnifiedTopology: true,
      dbName: "chatapp"
    })
    console.log("DATA BASE ONLINEEEE");
  } catch (err) {
    console.log(err);
    throw new Error("Re trolo el error")
  }
}

module.exports = {
  db
}