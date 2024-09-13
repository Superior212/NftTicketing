import { buildModule } from "@nomicfoundation/hardhat-ignition/modules";

const Address = "address";

const NftModule = buildModule("NftModule", (m) => {
  const owner = Address;

  const Nft = m.contract("NFT", [owner]);

  return { Nft };
});

export default NftModule;
