+ 流水段

  + IF(取指令)

  + IF/ID 

    + include `instrDecoder

    | 信号名          | 方向 | 位宽   | 描述       |
    | --------------- | ---- | ------ | ---------- |
    | clk             | in   |        | 时钟       |
    | reset           | in   |        | 异步复位   |
    | pc_in           | in   | [31:0] | 下一条PC   |
    | instructure_in  | in   | [31:0] | 下一条指令 |
    | pc_out          | out  | [31:0] |            |
    | instructure_out | out  | [31:0] |            |
    | instr_code      | out  | [5:0]  | 指令码     |

  + ID(寄存器读、[beq、jr、j]）

    `include grf

    `include ext

    `include ctrlor

    | 信号名         | 方向 | 位宽   | 描述 |
    | -------------- | ---- | ------ | ---- |
    | clk            |      |        |      |
    | reset          |      |        |      |
    | pc_in          |      | [31:0] |      |
    | instructure_in |      | [31:0] |      |
    | instr_code_in  |      | [5:0]  |      |
    |                |      |        |      |
    |                |      |        |      |
    |                |      |        |      |
    |                |      |        |      |

  + EX(执行[计算]、ALU、乘除？)

  + Mem(内存访存[lw、sw])

  + WB(回写、寄存器写)

  + 