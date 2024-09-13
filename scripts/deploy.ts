import { ethers } from "hardhat";

async function main() {
  // Get the list of signers
  const [deployer] = await ethers.getSigners();

  // Deploy the NFT contract with the deployer's address as a constructor argument
  const nft = await ethers.deployContract("NFT", [deployer.address]);

  // Wait for the deployment to be mined
  await nft.waitForDeployment();

  // Log the deployed contract address
  console.log("NFT Contract Deployed at " + nft.target);
}

// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
