module excute_pipe_reg (
    input wire          clk,
    input wire          rst,
    input wire          RegWriteE,
    input wire          MemtoRegE,
    input wire          MemWriteE,
    input wire [31:0]   ALUOutE,
    input wire [31:0]   WriteDataE,
    input wire [4:0]    WriteRegE,
    output reg          RegWriteM,
    output reg          MemtoRegM,
    output reg          MemWriteM,
    output reg [31:0]   ALUOutM,
    output reg [31:0]   WriteDataM,
    output reg [4:0]    WriteRegM
);

always @(posedge clk or negedge rst)
begin
    if(!rst)
    begin
        RegWriteM  <= 'b0 ;
        MemtoRegM  <= 'b0 ;
        MemWriteM  <= 'b0 ;
        ALUOutM    <= 'b0 ;
        WriteDataM <= 'b0 ;
        WriteRegM  <= 'b0 ;
    end
    else
    begin
        RegWriteM  <= RegWriteE  ;
        MemtoRegM  <= MemtoRegE  ;
        MemWriteM  <= MemWriteE  ;
        ALUOutM    <= ALUOutE    ;
        WriteDataM <= WriteDataE ;
        WriteRegM  <= WriteRegE  ;
    end
end

endmodule