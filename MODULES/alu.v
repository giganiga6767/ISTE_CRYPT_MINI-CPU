module alu #(
    parameter BIT_WIDTH_REG = 8
)(
   input      [BIT_WIDTH_REG-1:0] in1,
   input      [BIT_WIDTH_REG-1:0] in2,
   input      [2:0]               op,
   output reg [BIT_WIDTH_REG-1:0] out,
   output reg                     c
);
    reg [BIT_WIDTH_REG:0] temp;

    always @(*) begin
        case(op)
            `ALU_NOT: begin
                    out = ~in1;
                    c = 1'b0;
                    temp = {BIT_WIDTH_REG+1{1'bx}};
            end
            `ALU_AND: begin
                    out = in1 & in2;
                    c = 1'b0;
                    temp = {BIT_WIDTH_REG+1{1'bx}};
            end
            `ALU_ORA: begin
                    out = in1 | in2;
                    c = 1'b0;
                    temp = {BIT_WIDTH_REG+1{1'bx}};
            end
            `ALU_ADD: begin
                    temp = {1'b0, in1} + {1'b0, in2};
                    out = temp[BIT_WIDTH_REG-1:0];
                    c = temp[BIT_WIDTH_REG];
            end
            `ALU_SUB: begin
                    out = in1 - in2;
                    c = in1 < in2;
                    temp = {BIT_WIDTH_REG+1{1'bx}};
            end
            `ALU_XOR: begin
                    out = in1 ^ in2;
                    c = 1'b0;
                    temp = {BIT_WIDTH_REG+1{1'bx}};
            end
            `ALU_INC: begin
                    out = in1 + 1;
                    c = in1[7] & ~out[7];
                    temp = {BIT_WIDTH_REG+1{1'bx}};
            end
            default: begin
                    out = {BIT_WIDTH_REG{1'b0}};
                    c = 1'b0;
                    temp = {BIT_WIDTH_REG+1{1'bx}};
            end
        endcase
    end
endmodule