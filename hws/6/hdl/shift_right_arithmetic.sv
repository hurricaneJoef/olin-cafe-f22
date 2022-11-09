`timescale 1ns/1ps
`default_nettype none
module shift_right_arithmetic(in,shamt,out);
parameter N = 32; // only used as a constant! Don't feel like you need to a shifter for arbitrary N.

//port definitions
input  wire [N-1:0] in;    // A 32 bit input
input  wire [$clog2(N)-1:0] shamt; // Shift ammount
output wire [N-1:0] out; // The same as SRL, but maintain the sign bit (MSB) after the shift! 
// It's similar to SRL, but instead of filling in the extra bits with zero, we
// fill them in with the sign bit.
// Remember the *repetition operator*: {n{bits}} will repeat bits n times.
    mux32 #(.N(N)) mux1(in[31:0],{{1{in[31]}},in[31:1]},{{2{in[31]}},in[31:2]},{{3{in[31]}},in[31:3]},{{4{in[31]}},in[31:4]},{{5{in[31]}},in[31:5]},
    {{6{in[31]}},in[31:6]},{{7{in[31]}},in[31:7]},{{8{in[31]}},in[31:8]},{{9{in[31]}},in[31:9]},{{10{in[31]}},in[31:10]},
    {{11{in[31]}},in[31:11]},{{12{in[31]}},in[31:12]},{{13{in[31]}},in[31:13]},{{14{in[31]}},in[31:14]},{{15{in[31]}},in[31:15]},
    {{16{in[31]}},in[31:16]},{{17{in[31]}},in[31:17]},{{18{in[31]}},in[31:18]},{{19{in[31]}},in[31:19]},{{20{in[31]}},in[31:20]},
    {{21{in[31]}},in[31:21]},{{22{in[31]}},in[31:22]},{{23{in[31]}},in[31:23]},{{24{in[31]}},in[31:24]},{{25{in[31]}},in[31:25]},
    {{26{in[31]}},in[31:26]},{{27{in[31]}},in[31:27]},{{28{in[31]}},in[31:28]},{{29{in[31]}},in[31:29]},{{30{in[31]}},in[31:30]},
    {{31{in[31]}},in[31]},shamt,out);

endmodule
