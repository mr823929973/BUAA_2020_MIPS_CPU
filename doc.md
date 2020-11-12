**addu, subu, ori, lw, sw, beq, lui, nop**





+ IFU

  + PC(REG)
  + IM(ROM)

  | clk        | in   |        |
  | ---------- | ---- | ------ |
  | rst        | in   |        |
  | branchAddr | in   | [31:0] |
  | branch     | in   |        |
  |            |      |        |
  | opCode     | out  | [31:0] |

  

+ GRF

  ![img](https://cscore.net.cn/assets/courseware/v1/ea64d5c0389309925ce6510cfb3ffdd9/asset-v1:Internal+B3I062410+2020_T1+type@asset+block/P0_L0_GRF_1.png)

  ![img](https://cscore.net.cn/assets/courseware/v1/9e36703823ed88754a7affeee41a3c41/asset-v1:Internal+B3I062410+2020_T1+type@asset+block/P0_L0_GRF_2.png)

+ ALU

  | srcA      | in   |        |
  | --------- | ---- | ------ |
  | srcB      | in   |        |
  | ALUop     | in   | [31:0] |
  | Zero      | out  |        |
  | ALUResult | out  | [31:0] |
  |           |      |        |

	+ op
  | 000  | A and B         |
  | ---- | --------------- |
  | 001  | A or B          |
  | 010  | A + B           |
  | 011  |                 |
  | 100  | A and $\bar{B}$ |
  | 101  | A or$\bar{B}$   |
  | 110  | A-B             |
  | 111  | /\*TO DO\*/     |

  

+ DM

  - 使用 RAM 实现，容量为 32bit * 32，应具有**异步复位**功能，复位值为0x00000000。
  - **起始地址：0x00000000**。
  - RAM 应使用双端口模式，即设置 RAM 的 **Data Interface** 属性为 **Separate load and store ports**。

+ EXT

  + 使用 Logisim 内置的 Bit Extender。

+ Controller

  ![img](https://cscore.net.cn/assets/courseware/v1/5b9cb88947ee44745aef98b41827389a/asset-v1:Internal+B3I062410+2020_T1+type@asset+block/P3_L0_T3_0.png)