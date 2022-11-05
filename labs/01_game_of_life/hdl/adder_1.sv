`default_nettype none
`timescale 1ns / 1ps
/*
  a 1 bit addder that we can daisy chain for 
  ripple carry adders
*/

module adder_1(a, b, c_in, sum, c_out);

parameter W = 1;// for width

input wire [(W-1):0] a, b, c_in;
output logic [(W-1):0] sum, c_out;

logic [(W-1):0] axorb;
always_comb  begin
  axorb = a^b;
  sum = (axorb^c_in);
  c_out = (a & b)|(axorb & c_in);
end

endmodule
