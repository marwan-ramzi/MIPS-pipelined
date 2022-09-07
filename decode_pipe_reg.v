module decode_pipe_reg (
    input wire          clk,
    input wire          rst,
    input wire          clr,
    input wire          RegWriteD,
    input wire          MemtoRegD,
    input wire          MemWriteD,
    input wire [2:0]    ALUControlD,
    input wire          ALUSrcD,
    input wire          RegDstD,
    input wire [4:0]    RsD,
    input wire [4:0]    RtD,
    input wire [4:0]    RdD,
    input wire [31:0]   RD1D,
    input wire [31:0]   RD2D,
    input wire [31:0]   SignImmD,
    output reg          RegWriteE,
    output reg          MemtoRegE,
    output reg          MemWriteE,
    output reg [2:0]    ALUControlE,
    output reg          ALUSrcE,
    output reg          RegDstE,
    output reg [4:0]    RsE,
    output reg [4:0]    RtE,
    output reg [4:0]    RdE,
    output reg [31:0]   RD1E,
    output reg [31:0]   RD2E,
    output reg [31:0]   SignImmE
);

always @(posedge clk or negedge rst)
begin
    if(!rst)
    begin
        RegWriteE   <= 'b0;
        MemtoRegE   <= 'b0;
        MemWriteE   <= 'b0;
        ALUControlE <= 'b0;
        ALUSrcE     <= 'b0;
        RegDstE     <= 'b0;
        RsE         <= 'b0;
        RtE         <= 'b0;
        RdE         <= 'b0;
        RD1E        <= 'b0;
        RD2E        <= 'b0;
        SignImmE    <= 'b0;
    end
    else if (clr)
    begin
        RegWriteE   <= 'b0;
        MemtoRegE   <= 'b0;
        MemWriteE   <= 'b0;
        ALUControlE <= 'b0;
        ALUSrcE     <= 'b0;
        RegDstE     <= 'b0;
        RsE         <= 'b0;
        RtE         <= 'b0;
        RdE         <= 'b0;
        RD1E        <= 'b0;
        RD2E        <= 'b0;
        SignImmE    <= 'b0;
    end
    else
    begin
        RegWriteE   <= RegWriteD;
        MemtoRegE   <= MemtoRegD;
        MemWriteE   <= MemWriteD;
        ALUControlE <= ALUControlD;
        ALUSrcE     <= ALUSrcD;
        RegDstE     <= RegDstD;
        RsE         <= RsD;
        RtE         <= RtD;
        RdE         <= RdD;
        RD1E        <= RD1D;
        RD2E        <= RD2D;
        SignImmE    <= SignImmD;
    end
end

endmodule