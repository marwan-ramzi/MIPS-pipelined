module decode_stage (
    input  wire          clk,
    input  wire          rst,
    input  wire  [31:0]  instrD,
    input  wire  [31:0]  pc_plus4D,
    input  wire          RegWriteW,
    input  wire  [4:0]   WriteRegW,
    input  wire  [31:0]  ResultW,
    input  wire  [31:0]  ALUOutM,
    input  wire          ForwardAD,
    input  wire          ForwardBD,
    input  wire          BranchD,
    input  wire          JumpD,
    output reg   [1:0]   PCSrcD,
    output wire  [31:0]  RD1D,
    output wire  [31:0]  RD2D,
    output wire  [4:0]   RsD,
    output wire  [4:0]   RtD,
    output wire  [4:0]   RdD,
    output wire  [31:0]  PCBranchD,
    output wire  [31:0]  SignImmD,
    output wire  [31:0]  JumpAdd
);

wire [31:0] mux1_out ;
wire [31:0] mux2_out ;
wire [31:0] shift_out_int ;
wire [27:0] pc_jump ;
wire        branchTrue ;

assign RsD = instrD[25:21] ;
assign RtD = instrD[20:16] ;
assign RdD = instrD[15:11] ;

//-----------REGISTER FILE------------//
Register_file dp0 (
    .A1(instrD[25:21]),
    .A2(instrD[20:16]),
    .A3(WriteRegW),
    .WD3(ResultW),
    .clk(clk),
    .reset(rst),
    .WE3(RegWriteW),
    .RD1(RD1D),
    .RD2(RD2D)
);

//----------------MUXs----------------//

MUX #(.WIDTH(32)) u0_mux (
    .IN1(RD1D),
    .IN2(ALUOutM),
    .sel(ForwardAD),
    .out(mux1_out)
);

MUX #(.WIDTH(32)) u1_mux (
    .IN1(RD2D),
    .IN2(ALUOutM),
    .sel(ForwardBD),
    .out(mux2_out)
);

// Comparing mux outputs 

assign branchTrue = (mux1_out == mux2_out) ? 'b1 : 'b0 ;

always @(*)
begin
    //PCSrcD[0] = ( (mux1_out == mux2_out) && BranchD ) ;
    PCSrcD[0] = ( branchTrue && BranchD ) ;
    PCSrcD[1] = JumpD ;
end

//---------------ADDER---------------//

Adder u0_Adder (                     //adder for the branch
    .A(shift_out_int),
    .B(pc_plus4D),
    .C(PCBranchD)
);

//------------SIGN EXTEND------------//

sign_extend u0_sign_extend (
    .instr(instrD[15:0]),
    .signlmm(SignImmD)
);

//-------------SHIFTERS--------------//

shift_left_twice #(.bit_size(32)) u0_shift_left_twice ( //shift of branch
    .in(SignImmD),
    .out(shift_out_int)
);

shift_left_twice #(.bit_size(28)) u1_shift_left_twice ( //shift of pc
    .in({2'b00,instrD[25:0]}),
    .out(pc_jump)
);

//getting the pc next address in case jump instruction
assign JumpAdd = { pc_plus4D[31:28], pc_jump } ;

endmodule