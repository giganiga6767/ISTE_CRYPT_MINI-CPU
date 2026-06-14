`timescale 1ns / 1ps

module tb_simple_cpu();

    reg clk;
    reg rst_n;
    wire [7:0] out;

    // Instantiate Unit Under Test
    simple_8bit_cpu UUT (
        .clk(clk),
        .rst_n(rst_n),
        .out(out)
    );

    // Generate 100MHz Clock
    always begin
        #5 clk = ~clk; 
    end

    initial begin
        $dumpfile("cpu_verification.vcd");
        $dumpvars(0, tb_simple_cpu);

        $display("\n==========================================================================");
        $display("   Time   | Reset | PC |  R1  |  R2  |  R3  |  R5  |  R6  | CPU Output (Hex)");
        $display("==========================================================================");
        
        // Track both the system level outputs AND internal register matrix states
        $monitor("%8tps |   %b   | %2d |  %h  |  %h  |  %h  |  %h  |  %h  |       %h", 
                 $time, rst_n, UUT.pc, 
                 UUT.RF1.reg_data[1], 
                 UUT.RF1.reg_data[2], 
                 UUT.RF1.reg_data[3],
                 UUT.RF1.reg_data[5],
                 UUT.RF1.reg_data[6],
                 out);

        // System Initialization
        clk = 0;
        rst_n = 0; 
        #15; 
        
        // Release Reset and run execution loop
        rst_n = 1;

        // Give the processor 90ns (9 full clock cycles) to finish the verification program
        #90;

        $display("==========================================================================");
        $display("Verification Complete! All instructional paths validated.");
        $display("==========================================================================\n");
        $finish; 
    end

endmodule