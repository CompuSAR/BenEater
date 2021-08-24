`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08/24/2021 05:57:15 PM
// Design Name: 
// Module Name: clock_divider
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


module clock_divider#(
    parameter ClocksHigh=1, parameter ClocksLow=1
)
(
    input clock_in,
    output reg clock_out
    );

localparam MaxDivider = ClocksHigh > ClocksLow ? ClocksHigh : ClocksLow;

reg [$clog2( MaxDivider - 1 ):0]counter;

initial
begin
    counter=0;
    clock_out=0;
end

always@( posedge clock_in )
begin
    counter <= counter+1;
    if( clock_out )
    begin
        if( counter==ClocksHigh-1 )
        begin
            counter <= 0;
            clock_out <= 0;
        end
    end else begin
        if( counter==ClocksLow-1 )
        begin
            counter <= 0;
            clock_out <= 1;
        end
    end
end

endmodule
