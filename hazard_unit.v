module hazard_unit (
    input wire BranchD,
    input wire JumpD,
    input wire [4:0] RsD,
    input wire [4:0] RtD,
    input wire [4:0] RsE,
    input wire [4:0] RtE,
    input wire [4:0] WriteRegE,
    input wire MemtoRegE,
    input wire RegWriteE,
    input wire [4:0] WriteRegM,
    input wire RegWriteM,
    input wire MemtoRegM,
    input wire [4:0] WriteRegW,
    input wire RegWriteW,
    output reg StallF,
    output reg StallD,
    output reg ForwardAD,
    output reg ForwardBD,
    output reg FlushE,
    output reg [1:0] ForwardAE,
    output reg [1:0] ForwardBE
);

reg lwstall ;
reg branchstall ;

// solving RAW data hazards by Forwarding SrcA from Memory or WB stage
always @(*)
begin
    if ( (RsE != 0) && (RsE == WriteRegM) && RegWriteM ) //( (RsE != 0) && (RsE == WriteRegM) && (RegWriteM) )
    ForwardAE = 2'b10 ;
    else if ( (RsE != 0) && (RsE == WriteRegW) && RegWriteW ) //( (RsE != 0) && (RsE == WriteRegW) && (RegWriteW) )
    ForwardAE = 2'b01 ;
    else
    ForwardAE = 2'b00 ;
end

// solving RAW data hazards by Forwarding SrcB from Memory or WB stage
always @(*)
begin
    if ( (RtE != 0) && (RtE == WriteRegM) && RegWriteM )
    ForwardBE = 2'b10 ;
    else if ( (RtE != 0) && (RtE == WriteRegW) && RegWriteW )
    ForwardBE = 2'b01 ;
    else
    ForwardBE = 2'b00 ;
end

//  solving RAW data hazards by stalling fetch and decode stages and flushing excute stage
always @(*)           //we stall the next instruction due to RAW hazard due to lw instruction
begin
    if ( ( (RsD == RtE) || (RtD == RtE) ) && MemtoRegE ) 
        lwstall = 1'b1 ;
    else
        lwstall = 1'b0 ;
end

always @(*)          //(solving control hazard) we stall the branch instruction due to RAW hazard as one of its srcs being changed  
begin
    if ( ( BranchD && RegWriteE && ( (WriteRegE == RsD) || (WriteRegE == RtD) ) ) || ( BranchD && MemtoRegM && ( (WriteRegM == RsD) || (WriteRegM == RtD) ) ) )
        branchstall = 1'b1 ;
    else
        branchstall = 1'b0 ;
end

always @(*)
begin
    if ( lwstall || branchstall )
    begin
        StallD = 1'b1 ;
        StallF = 1'b1 ;
        //FlushE = 1'b1 ;
    end
    else
    begin
        StallD = 1'b0 ;
        StallF = 1'b0 ;
        //FlushE = 1'b0 ;
    end
end

always @(*)
begin
    if ( lwstall || branchstall || JumpD )
    begin
        FlushE = 1'b1 ;
    end
    else
    begin
        FlushE = 1'b0 ;
    end
end

//  solving RAW data hazards due to branch instruction by forwading data in excution or memory stages
always @(*)
begin
    if ( (RsD != 0) && (RsD == WriteRegM) && (RegWriteM) )
    ForwardAD = 1'b1 ;
    else
    ForwardAD = 1'b0 ;
end

always @(*)
begin
    if ( (RtD != 0) && (RtD == WriteRegM) && (RegWriteM) )
    ForwardBD = 1'b1 ;
    else
    ForwardBD = 1'b0 ;
end

endmodule