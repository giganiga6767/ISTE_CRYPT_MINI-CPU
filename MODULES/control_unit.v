module control_unit (
    input  wire [3:0] opcode, r1, r2, r3,
    output reg  [3:0] r_reg1, r_reg2, w_reg,
    output reg        write_en,
    output reg  [2:0] alu_op,
    output reg        is_ldb, is_mvr,
    output reg        mux_new_data_out, mux_processor_stat_data_out, mux_new_processor_stat
);
    always @(*) begin
        // Default zeroes to prevent latches
        r_reg1 = 4'b0000; r_reg2 = 4'b0000; w_reg = 4'b0000; write_en = 1'b0; alu_op = 3'b000;
        is_ldb = 1'b0; is_mvr = 1'b0; mux_new_data_out = 1'b0; 
        mux_processor_stat_data_out = 1'b0; mux_new_processor_stat = 1'b0;

        case(opcode)
            `MVR: begin r_reg1 = r1; w_reg = r2; write_en = 1; is_mvr = 1; end
            `LDB: begin w_reg = r1; write_en = 1; is_ldb = 1; end
            `STB: begin r_reg1 = r1; mux_new_data_out = 1; end
            `RDS: begin mux_processor_stat_data_out = 1; end
            
            `NOT: begin r_reg1 = r1; w_reg = r2; alu_op = `ALU_NOT; write_en = 1; mux_new_processor_stat = 1; end
            `AND: begin r_reg1 = r2; r_reg2 = r3; w_reg = r1; alu_op = `ALU_AND; write_en = 1; mux_new_processor_stat = 1; end
            `ORA: begin r_reg1 = r2; r_reg2 = r3; w_reg = r1; alu_op = `ALU_ORA; write_en = 1; mux_new_processor_stat = 1; end
            `ADD: begin r_reg1 = r2; r_reg2 = r3; w_reg = r1; alu_op = `ALU_ADD; write_en = 1; mux_new_processor_stat = 1; end
            `SUB: begin r_reg1 = r2; r_reg2 = r3; w_reg = r1; alu_op = `ALU_SUB; write_en = 1; mux_new_processor_stat = 1; end
            `XOR: begin r_reg1 = r2; r_reg2 = r3; w_reg = r1; alu_op = `ALU_XOR; write_en = 1; mux_new_processor_stat = 1; end
            `INC: begin r_reg1 = r2; w_reg = r1; alu_op = `ALU_INC; write_en = 1; mux_new_processor_stat = 1; end
        endcase
    end
endmodule
