var express = require('express');
var bodyParser = require('body-parser');
var router = express.Router();
var pushNotification = require('../models/push');




router.post('/',[bodyParser.urlencoded(), bodyParser.json()], function(req, res) {
  // res.set('Content-Type','application/json');
  console.log("Received req: account");
  // console.log(req.body);

  // //parse req object
  // var arr = Object.keys(req.body);
  // var str = arr[0];
  // console.log(str);
  // var data = JSON.parse(str);
  // console.log(data);
  // // console.log(data.appleid);
  // // console.log(data.username);
  // var appleid = data.appleid;
  // var username = data.username;

    var options = { };

    var apnConnection = new apn.Connection(options);
var myDevice = new apn.Device("<30829bc2 34cfc1ec e6f6ad33 70dee3b6 b00e8b2c a41ca1ca a32cb10b ad7ba6dc>");

var note = new apn.Notification();

note.expiry = Math.floor(Date.now() / 1000) + 3600; // Expires 1 hour from now.
note.badge = 3;
note.sound = "ping.aiff";
note.alert = "\uD83D\uDCE7 \u2709 You have a new message";
note.payload = {'messageFrom': 'Caroline'};

apnConnection.pushNotification(note, myDevice);

  //pushNotification.pushTo("<30829bc2 34cfc1ec e6f6ad33 70dee3b6 b00e8b2c a41ca1ca a32cb10b ad7ba6dc>","John");
});

module.exports = router;