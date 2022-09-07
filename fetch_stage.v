module fetch_stage(
    input  wire         clk,
    input  wire         rst,
    input  wire         StallF,
    input  wire [1:0]   PCSrcD,
    input  wire [31:0]  PCBranchD,
    input  wire [31:0]  JumpAdd,
    output wire [31:0]  instrF,
    output wire [31:0]  pc_plus4F
);

wire [31:0] PCF ;
wire [31:0] pc_input ;


MUX4 #(.WIDTH(32)) u0_mux4 (
    .IN1(pc_plus4F),
    .IN2(PCBranchD),
    .IN3(JumpAdd),
    .IN4('b0),
    .sel(PCSrcD),
    .out(pc_input)
);

pc_wb_pipe_reg u0_pc_wb_pipe_reg (
    .clk(clk),
    .reset(rst),
    .en(StallF),
    .pc_input(pc_input),
    .pc_output(PCF)
    );


Adder u0_Adder (                     //plus 4 for 32 bit instructions
    .A(PCF),
    .B(32'd4),
    .C(pc_plus4F)
);

instr_mem u0_instr_mem (
    .pc(PCF),
    .instr(instrF)
);

endmodule