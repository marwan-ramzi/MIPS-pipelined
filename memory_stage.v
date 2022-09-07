module memory_stage (
    input wire           clk,
    input wire           rst,
    input wire           MemWriteM,
    input wire  [31:0]   ALUOutM,
    input wire  [31:0]   WriteDataM,
    output wire [31:0]   ReadDataM,
    output wire [15:0]   T_V
);

data_memory u0_data_memory (
    .clk_mem(clk),
    .wr(MemWriteM),
    .reset_mem(rst), 
    .A(ALUOutM),
    .WD(WriteDataM),
    .RD(ReadDataM),
    .T_V(T_V)
);

endmodule