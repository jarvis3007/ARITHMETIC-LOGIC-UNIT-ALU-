module pipeline_processor(
    input clk,
    input rst
);

    reg [7:0] instruction_memory [15:0];
    reg [7:0] register_file [3:0];

    reg [3:0] pc;

    reg [7:0] if_id_instruction;

    wire [1:0] id_opcode = if_id_instruction[7:6];
    wire [1:0] id_rd = if_id_instruction[5:4];
    wire [1:0] id_rs1 = if_id_instruction[3:2];
    wire [1:0] id_rs2 = if_id_instruction[1:0];
    wire [7:0] id_read_data1 = register_file[id_rs1];
    wire [7:0] id_read_data2 = register_file[id_rs2];

    reg [1:0] id_ex_opcode;
    reg [1:0] id_ex_rd;
    reg [7:0] id_ex_read_data1;
    reg [7:0] id_ex_read_data2;

    reg [7:0] ex_alu_result;

    reg [1:0] ex_wb_opcode;
    reg [1:0] ex_wb_rd;
    reg [7:0] ex_wb_alu_result;

    localparam ADD  = 2'b00;
    localparam SUB  = 2'b01;
    localparam LOAD = 2'b10;

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            pc <= 0;
            if_id_instruction <= 0;
            id_ex_opcode <= 0; id_ex_rd <= 0; id_ex_read_data1 <= 0; id_ex_read_data2 <= 0;
            ex_wb_opcode <= 0; ex_wb_rd <= 0; ex_wb_alu_result <= 0;
            register_file[0] <= 0; register_file[1] <= 0; register_file[2] <= 0; register_file[3] <= 0;
        end else begin
            
            if (ex_wb_opcode == ADD || ex_wb_opcode == SUB || ex_wb_opcode == LOAD) begin
                register_file[ex_wb_rd] <= ex_wb_alu_result;
            end

            ex_wb_opcode <= id_ex_opcode;
            ex_wb_rd <= id_ex_rd;
            
            case (id_ex_opcode)
                ADD:  ex_alu_result = id_ex_read_data1 + id_ex_read_data2;
                SUB:  ex_alu_result = id_ex_read_data1 - id_ex_read_data2;
                LOAD: ex_alu_result = instruction_memory[id_ex_read_data1];
                default: ex_alu_result = 8'h00;
            endcase
            ex_wb_alu_result <= ex_alu_result;

            id_ex_opcode <= id_opcode;
            id_ex_rd <= id_rd;
            id_ex_read_data1 <= id_read_data1;
            id_ex_read_data2 <= id_read_data2;

            if_id_instruction <= instruction_memory[pc];
            pc <= pc + 1;

        end
    end

endmodule