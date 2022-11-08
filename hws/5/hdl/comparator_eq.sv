module comparator_eq(a, b, out);
parameter N = 32;
input wire signed [N-1:0] a, b;
output logic out;

// Using only *structural* combinational logic, make a module that computes if a == b. 



// if all pairs of binary digits from a and b are the same then out == ture
always_comb out = &(a ~^ b);

endmodule


