# ISTE Crypt Mini-CPU

This is my project for the ISTE NITK Summer Mentorship Program 2026. It is a simple 8-bit microprocessor designed in Verilog with a custom 16-bit instruction set.

The core Verilog modules and the Python assembler script were provided by my mentors and seniors. I worked on understanding the architecture, writing the assembly program (`program.txt`) for the encryption task, and running the simulations to make sure everything works.

## What is in here?
* **MODULES/**: Contains the main Verilog modules like the ALU, control unit, register file, and a basic testbench.
* **FILES FOR ENCRYPTION TASK/**: Contains the files to run the encryption task, including the assembly code (`program.txt`), the Python assembler (`assembler.py`), and the Verilog testbench.

## Specs
* 8-bit data width, 16-bit instruction width.
* 14 general purpose registers (`r0` to `r13`).
* 8-bit Program Counter (PC).
* ALU supports: Add, Sub, And, Or, Xor, Not, Inc.
* Control unit decodes 16-bit instructions.

## Instruction Set (ISA)
Instructions are 16 bits:
* `[15:12]` - Opcode (4 bits)
* `[11:8]` - Destination Register
* `[7:4]` and `[3:0]` - Source registers or 8-bit immediate value (for LDB)

### Opcodes
| Mnemonic | Hex Opcode | Syntax | What it does |
|---|---|---|---|
| MVR | 0 | `MVR r_dest, r_src` | Copy r_src to r_dest |
| LDB | 1 | `LDB r_dest, value` | Load 8-bit value to r_dest |
| STB | 2 | `STB r_src` | Output r_src to CPU output port |
| RDS | 3 | `RDS r_dest` | Read carry flag into r_dest |
| NOT | 8 | `NOT r_dest, r_src` | Bitwise NOT |
| AND | 9 | `AND r_dest, r_src1, r_src2` | Bitwise AND |
| ORA | A | `ORA r_dest, r_src1, r_src2` | Bitwise OR |
| ADD | B | `ADD r_dest, r_src1, r_src2` | Add two registers |
| SUB | C | `SUB r_dest, r_src1, r_src2` | Subtract two registers |
| XOR | D | `XOR r_dest, r_src1, r_src2` | Bitwise XOR |
| INC | E | `INC r_dest, r_src` | Increment by 1 |

---

## How to Run

Make sure you have `iverilog` and `python3` installed.

### 1. Running the basic CPU simulation
To test the core CPU modules:
```bash
cd MODULES
iverilog -o cpu_sim top_module.v final_tb.v
vvp cpu_sim
```
You can view the waveforms using GTKWave:
```bash
gtkwave cpu_verification.vcd
```

### 2. Running the Encryption Program
The assembly code is in `FILES FOR ENCRYPTION TASK/program.txt`. It loads some values, adds, subtracts, XORs, increments, and outputs the result.

First, run the Python assembler to convert `program.txt` into machine code (`machine_code.hex`):
```bash
cd "FILES FOR ENCRYPTION TASK"
python3 assembler.py
```

Then compile and run the simulation testbench:
```bash
iverilog -o testbench final.v final_tb.v
vvp testbench
```

This should print out the simulation logs cycle by cycle in the terminal showing the PC and CPU Output Port values.
