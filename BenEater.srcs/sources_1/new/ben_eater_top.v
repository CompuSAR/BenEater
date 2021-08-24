`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Shachar Shemesh
// 
// Create Date: 08/20/2021 10:52:27 PM
// Design Name: 
// Module Name: ben_eater_top
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module ben_eater_top(
    input clock50Mhz,
    input nReset,
    output [7:0] port_a,
    inout [7:0] port_b
    );

localparam ClockDivider = 50; // 50Mhz to 1Mhz
reg clock1Mhz;
reg [$clog2(ClockDivider)-1:0]clock1MhzDivider;

initial
begin
    clock1Mhz = 1;
    clock1MhzDivider = 0;
end

always@( posedge clock50Mhz )
begin
    clock1MhzDivider <= clock1MhzDivider+1;
    
    if( clock1MhzDivider==ClockDivider ) begin
        clock1Mhz <= 0;
        clock1MhzDivider <= 1;
    end else if( clock1MhzDivider==(ClockDivider/2) ) begin
        clock1Mhz <= 1;
    end
end

wire [15:0] addressBus;
wire [7:0] dataBusToCpu;
wire [7:0] dataBusFromCpu;
wire writeEnable;

wire [7:0]portAout, portAin, portAmask;
wire [7:0]portBout, portBin, portBmask;

via6522 via(
    .phi2(clock1Mhz),
    
    .cs( addressBus[15:13] == 3 ), // We can tighten it to adderssBus[15:4]==12'x600
    .nReset( nReset ),
    .rs( addressBus[3:0] ),
    .rWb( writeEnable ),
    
    .dataIn( dataBusFromCpu ),
    .dataOut( dataBusToCpu ),
    
    .paOut(portAout),
    .paIn(port_a),
    .paMask(portAmask),

    .pbOut(portBout),
    .pbIn(portBin),
    .pbMask(portBmask)
);

generate
  genvar i;
  for (i=0; i<8; i=i+1) begin // : dff
    IOBUF ioBufA(
        .O(portAin[i]),
        .IO(port_a[i]),
        .I(portAout[i]),
        .T(portAmask[i])
      );
    IOBUF ioBufB(
        .O(portBin[i]),
        .IO(port_b[i]),
        .I(portBout[i]),
        .T(portBmask[i])
      );
  end
endgenerate

endmodule
