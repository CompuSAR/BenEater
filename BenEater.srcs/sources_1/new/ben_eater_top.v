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
    inout [7:0] port_a,
    inout [7:0] port_b
    );

localparam ClockDivider = 50; // 50Mhz to 1Mhz
wire clock1Mhz;

clock_divider#( ClockDivider/2, ClockDivider/2 ) clock1MhzGenerator( .clock_in(clock50Mhz), .clock_out(clock1Mhz) );

wire [15:0] addressBus;
wire [7:0] dataBusToCpu;
wire [7:0] dataBusFromCpu;
wire readWRITE;
wire nIRQ;

wire [7:0]portAout, portAin, portAmask;
wire [7:0]portBout, portBin, portBmask;

r6502_tc cpu(
    .clk_clk_i(clock1Mhz),
    .d_i(dataBusToCpu),
    .d_o(dataBusFromCpu),
    .a_o(addressBus),
    .wr_n_o(readWRITE),
    
    .irq_n_i(1),
    .nmi_n_i(1),
    .so_n_i(1), // Set overflow. A relic of times bygone.
    .rdy_i(1),
    .rst_rst_n_i(nReset)
);

via6522 via(
    .phi2(clock1Mhz),
    
    .cs( addressBus[15:13] == 3 ), // We can tighten it to adderssBus[15:4]==12'x600
    .nReset( nReset ),
    .rs( addressBus[3:0] ),
    .rWb( readWRITE ),
    
    .dataIn( dataBusFromCpu ),
    .dataOut( dataBusToCpu ),
    
    .paOut(portAout),
    .paIn(portAin),
    .paMask(portAmask),

    .pbOut(portBout),
    .pbIn(portBin),
    .pbMask(portBmask),
    
    .nIrq(nIRQ)
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
