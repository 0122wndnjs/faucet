// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.9.0;

contract Storage {
  
    mapping(uint => uint) public aa; // slot 0
    mapping(address => uint) public bb; // slot 1

    uint[] public cc; // slot 2

    // keccak256(key . slot)

    uint8 public a = 7; // 1 byte
    uint16 public b = 10; // 2bytes
    address public c = 0x648FaaD551af1DA6d6556f0E3C41B37B6055bAD1; // 20bytes
    bool d = true; // 1 byte
    uint64 public e = 15; // 8bytes
    // 32 bytes, all values will be stored in slot 3

    // 0x 0f 01 648faad551af1da6d6556f0e3c41b37b6055bad1 000a 07

    uint256 public f = 200; // 32bytes -> slot 4

    uint8 public g = 40; // 1byte -> slot 5

    uint256 public h = 789; // 32bytes -> slot 6

    constructor() {
        cc.push(1);
        cc.push(10);
        cc.push(100);
        
        aa[2] = 4;
        aa[3] = 10;

        bb[0xA1cFce04e9522E963E8448c53Dc5742283a6d59a] = 100;
    }

}

// 0x0000000000000000000000000xA1cFce04e9522E963E8448c53Dc5742283a6d59a0000000000000000000000000000000000000000000000000000000000000001

// 353c2260ea5b27b1040b181301ea5e1a74ee25367e94b9ae008da1900dd92d74

// 11010100111100001000100110000011101010010110110010011110110001000001000000101100011000000100110000000111101010010111100001101001110100111011100010010100110110011111101001010010111001101011100000000010001101101000011001000000001101110110010010110101110100