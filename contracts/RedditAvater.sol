// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "../node_modules/@openzeppelin/contracts/token/ERC1155/ERC1155.sol";
import "../node_modules/@openzeppelin/contracts/utils/Counters.sol";
import "../node_modules/@openzeppelin/contracts/utils/Strings.sol";

contract RedditAvatar is ERC1155 {
    using Counters for Counters.Counter;
    Counters.Counter private _tokenCounter;

    uint256 public constant SAVATHUN = 1;
    uint256 public constant DEER = 2;

    string baseMetadataURIPrefix;
    string baseMetadataURISuffix;

    // コンストラクタで初期値を設定
    constructor() ERC1155(""){
        baseMetadataURIPrefix = "https://raw.githubusercontent.com/otampy3184/metadata-okuyo/main/image/reddit-avatar";
        baseMetadataURISuffix = ".png";

        _mint(msg.sender, SAVATHUN, 100, "");
    }

    function uri(uint256 _id) public view override returns (string memory) {
    // "https://~~~" + tokenID + ".json" の文字列結合を行っている
	// OpenSeaはここのメタデータを読み取ることで画像等を表示している
        return string(abi.encodePacked(
            baseMetadataURIPrefix,
            Strings.toString(_id),
            baseMetadataURISuffix
        ));
    }
    
    // 指定量をmsg.senderに対してmintする実装(親機能呼び出し)
    function mint(uint256 _id, uint256 _amount) public {
        _mint(msg.sender, _id, _amount, "");
    }

    // mint()のバッチ処理版
    function mintBatch(uint256[] memory _ids, uint256[] memory _amounts) public {
        _mintBatch(msg.sender, _ids, _amounts, "");
    }

    // URIを後から書き換える用
    function setMetadataURI(string memory _prefix, string memory _suffix) public {
        baseMetadataURIPrefix = _prefix;
        baseMetadataURISuffix = _suffix;
    }
}
