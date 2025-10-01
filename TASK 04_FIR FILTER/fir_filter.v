module fir_filter(
    input clk,
    input rst,
    input signed [7:0] data_in,
    output reg signed [15:0] data_out
);

    reg signed [7:0] x_n1, x_n2;

    localparam H0 = 1;
    localparam H1 = 2;
    localparam H2 = 1;

    wire signed [15:0] term0, term1, term2;

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            x_n1 <= 0;
            x_n2 <= 0;
        end else begin
            x_n1 <= data_in;
            x_n2 <= x_n1;
        end
    end

    assign term0 = data_in * H0;
    assign term1 = x_n1 * H1;
    assign term2 = x_n2 * H2;

    always @(*) begin
        data_out = term0 + term1 + term2;
    end

endmodule