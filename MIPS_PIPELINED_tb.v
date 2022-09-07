`timescale 1ns/1ps

module MIPS_PIPELINED_tb ();

reg clk, rst ;
wire [15:0] T_V ;

parameter clock_period = 100 ;

MIPS_PIPELINED DUT (
    .clk(clk),
    .rst(rst),
    .T_V(T_V)
);

always # (clock_period/2) clk = ~clk;

initial 
begin

clk = 'b0 ;
rst = 'b1 ;

#30
rst = 1'b0;    // rst is activated
#60
rst = 1'b1;    // rst is deactivated

$monitor("Test value = %d", T_V);
    

#(clock_period*100)

$stop;

end

endmodule