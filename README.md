# Deploy my reddit avatar on Rinkeby test network as NFT(and it also Fungible)
> Smart contract framework => Truffle

> Token Standard => ERC1155(openzeppelin)

> Ethereum test network => Rinkeby

# how to start 
install truffle and start truffle project
```
$ npm install -g truffle
$ truffle init
```

install ERC1155 contract from @openzeppelin
```
$ npm install @openzeppelin/contracts
```

create test contract overrides ERC1155.sol
```javascript
// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "../node_modules/@openzeppelin/contracts/token/ERC1155/ERC1155.sol";
import "../node_modules/@openzeppelin/contracts/utils/Counters.sol";
import "../node_modules/@openzeppelin/contracts/utils/Strings.sol";

contract RedditAvatar is ERC1155 {
    using COunters for Counters.Couter;
    Counters.Counter private _tokenCounter;

    uint256 public constant SAVATHUN = 1;
    uint256 public constant DEER = 2;

    string baseMetadataURIPrefix;
    string baseMetadataURISuffix;

    // コンストラクタで初期値を設定
    constructor() ERC1155(""){
        baseMetadataURIPrefix = "gs://my-reddit-avatar.appspot.com/reddit-avatar.png";
        baseMetadataURISuffix = ".json?alt=media";

        _mint(msg.sender, SAVATHUN, 100, "");
    }
    
    // 指定量をmsg.senderに対してmintする実装(親機能呼び出し)
    function mint(uint256 _id, uint256 _amount) public {
        _mint(msg.sender, _id, _amount, "");
    }

    // mint()のバッチ処理版
    function mintBatch(uint256[] _ids, uint256[] _amounts) public {
        _mintBatch(msg.sender, _ids, _amounts, "");
    }

    // URIを後から書き換える用
    function setMetadataURI(string memory _prefix, string memory _suffix) public {
        baseMetadataURIPrefix = _prefix;
        baseMetadataURISuffix = _suffix;
    }   
}
```

create migration file
```javascript
    const Migrations = artifacts.require("RedditAvatar");

    module.exports = function (deployer) {
        deployer.deploy(Migrations);
    };  
```

install @truffle/hdwallet-provider
```
$ npm install @truffle/hdwallet-provider --save-dev
```

edit truffle-config.js to connect test network(rinkeby)
```javascript
    const HDWalletProvider = require('@truffle/hdwallet-provider');
    const mnemonic = "MY METAMASK MEMONIC";

    rinkeby: {
    provider: () => new HDWalletProvider(mnemonic, `https://rinkeby.infura.io/v3/MY_ACCESS_TOKENa`),
    network_id: 4,       // Rinkeby's id
    gas: 5500000,        // Rinkeby has a lower block limit than mainnet
    confirmations: 2,    // # of confs to wait between deployments. (default: 0)
    timeoutBlocks: 200,  // # of blocks before a deployment times out  (minimum/default: 50)
    skipDryRun: true     // Skip dry run before migrations? (default: false for public nets )
    },
```

compile and deploy contract 
```
$ truffle compile
$ truffle migrate --network rinkeby
~~~
2_reddit_avatar.js
==================

   Deploying 'RedditAvatar'
   ------------------------
   > transaction hash:    0x3db993499e0e2f489722fa876caecfa221f29b58006182b045bcd423dc11455e
   > Blocks: 1            Seconds: 9
   > contract address:    0x06B7aD5FaA54Ea5923aA10A1e4e6E7229A46cac5
   > block number:        10633597
   > block timestamp:     1651910332
   > account:             0xBE5a600FB461C78F0B262b410A7bd66545cd1C50
   > balance:             0.354509998747331663
   > gas used:            2751709 (0x29fcdd)
   > gas price:           12.458553041 gwei
   > value sent:          0 ETH
   > total cost:          0.034282312529897069 ETH

   Pausing for 2 confirmations...

   -------------------------------
   > confirmation number: 1 (block: 10633598)
   > confirmation number: 2 (block: 10633599)
   > Saving migration to chain.
   > Saving artifacts
   -------------------------------------
   > Total cost:     0.034282312529897069 ETH

Summary
=======
> Total deployments:   2
> Final cost
:          0.037272316152011469 ETH
```

check the contract address above and serch it on the Opensea
URL is `https://testnets.opensea.io/assets/CONTRACT_ADDRESS/0`






