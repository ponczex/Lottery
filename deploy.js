const HDWalletProvider = require('truffle-hdwallet-provider');
const Web3 = require('web3');
const { interface, bytecode } = require('./compile');

const provider = new HDWalletProvider(
	'six range cat frozen trust seven mutual chat nurse chief smart thank',
	'https://rinkeby.infura.io/C2m2j7FMLgppBk6S7q5W'
);

const web3 = new Web3(provider);

const deploy = async () => {
	const accounts = await web3.eth.getAccounts();
	console.log('Attempting to deploy from account: ', accounts[0]);
	const result = await new web3.eth.Contract(JSON.parse(interface))
		.deploy({ data: bytecode })
		.send({ from: accounts[0], gas:'1000000'});
	console.log('Address of the deployed contract is: ', result.options.address);
};

deploy();
