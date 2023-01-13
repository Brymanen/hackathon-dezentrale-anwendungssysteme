var verifyLicensePlate;

function startApp() {

  //var licensePlateAddress = "LICENSE_PLATE_ADDRESS";
  //verifyLicensePlate = new web3js.eth.Contract(licensePlateABI, licensePlateAddress);

  //$("#buttonLicensePlate").click(function() {
  //  displayOwner();
  //});

  $("#buttonLicensePlate").click(function() {
    helloWorld();
  });

  $("#buttonLicensePlate").click(function() {
    getOwner().then(function(owner){
      displayOwner(owner);
    });
  });

}

function helloWorld() {
  alert("Hello World");
}

function displayOwner(owner) {
  alert("displayOwner was called");
  $("#output").text(owner);
}

function getOwner() {
  return verifyLicensePlate.methods.owner().call()
}

window.addEventListener('load', function() {
  //const web3 = new Web3(Web3.givenProvider || "ws://localhost:8545");
  // Checking if Web3 has been injected by the browser (Mist/MetaMask)
  if (typeof web3 !== 'undefined') {
    // Use Mist/MetaMask's provider
    web3js = new Web3(web3.currentProvider);
  } else {
    // Handle the case where the user doesn't have web3. Probably
    // show them a message telling them to install Metamask in
    // order to use our app.
  }

  // Now you can start your app & access web3js freely:
  startApp()

})
