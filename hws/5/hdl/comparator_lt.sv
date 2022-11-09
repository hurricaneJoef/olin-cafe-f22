module comparator_lt(a, b, out);
parameter N = 32;
input wire signed [N-1:0] a, b;
output logic out;

// Using only *structural* combinational logic, make a module that computes if a is less than b!
// Note: this assumes that the two inputs are signed: aka should be interpreted as two's complement.

// Copy any other modles you use into the HDL folder and update the Makefile accordingly.
logic signed [N-1:0] sum;
logic c_out;

//invert b for use later
logic [N-1:0] b_; always_comb b_ = ~b;

// and a and -b so that if a <b sum is negitive
adder_n #(.N(N)) add1(a, b_, 1'b1, sum, c_out);// 2s comp is invert ad add one so i use the carry for that add one

// logic i found in the book but i did the whiteboard math to simplyfy
always_comb out = a[N-1] & (b_[N-1] | sum[N-1]) | sum[N-1]& b_[N-1];//og :sum[N-1]^((sum[N-1]^a[N-1])&(a[N-1]^b[N-1]));

endmodule

