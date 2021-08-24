`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08/20/2021 11:02:35 PM
// Design Name: 
// Module Name: test_ben_eater
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


module test_ben_eater(

    );

reg clock;

ben_eater_top eater(
    .clock50Mhz(clock)
    );

initial
begin
    clock = 0;
    forever begin
        #10 clock = ~clock;
    end
end

endmodule
