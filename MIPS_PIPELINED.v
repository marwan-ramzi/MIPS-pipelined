module MIPS_PIPELINED (
    input  wire clk,
    input  wire rst,
    output wire [15:0] T_V
);

wire StallF ;
wire StallD ;
wire RegWriteD ;
wire MemtoRegD ;
wire MemWriteD ;
wire [2:0] ALUControlD ;
wire ALUSrcD ;
wire RegDstD ;
wire JumpD ;
wire BranchD ;
wire ForwardAD ;
wire ForwardBD ;
wire FlushE ;
wire [1:0] ForwardAE ;
wire [1:0] ForwardBE ;
wire RegWriteM ;
wire [4:0] RsD ;
wire [4:0] RtD ;
wire [4:0] RsE ;
wire [4:0] RtE ;
wire [5:0] opcode_cu ;
wire [5:0] funct_cu ;
wire [4:0] WriteRegE ;
wire RegWriteE ;
wire MemtoRegE ;
wire [4:0] WriteRegM ;
wire [4:0] WriteRegW ;
wire RegWriteW ;
wire MemtoRegM ;

data_path u0_data_path (
    .clk(clk),
    .rst(rst),
    .StallF(StallF),
    .StallD(StallD),
    .RegWriteD(RegWriteD),
    .MemtoRegD(MemtoRegD),
    .MemWriteD(MemWriteD),
    .ALUControlD(ALUControlD),
    .ALUSrcD(ALUSrcD),
    .RegDstD(RegDstD),
    .JumpD(JumpD),
    .BranchD(BranchD),
    .ForwardAD(ForwardAD),
    .ForwardBD(ForwardBD),
    .FlushE(FlushE),
    .ForwardAE(ForwardAE),
    .ForwardBE(ForwardBE),
    .RegWriteM(RegWriteM),
    .RsD(RsD) ,
    .RtD(RtD) ,
    .RsE(RsE) ,
    .RtE(RtE) ,
    .opcode_cu(opcode_cu),
    .funct_cu(funct_cu),
    .WriteRegE(WriteRegE),
    .RegWriteE(RegWriteE) ,
    .MemtoRegE(MemtoRegE) ,
    .WriteRegM(WriteRegM),
    .WriteRegW(WriteRegW),
    .RegWriteW(RegWriteW) ,
    .MemtoRegM(MemtoRegM),
    .T_V(T_V)
);

control_unit u0_control_unit (
    .opcode_cu(opcode_cu),
    .funct_cu(funct_cu),
    .jump_cu(JumpD),
    .mem_write_cu(MemWriteD),
    .reg_write_cu(RegWriteD),
    .reg_dest_cu(RegDstD),
    .alu_src_cu(ALUSrcD),
    .memtoreg_cu(MemtoRegD),
    .branch_cu(BranchD),
    .alu_control_cu(ALUControlD)
);

hazard_unit u0_hazard_unit (
    .BranchD(BranchD),
    .JumpD(JumpD),
    .RsD(RsD),
    .RtD(RtD),
    .RsE(RsE),
    .RtE(RtE),
    .WriteRegE(WriteRegE),
    .MemtoRegE(MemtoRegE),
    .RegWriteE(RegWriteE),
    .WriteRegM(WriteRegM),
    .RegWriteM(RegWriteM),
    .MemtoRegM(MemtoRegM),
    .WriteRegW(WriteRegW),
    .RegWriteW(RegWriteW),
    .StallF(StallF),
    .StallD(StallD),
    .ForwardAD(ForwardAD),
    .ForwardBD(ForwardBD),
    .FlushE(FlushE),
    .ForwardAE(ForwardAE),
    .ForwardBE(ForwardBE)
);

endmodule