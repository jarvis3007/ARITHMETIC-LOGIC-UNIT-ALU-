`timescale 1ns / 1ps

module ram_tb;

    reg clk_tb;
    reg wr_en_tb;
    reg [2:0] addr_tb;
    reg [7:0] data_in_tb;

    wire [7:0] data_out_tb;

    ram dut (
        .clk(clk_tb),
        .wr_en(wr_en_tb),
        .addr(addr_tb),
        .data_in(data_in_tb),
        .data_out(data_out_tb)
    );

    initial begin
        clk_tb = 0;
        forever #5 clk_tb = ~clk_tb;
    end

    initial begin
        $dumpfile("dump.vcd");
        $dumpvars(0, ram_tb);

        wr_en_tb = 1;
        
        addr_tb = 3'b000; data_in_tb = 8'd100;
        #10;

        addr_tb = 3'b001; data_in_tb = 8'd50;
        #10;

        addr_tb = 3'b101; data_in_tb = 8'd255;
        #10;

        wr_en_tb = 0;

        addr_tb = 3'b000;
        #10;
        
        addr_tb = 3'b001;
        #10;

        addr_tb = 3'b101;
        #10;

        $finish;
    end

endmodule