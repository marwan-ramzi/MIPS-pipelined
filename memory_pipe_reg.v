module memory_pipe_reg (
    input wire          clk,
    input wire          rst,
    input wire          RegWriteM,
    input wire          MemtoRegM,
    input wire [31:0]   ReadDataM,
    input wire [31:0]   ALUOutM,
    input wire [4:0]    WriteRegM,
    output reg          RegWriteW,
    output reg          MemtoRegW,
    output reg [31:0]   ReadDataW,
    output reg [31:0]   ALUOutW,
    output reg [4:0]    WriteRegW
);

always @(posedge clk or negedge rst)
begin
    if(!rst)
    begin
        RegWriteW <= 'b0 ;
        MemtoRegW <= 'b0 ;
        ReadDataW <= 'b0 ;
        ALUOutW   <= 'b0 ;
        WriteRegW <= 'b0 ;
    end
    else
    begin
        RegWriteW <= RegWriteM ;
        MemtoRegW <= MemtoRegM ;
        ReadDataW <= ReadDataM ;
        ALUOutW   <= ALUOutM   ;
        WriteRegW <= WriteRegM ;
    end
end

endmodule