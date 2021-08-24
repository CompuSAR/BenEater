`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08/24/2021 06:23:14 PM
// Design Name: 
// Module Name: IOBufBus
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


module IOBufBus#(
    parameter Bits = 8
)
(
    input [Bits-1:0] I,
    input [Bits-1:0] T,
    output [Bits-1:0] O,
    inout [Bits-1:0] IO
    );

generate
  genvar i;
  for (i=0; i<Bits; i=i+1) begin // : dff
    IOBUF ioBuf(
        .O(O[i]),
        .IO(IO[i]),
        .I(I[i]),
        .T(T[i])
      );
  end
endgenerate

endmodule
