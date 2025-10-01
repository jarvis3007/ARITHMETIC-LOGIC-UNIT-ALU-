module ram (
    input clk,
    input wr_en,
    input [2:0] addr,
    input [7:0] data_in,
    output reg [7:0] data_out
);

    reg [7:0] ram_memory [7:0];

    always @(posedge clk) begin
        if (wr_en) begin
            ram_memory[addr] <= data_in;
        end
        else begin
            data_out <= ram_memory[addr];
        end
    end

endmodule