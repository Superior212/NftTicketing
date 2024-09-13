import { buildModule } from "@nomicfoundation/hardhat-ignition/modules";


const NftTicketModule = buildModule("LockModule", (m) => {
  const EVENT_NFT_ADDRESS = "0x1234567890123456789012345678901234567890";

  const ticket = m.contract("Ticket", [EVENT_NFT_ADDRESS]);

  return { ticket };
});

export default NftTicketModule;
