`default_nettype none

// ====================================================================
// --- MACROS & DEFINES ---
// ====================================================================
// ISA Opcodes 
`define MVR 4'b0000            // Move Register
`define LDB 4'b0001            // Load Byte into Register
`define STB 4'b0010            // Store Byte from Register
`define RDS 4'b0011            // Read (store) processor status

// ALU Opcodes 
`define NOT 4'b1000
`define AND 4'b1001
`define ORA 4'b1010
`define ADD 4'b1011
`define SUB 4'b1100
`define XOR 4'b1101
`define INC 4'b1110

// ALU Internal Routing Codes 
`define ALU_NOT  3'b000
`define ALU_AND  3'b001
`define ALU_ORA  3'b010
`define ALU_ADD  3'b011
`define ALU_SUB  3'b100
`define ALU_XOR  3'b101
`define ALU_INC  3'b110
