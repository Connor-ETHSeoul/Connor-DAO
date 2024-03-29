import { buildModule } from "@nomicfoundation/hardhat-ignition/modules";

const ConnerDao = buildModule("ConnerDao", (m) => {
  const Dao = m.contract("ConnerDao");

  return { Dao };
});

export default ConnerDao;
