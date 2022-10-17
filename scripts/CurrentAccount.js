const hre = require("hardhat");

async function main() {
  

  const CurrentAccount = await hre.ethers.getContractFactory("CurrentAccount");
  const currentAcc = await CurrentAccount.deploy();

  await currentAcc.deployed();

  console.log(
    `Contract ${CurrentAccount} deployed to Address ${currentAcc.address}`
  );
}

main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
