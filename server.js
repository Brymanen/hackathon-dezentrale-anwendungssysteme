const express = require("express");
const path = require("path");
const app = express();

app.post('/frontend', (req, res) => {
  res.send('Hello from A!');
})


//for the parkingDuration.html use the following:
app.get("/", (req, res) => {
    res.sendFile(path.join(__dirname + "/frontend/parkingDuration.html"));
})

app.use('/',(req,res,next) => {
  res.sendFile(path.join(__dirname + "/frontend/parkingDuration.html"));
});

//for the verifyLicensePlate.html instead use the following:
// app.get("/", (req, res) => {
//     res.sendFile(path.join(__dirname + "/frontend/verifyLicensePlate.html"));
// })
//
// app.use('/',(req,res,next) => {
//   res.sendFile(path.join(__dirname + "/frontend/verifyLicensePlate.html"));
// });

const server = app.listen(5000);
const portNumber = server.address().port;
console.log(`port is open on ${portNumber}`);
