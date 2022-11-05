/*
  A pulse width modulation module 
*/

module pwm(clk, rst, ena, step, duty, out);

parameter N = 8;

input wire clk, rst;
input wire ena; // Enables the output.
input wire step; // Enables the internal counter. You should only increment when this signal is high (this is how we slow down the PWM to reasonable speeds).
input wire [N-1:0] duty; // The "duty cycle" input.
output logic out;

//logic [N-1:0] counter;

// Create combinational (always_comb) and sequential (always_ff @(posedge clk)) 
// logic that drives the out signal.
// out should be off if ena is low.
// out should be fully zero (no pulses) if duty is 0.
// out should have its highest duty cycle if duty is 2^N-1;
// bonus: out should be fully zero at duty = 0, and fully 1 (always on) at duty = 2^N-1;
// You can use behavioural combinational logic, but try to keep your sequential
//   and combinational blocks as separate as possible.

//counter start
logic c_out;
logic [N-1:0] counter, counter_next;
adder_n #(.N(N)) addn(counter,0,1,counter_next,c_out);
always_ff @(posedge clk) begin
  if(rst) counter <= 0;
  else if (step) counter <= counter_next;
end
logic out_raw;
comparator_lt #(.N(N)) comp_lt(counter,duty,out_raw);
always_comb out = out_raw & ena;
//counter end

endmodule
