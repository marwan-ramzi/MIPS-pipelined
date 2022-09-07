module data_path (
    input wire clk,
    input wire rst,
    input wire StallF,
    input wire StallD,
    input wire RegWriteD,
    input wire MemtoRegD,
    input wire MemWriteD,
    input wire [2:0] ALUControlD,
    input wire ALUSrcD,
    input wire RegDstD,
    input wire JumpD,
    input wire BranchD,
    input wire ForwardAD,
    input wire ForwardBD,
    input wire FlushE,
    input wire [1:0] ForwardAE,
    input wire [1:0] ForwardBE,
    output wire RegWriteM,
    output wire [4:0] RsD ,
    output wire [4:0] RtD ,
    output wire [4:0] RsE ,
    output wire [4:0] RtE ,
    output wire [5:0] opcode_cu,
    output wire [5:0] funct_cu,
    output wire [4:0] WriteRegE,
    output wire RegWriteE ,
    output wire MemtoRegE ,
    output wire [4:0] WriteRegM,
    output wire [4:0] WriteRegW,
    output wire RegWriteW ,
    output wire MemtoRegM ,
    output wire [15:0] T_V
);

wire clr ;
wire [1:0] PCSrcD ;
wire [31:0] PCBranchD ;
wire [31:0] JumpAdd ;
wire [31:0] instrF ;
wire [31:0] pc_plus4F ;
wire [31:0] instrD ;
wire [31:0] pc_plus4D ;
//wire RegWriteW ;
//wire [4:0] WriteRegW ;
wire [31:0] ResultW ;
wire [31:0] ALUOutM ;
wire [31:0] RD1D ;
wire [31:0] RD2D ;
wire [31:0] RD1E ;
wire [31:0] RD2E ;
//wire [4:0] RsD ;
//wire [4:0] RtD ;
wire [4:0] RdD ;
//wire [4:0] RsE ;
//wire [4:0] RtE ;
wire [4:0] RdE ;
wire [31:0] SignImmD ;
//wire RegWriteE ;
//wire MemtoRegE ;
wire MemWriteE ;
wire [2:0] ALUControlE ;
wire ALUSrcE ;
wire RegDstE ;
wire [31:0] SignImmE ;
wire [31:0] ALUOutE ;
wire [31:0] WriteDataE ;
//wire [4:0]  WriteRegE ;
//wire MemtoRegM ;
wire MemWriteM ;
wire [31:0] WriteDataM ;
wire [31:0] ReadDataM ;
wire MemtoRegW ;
wire [31:0] ReadDataW ;
wire [31:0] ALUOutW ;

assign opcode_cu = instrD[31:26] ;
assign funct_cu  = instrD[5:0] ;
assign clr = PCSrcD[0] || PCSrcD[1] ;

fetch_stage u0_fetch_stage (
    .clk(clk),
    .rst(rst),
    .StallF(StallF),
    .PCSrcD(PCSrcD),
    .PCBranchD(PCBranchD),
    .JumpAdd(JumpAdd),
    .instrF(instrF),
    .pc_plus4F(pc_plus4F)
);

fetch_pipe_reg u0_fetch_pipe_reg (
    .clk(clk),
    .rst(rst),
    .clr(clr),
    .en(StallD),
    .instrF(instrF),
    .pc_plus4F(pc_plus4F),
    .instrD(instrD),
    .pc_plus4D(pc_plus4D)
);

decode_stage u0_decode_stage (
    .clk(clk),
    .rst(rst),
    .instrD(instrD),
    .pc_plus4D(pc_plus4D),
    .RegWriteW(RegWriteW),
    .WriteRegW(WriteRegW),
    .ResultW(ResultW),
    .ALUOutM(ALUOutM),
    .ForwardAD(ForwardAD),
    .ForwardBD(ForwardBD),
    .BranchD(BranchD),
    .JumpD(JumpD),
    .PCSrcD(PCSrcD),
    .RD1D(RD1D),
    .RD2D(RD2D),
    .RsD(RsD),
    .RtD(RtD),
    .RdD(RdD),
    .PCBranchD(PCBranchD),
    .SignImmD(SignImmD),
    .JumpAdd(JumpAdd)
);

decode_pipe_reg u0_decode_pipe_reg (
    .clk(clk),
    .rst(rst),
    .clr(FlushE),
    .RegWriteD(RegWriteD),
    .MemtoRegD(MemtoRegD),
    .MemWriteD(MemWriteD),
    .ALUControlD(ALUControlD),
    .ALUSrcD(ALUSrcD),
    .RegDstD(RegDstD),
    .RsD(RsD),
    .RtD(RtD),
    .RdD(RdD),
    .RD1D(RD1D),
    .RD2D(RD2D),
    .SignImmD(SignImmD),
    .RegWriteE(RegWriteE),
    .MemtoRegE(MemtoRegE),
    .MemWriteE(MemWriteE),
    .ALUControlE(ALUControlE),
    .ALUSrcE(ALUSrcE),
    .RegDstE(RegDstE),
    .RsE(RsE),
    .RtE(RtE),
    .RdE(RdE),
    .RD1E(RD1E),
    .RD2E(RD2E),
    .SignImmE(SignImmE)
);

excute_stage u0_excute_stage (
    .RegDstE(RegDstE),
    .ALUSrcE(ALUSrcE),
    .ALUControlE(ALUControlE),
    .RD1E(RD1E),
    .RD2E(RD2E),
    .RtE(RtE),
    .RdE(RdE),
    .SignImmE(SignImmE),
    .ALUOutM(ALUOutM),
    .ResultW(ResultW),
    .ForwardAE(ForwardAE),
    .ForwardBE(ForwardBE),
    .ALUOutE(ALUOutE),
    .WriteDataE(WriteDataE),
    .WriteRegE(WriteRegE)
);

excute_pipe_reg u0_excute_pipe_reg (
    .clk(clk),
    .rst(rst),
    .RegWriteE(RegWriteE),
    .MemtoRegE(MemtoRegE),
    .MemWriteE(MemWriteE),
    .ALUOutE(ALUOutE),
    .WriteDataE(WriteDataE),
    .WriteRegE(WriteRegE),
    .RegWriteM(RegWriteM),
    .MemtoRegM(MemtoRegM),
    .MemWriteM(MemWriteM),
    .ALUOutM(ALUOutM),
    .WriteDataM(WriteDataM),
    .WriteRegM(WriteRegM)
);

memory_stage u0_memory_stage (
    .clk(clk),
    .rst(rst),
    .MemWriteM(MemWriteM),
    .ALUOutM(ALUOutM),
    .WriteDataM(WriteDataM),
    .ReadDataM(ReadDataM),
    .T_V(T_V)
);

memory_pipe_reg u0_memory_pipe_reg (
    .clk(clk),
    .rst(rst),
    .RegWriteM(RegWriteM),
    .MemtoRegM(MemtoRegM),
    .ReadDataM(ReadDataM),
    .ALUOutM(ALUOutM),
    .WriteRegM(WriteRegM),
    .RegWriteW(RegWriteW),
    .MemtoRegW(MemtoRegW),
    .ReadDataW(ReadDataW),
    .ALUOutW(ALUOutW),
    .WriteRegW(WriteRegW)
);

MUX #(.WIDTH(32)) u0_mux (
    .IN1(ALUOutW),
    .IN2(ReadDataW),
    .sel(MemtoRegW),
    .out(ResultW)
);

endmodule