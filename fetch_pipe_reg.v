module fetch_pipe_reg (
    input wire          clk,
    input wire          rst,
    input wire          clr,
    input wire          en,
    input wire [31:0]   instrF,
    input wire [31:0]   pc_plus4F,
    output reg [31:0]   instrD,
    output reg [31:0]   pc_plus4D
);

always @(posedge clk or negedge rst)
begin
    if(!rst)
    begin
        instrD <= 'b0 ;
        pc_plus4D <= 'b0 ;
    end
    else if ((clr==1'b1) && !en)      //(clr && !en)
    begin
        instrD <= 'b0 ;
        pc_plus4D <= 'b0 ;
    end
    else if (!en)
    begin
        instrD <= instrF ;
        pc_plus4D <= pc_plus4F ;
    end
end

endmodule