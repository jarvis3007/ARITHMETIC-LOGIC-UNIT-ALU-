`timescale 1ns / 1ps

module pipeline_tb;

    reg clk;
    reg rst;

    pipeline_processor dut (
        .clk(clk),
        .rst(rst)
    );

    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end
    
    initial begin
        $dumpfile("dump.vcd");
        $dumpvars(0, pipeline_tb);

        dut.instruction_memory[0] = {2'b10, 2'b01, 2'b00, 2'b00};
        dut.register_file[0] = 10;
        dut.instruction_memory[1] = {2'b10, 2'b10, 2'b00, 2'b00};
        dut.register_file[0] = 11;
        dut.instruction_memory[2] = {2'b00, 2'b11, 2'b01, 2'b10};

        dut.instruction_memory[10] = 8'd50;
        dut.instruction_memory[11] = 8'd25;

        rst = 1;
        #10;
        rst = 0;

        $monitor("Time=%0t | R0=%d, R1=%d, R2=%d, R3=%d", 
                 $time, dut.register_file[0], dut.register_file[1], dut.register_file[2], dut.register_file[3]);

        #100;
        $finish;
    end

endmodule