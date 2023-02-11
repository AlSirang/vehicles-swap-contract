import { HardhatUserConfig } from "hardhat/config";
import * as dotenv from "dotenv";
import "@nomicfoundation/hardhat-toolbox";
dotenv.config({});
const config: HardhatUserConfig = {
  solidity: "0.8.17",

  networks: {
    goerli: {
      url: process.env.GOERLI_URL || "",
      accounts:
        process.env.PRIVATE_KEY !== undefined ? [process.env.PRIVATE_KEY] : [],
    },
  },

  gasReporter: {
    enabled: process.env.REPORT_GAS !== undefined,
    currency: "USD",
  },

  etherscan: {
    apiKey: {
      goerli: process.env.ETHERSCAN_API_KEY || "",
    },
  },
};

export default config;
