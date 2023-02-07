import { ethers } from "hardhat";

async function main() {
  const lockedAmount = ethers.utils.parseEther("1");

  const VehiclesSwap = await ethers.getContractFactory("VehiclesSwap");
  const vehiclesSwap = await VehiclesSwap.deploy();

  await vehiclesSwap.deployed();

  console.log(`VehiclesSwap deployed to ${vehiclesSwap.address}`);
}

// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
