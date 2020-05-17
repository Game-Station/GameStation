const path = require("path");
const HDWallet = require('truffle-hdwallet-provider');
const mnemonic = '<please add your mnemonic here>';

module.exports = {
  // See <http://truffleframework.com/docs/advanced/configuration>
  // to customize your Truffle configuration!
  contracts_build_directory: path.join(__dirname, "client/src/contracts"),
  networks: {
    develop: {
      port: 8545
    },
    kovan: {
       provider: () => new HDWallet(mnemonic, `https://kovan.infura.io/v3/b0814c44f1de43a1b2024f2c08f0eddc`),
       network_id: 42,       // Kocan's id
       gas: 5500000,        // Kovan has a lower block limit than mainnet
       confirmations: 2,    // # of confs to wait between deployments. (default: 0)
       timeoutBlocks: 200,  // # of blocks before a deployment times out  (minimum/default: 50)
       skipDryRun: true     // Skip dry run before migrations? (default: false for public nets )
     },
  }
};
