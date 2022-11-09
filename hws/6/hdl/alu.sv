`timescale 1ns/1ps
`default_nettype none

`include "alu_types.sv"

module alu(a, b, control, result, overflow, zero, equal);
parameter N = 32; // Don't need to support other numbers, just using this as a constant.

input wire [N-1:0] a, b; // Inputs to the ALU.
input alu_control_t control; // Sets the current operation.
output logic [N-1:0] result; // Result of the selected operation.

output logic overflow; // Is high if the result of an ADD or SUB wraps around the 32 bit boundary.
output logic zero;  // Is high if the result is ever all zeros.
output logic equal; // is high if a == b.
logic [N-1:0] adderhalf, shiftlogical, shiftclean, comb_simple;

always_comb result = control[3] ? adderhalf : (control[2] ? shiftclean : comb_simple);

always_comb zero = ~|result;
always_comb equal = &(a ~^ b);
logic [N-1:0] sum, bxor, sll, srl, sra;
logic cmid, cout, ltu, lt, sum1;

always_comb bxor = b^{N{control[2]}};

adder_n #(.N(N)) adder_n(a,bxor,control[2],sum,cout);
//always_comb ltu = 

mux4 #(.N(N)) addmux(sum,{31'd0, (a[N-1] & (bxor[N-1] | sum[N-1]) | sum[N-1]& bxor[N-1])},0,{31'd0, ~cout},control[1:0],adderhalf);
mux4 #(.N(N)) combmux(0,a&b,a|b,a^b,control[1:0],comb_simple);
mux4 #(.N(N)) shifmux(0,sll,srl,sra,control[1:0],shiftlogical);
always_comb shiftclean = |b[N-1:5] ? 32'd0 : shiftlogical;
shift_left_logical      sll1(a, b[4:0], sll);
shift_right_logical     srl1(a, b[4:0], srl);
shift_right_arithmetic  sra1(a, b[4:0], sra);

always_comb overflow = control[3] ? (((a[N-1]~^bxor[N-1])) & (a[N-1] ^ sum[N-1])) : 0;


// Use *only* structural logic and previously defined modules to implement an 
// ALU that can do all of operations defined in alu_types.sv's alu_op_code_t.


endmodule