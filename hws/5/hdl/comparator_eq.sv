module comparator_eq(a, b, out);
parameter N = 32;
input wire signed [N-1:0] a, b;
output logic out;

// Using only *structural* combinational logic, make a module that computes if a == b. 

// Copy any other modules you use into the HDL folder and update the Makefile accordingly.

// if all pairs of binary digits from a and b are the same then out == ture
always_comb out = &(a ~^ b);

endmodule


