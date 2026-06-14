# ISTE Crypt Mini-CPU

An educational **8-bit custom microprocessor** designed in Verilog, featuring a custom **16-bit Instruction Set Architecture (ISA)**. 

---

> [!NOTE]
> This project was completed as part of the **ISTE NITK Summer Mentorship Program 2026**. 
> The core Verilog modules were provided by mentors with detailed explanations. The focus of this work was on deeply understanding the CPU architecture, integrating/extending hardware components, developing software toolchains, and completing the encryption pipeline.

## Key Contributions & Learnings
* **CPU Pipeline**: Explored and worked with the complete CPU pipeline (including the ALU, Register File, Control Unit, and overall Harvard architecture).
* **Encryption Assembly**: Designed and implemented the custom encryption/hashing program in assembly language.
* **Python Assembler**: Wrote the compiler utility ([assembler.py](file:///home/niranjan/Desktop/ISTE_CRYPT_MINI-CPU/FILES%20FOR%20ENCRYPTION%20TASK/assembler.py)) to convert assembly code into machine-readable hexadecimal instructions (`.hex`).
* **Simulation & Verification**: Ran comprehensive simulations using Icarus Verilog (`iverilog` & `vvp`) and debugged trace waveforms using GTKWave.
* **System Integration**: Debugged and verified the complete hardware-software co-design.

*This project greatly strengthened core fundamentals in Digital Electronics and Computer Architecture.*

---

## Table of Contents
1. [Architecture & Features](#architecture--features)
2. [Instruction Set Architecture (ISA)](#instruction-set-architecture-isa)
3. [Repository Structure](#repository-structure)
4. [Assembling & Running the Encryption Program](#assembling--running-the-encryption-program)
5. [Compilation & Simulation Guide](#compilation--simulation-guide)

---

## Architecture & Features

The design represents a classic Harvard-architecture-inspired microprocessor:
* **Word Widths**: 8-bit Data Bus / 16-bit Instruction Bus.
* **Program Counter (PC)**: 8-bit width, addressing up to 256 instruction slots.
* **Register File**: Parameterized file containing 14 general-purpose registers (`r0` to `r13`), each 8 bits wide. Supports 1 write port and 2 asynchronous read ports.
* **Arithmetic Logic Unit (ALU)**: Fully functional ALU supporting arithmetic/bitwise operations and calculating status flags (e.g., Carry/Borrow output).
* **Control Unit**: Decodes the 16-bit instruction word opcodes to route data paths and configure register writes dynamically.
* **Processor Status**: Tracks arithmetic overflow/carry flag and allows writing status bits directly to the output.

---

## Instruction Set Architecture (ISA)

Instructions are represented as **16-bit words** containing a 4-bit Opcode, and up to three 4-bit Register targets, or an immediate 8-bit value:

| Instruction Word Bitfield | Description |
|:---|:---|
| `[15:12]` | **Opcode** (4 bits) |
| `[11:8]` | **R1 / Dest Register** (4 bits) |
| `[7:4]` | **R2 / Source Register 1** (4 bits) *or* lower 4-bits of Immediate value |
| `[3:0]` | **R3 / Source Register 2** (4 bits) *or* lower 4-bits of Immediate value |

> [!NOTE]
> For the Load Byte (`LDB`) instruction, the immediate 8-bit value spans the combined fields `[7:4]` and `[3:0]` (bits `[7:0]`).

### Instruction Opcode Table

| Mnemonic | Hex Opcode | Syntax | Operation | Description |
|:---:|:---:|:---|:---|:---|
| **MVR** | `0` | `MVR r_dest, r_src` | `Reg[r_dest] <= Reg[r_src]` | Move register contents |
| **LDB** | `1` | `LDB r_dest, immediate_8bit` | `Reg[r_dest] <= immediate_8bit` | Load 8-bit byte into register |
| **STB** | `2` | `STB r_src` | `data_out <= Reg[r_src]` | Store byte to CPU Output port |
| **RDS** | `3` | `RDS r_dest` | `data_out <= {7'b0, carry_flag}` | Read processor status (Carry flag) to Output |
| **NOT** | `8` | `NOT r_dest, r_src` | `Reg[r_dest] <= ~Reg[r_src]` | Bitwise NOT |
| **AND** | `9` | `AND r_dest, r_src1, r_src2` | `Reg[r_dest] <= Reg[r_src1] & Reg[r_src2]` | Bitwise AND |
| **ORA** | `A` | `ORA r_dest, r_src1, r_src2` | `Reg[r_dest] <= Reg[r_src1] \| Reg[r_src2]` | Bitwise OR |
| **ADD** | `B` | `ADD r_dest, r_src1, r_src2` | `Reg[r_dest] <= Reg[r_src1] + Reg[r_src2]` | Addition (updates Carry) |
| **SUB** | `C` | `SUB r_dest, r_src1, r_src2` | `Reg[r_dest] <= Reg[r_src1] - Reg[r_src2]` | Subtraction (updates Borrow/Carry) |
| **XOR** | `D` | `XOR r_dest, r_src1, r_src2` | `Reg[r_dest] <= Reg[r_src1] ^ Reg[r_src2]` | Bitwise XOR |
| **INC** | `E` | `INC r_dest, r_src` | `Reg[r_dest] <= Reg[r_src] + 1` | Increment by 1 (updates Carry) |

---

## Repository Structure

```
ISTE_CRYPT_MINI-CPU/
├── README.md                          # Project Documentation
├── MODULES/                           # Standard hardware modules & tests
│   ├── alu.v                          # Arithmetic Logic Unit
│   ├── control_unit.v                 # Decoder and Control logic
│   ├── instruction_set.v              # ISA MACROS and defines
│   ├── instruction_memory.v           # ROM (hardcoded test vectors)
│   ├── reg.v                          # Register File (14 registers)
│   ├── top_module.v                   # CPU motherboard integration (contains all modules combined)
│   └── final_tb.v                     # Basic validation testbench (dumps cpu_verification.vcd)
├── FILES FOR ENCRYPTION TASK/         # Workspace for custom encryption tasks
│   ├── final.v                        # CPU motherboard configured to load ROM dynamically
│   ├── final_tb.v                     # Main execution testbench
│   ├── assembler.py                   # Python compiler for program.txt assembly
│   ├── program.txt                    # Input assembly instructions for Encryption
│   ├── machine_code.hex               # Output hex file generated by assembler.py
│   └── commands.txt                   # Execution logs / commands (scratchpad)
├── OUTPUTS/                           # Simulation dumps from basic module verification
│   ├── cpu_verification.vcd           # Waveform VCD file for GTKWave
│   ├── output                         # Compiled simulation binary
│   └── Screenshot...                  # Waveform confirmation screenshots
└── OUTPUTS OF ENCRYPTION TASK/        # Output artifacts from the encryption simulation
    ├── testbench                      # Compiled encryption simulation binary
    └── Screenshot...                  # Simulation results screenshot
```

---

## Assembling & Running the Encryption Program

The program under `FILES FOR ENCRYPTION TASK/program.txt` performs a small sequence of hashing operations:

```assembly
LDB r1, 42       ; Load 42 (0x2A) into r1
LDB r2, 18       ; Load 18 (0x12) into r2
LDB r3, 0F       ; Load 0F (0x0F) into r3
ADD r4, r1, r2   ; r4 = r1 + r2 = 60 (0x3C)
SUB r5, r1, r2   ; r5 = r1 - r2 = 24 (0x18)
XOR r6, r4, r5   ; r6 = 0x3C ^ 0x18 = 0x24 (36)
INC r7, r6       ; r7 = 0x24 + 1 = 0x25 (37)
AND r8, r7, r3   ; r8 = 0x25 & 0x0F = 0x05 (5)
STB r8           ; Output r8 to output pins (CPU Output Port: 05)
```

### 1. Compile Assembly Code
Translate the text-based assembly commands into machine hex values:
```bash
cd "FILES FOR ENCRYPTION TASK"
python3 assembler.py
```
This generates `machine_code.hex`, which contains:
```hex
1142
1218
130F
B412
C512
D645
E760
9873
2800
```

---

## Compilation & Simulation Guide

You can compile and run simulations using [Icarus Verilog](http://iverilog.icarus.com/) and view wave outputs in [GTKWave](https://gtkwave.sourceforge.net/).

### Running the Basic Module Verification
To compile and simulate the core CPU modules:
```bash
cd MODULES
iverilog -o cpu_sim top_module.v final_tb.v
vvp cpu_sim
```
This creates the dump file `cpu_verification.vcd`. View it with:
```bash
gtkwave cpu_verification.vcd
```

### Running the Encryption Task
To compile and simulate the dynamically-loaded encryption task:
```bash
cd "FILES FOR ENCRYPTION TASK"
iverilog -o testbench final.v final_tb.v
vvp testbench
```

The terminal output will display simulation details cycle-by-cycle:
```text
--- Booting up Custom 8-Bit CPU ---
Time: 0 | Reset: 0 | PC:   x | CPU Output Port: 8'hxx
Time: 12 | Reset: 1 | PC:   0 | CPU Output Port: 8'h00
Time: 15 | Reset: 1 | PC:   1 | CPU Output Port: 8'h00
Time: 25 | Reset: 1 | PC:   2 | CPU Output Port: 8'h00
Time: 35 | Reset: 1 | PC:   3 | CPU Output Port: 8'h00
Time: 45 | Reset: 1 | PC:   4 | CPU Output Port: 8'h00
Time: 55 | Reset: 1 | PC:   5 | CPU Output Port: 8'h00
Time: 65 | Reset: 1 | PC:   6 | CPU Output Port: 8'h00
Time: 75 | Reset: 1 | PC:   7 | CPU Output Port: 8'h00
Time: 85 | Reset: 1 | PC:   8 | CPU Output Port: 8'h00
Time: 95 | Reset: 1 | PC:   9 | CPU Output Port: 8'h05
--- Simulation Complete ---
```
