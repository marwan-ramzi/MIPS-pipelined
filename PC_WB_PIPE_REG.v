module pc_wb_pipe_reg (
    input clk,
    input reset,
    input en,
    input [31:0]pc_input,
    output reg [31:0] pc_output
    );

always@(posedge clk)
    begin
        if(~reset)
            begin
                pc_output <= 32'b0;
            end
        else if (!en)
            begin
                pc_output <= pc_input;
            end             
    end
endmodule