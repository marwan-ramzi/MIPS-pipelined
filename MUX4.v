module MUX4#(
    parameter WIDTH  =32  
) ( 
    input wire [WIDTH-1:0] IN1,IN2,IN3,IN4,
    input wire [1:0]       sel,
    output reg [WIDTH-1:0] out         
);

always @(*) begin
    case(sel)
    2'b00: out = IN1 ;
    2'b01: out = IN2 ;
    2'b10: out = IN3 ;
    2'b11: out = IN4 ;
    endcase
end
    
endmodule