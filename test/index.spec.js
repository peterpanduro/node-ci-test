//var request = require('supertest');
import request from 'supertest';
var app = require('../src/index.js');describe('GET /', function() {
 it('respond with hello world', function(done) { //navigate to root and check the the response is "hello world"
 request(app).get('/').expect('hello world', done);
 });
});