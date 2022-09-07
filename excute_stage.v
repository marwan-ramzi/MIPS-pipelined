module excute_stage (
    input  wire          RegDstE,
    input  wire          ALUSrcE,
    input  wire [2:0]    ALUControlE,
    input  wire [31:0]   RD1E,
    input  wire [31:0]   RD2E,
    input  wire [4:0]    RtE,
    input  wire [4:0]    RdE,
    input  wire [31:0]   SignImmE,
    input  wire [31:0]   ALUOutM,
    input  wire [31:0]   ResultW,
    input  wire [1:0]    ForwardAE,
    input  wire [1:0]    ForwardBE,
    output wire [31:0]   ALUOutE,
    output wire [31:0]   WriteDataE,
    output wire [4:0]    WriteRegE
);

//wire [31:0] SrcBE_in ;
wire [31:0] SrcBE ;
wire [31:0] SrcAE ;

MUX #(.WIDTH(5)) u0_mux (
    .IN1(RtE),
    .IN2(RdE),
    .sel(RegDstE),
    .out(WriteRegE)
);

MUX #(.WIDTH(32)) u1_mux (
    .IN1(WriteDataE),
    .IN2(SignImmE),
    .sel(ALUSrcE),
    .out(SrcBE)
);

MUX4 #(.WIDTH(32)) u0_mux4 (
    .IN1(RD1E),
    .IN2(ResultW),
    .IN3(ALUOutM),
    .IN4('b0),
    .sel(ForwardAE),
    .out(SrcAE)
);

MUX4 #(.WIDTH(32)) u1_mux4 (
    .IN1(RD2E),
    .IN2(ResultW),
    .IN3(ALUOutM),
    .IN4('b0),
    .sel(ForwardBE),
    .out(WriteDataE)
);

ALU u0_alu (
    .SrcA(SrcAE),
    .SrcB(SrcBE),
    .S(ALUControlE),
    .ALUResult(ALUOutE) 
);

endmodule