// Generates "triangle" waves (counts from 0 to 2^N-1, then back down again)
// The triangle should increment/decrement only if the ena signal is high, and hold its value otherwise.
module triangle_generator(clk, rst, ena, out);

parameter N = 8;
input wire clk, rst, ena;
output logic [N-1:0] out;

typedef enum logic {COUNTING_UP, COUNTING_DOWN} state_t;
state_t state;
logic internal_rst;
always_comb internal_rst = rst ;
//counter start
logic c_out;
logic [N:0] counter, counter_next;
adder_n #(.N(N+1)) addn(counter,1,&counter[N-1:0],counter_next,c_out);
always_ff @(posedge clk) begin
  if(internal_rst) counter <= 0;
  else if (ena) counter <= counter_next;
end
//counter end

always_comb out = {N{counter[N]}} ^ counter[N-1:0];


endmodule