`default_nettype none
`timescale 1ns/1ps

module sum_8(in,out,c);
input wire [7:0] in;
output logic [2:0] out;
output logic c;


logic [3:0] add1s, add1c;

// 4 || adders 
adder_1 #(.W(4)) add1( in[7:4], in[3:0], 4'b0000, add1s, add1c);


logic [1:0] add2_0s, add2_1s;
logic add2_0c, add2_1c;

// {} concats into a bus

adder_n #(.N(2)) add2_0({add1c[0], add1s[0]},{add1c[1], add1s[1]},1'b0,add2_0s,add2_0c);
adder_n #(.N(2)) add2_1({add1c[2], add1s[2]},{add1c[3], add1s[3]},1'b0,add2_1s,add2_1c);


//       3 wide    concat carry and sum                  no carry in and send it away
adder_n #(.N(3)) add3({add2_0c, add2_0s},{add2_1c, add2_1s},1'b0,out,c);

endmodule