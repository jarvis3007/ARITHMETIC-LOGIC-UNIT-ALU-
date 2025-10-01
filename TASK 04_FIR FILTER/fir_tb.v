`timescale 1ns / 1ps

module fir_tb;

    reg clk;
    reg rst;
    reg signed [7:0] data_in_tb;
    wire signed [15:0] data_out_tb;

    fir_filter dut (
        .clk(clk),
        .rst(rst),
        .data_in(data_in_tb),
        .data_out(data_out_tb)
    );

    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

    initial begin
        $dumpfile("dump.vcd");
        $dumpvars(0, fir_tb);

        rst = 1;
        data_in_tb = 0;
        #10;
        rst = 0;
        #10;

        data_in_tb = 10;

        #100;
        $finish;
    end

    initial begin
        $monitor("Time=%0t | In = %d, Out = %d", $time, data_in_tb, data_out_tb);
    end

endmodule