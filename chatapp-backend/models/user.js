const { Schema, model } = require('mongoose');

const SUser = Schema({
  nombre: {
    type: String,
    required: true
  },
  email: {
    type: String,
    required: true,
    unique: true
  },
  password: {
    type: String,
    required: true
  },
  online: {
    type: Boolean,
    default: false
  }
})

SUser.method('toJSON', function () {
  const { __v, _id, password, ...object } = this.toObject();

  object.id = _id;

  return object;
})

module.exports = model('User', SUser);