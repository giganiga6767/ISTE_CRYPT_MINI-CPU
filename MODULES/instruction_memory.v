module inst_mem (
    input  wire [7:0]  addr,
    output wire [15:0] inst_out
);
    reg [15:0] rom [0:255];

    initial begin
        rom[8'd0] = 16'h1155; // LDB r1, 0x55  (Load 55 into r1)
        rom[8'd1] = 16'h0120; // MVR r1 to r2  (Copy 55 into r2)
        rom[8'd2] = 16'hb123; // ADD r2, r3 -> r1 (Add r2 + r3. Result: 55 + 00 = 55)
        rom[8'd3] = 16'h2100; // STB r1 (Push the value of r1 to the output pins!)
    end

    assign inst_out = rom[addr];
endmodule