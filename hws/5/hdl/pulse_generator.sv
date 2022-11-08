/*
  Outputs a pulse generator with a period of "ticks".
  out should go high for one cycle ever "ticks" clocks.
*/
module pulse_generator(clk, rst, ena, ticks, out);

parameter N = 8;
input wire clk, rst, ena;
input wire [N-1:0] ticks;
output logic out;


logic counter_comparator;
wire [N-1:0] counter_pp;

adder_n #(.N(N)) ADDER(
  .a(counter), .b(1), .c_in(1'b0),
  .sum(counter_pp)
);

// Reset or gate
logic local_reset;
always_comb local_reset = rst | counter_comparator;

// Create a Register
logic [N-1:0] counter; // our q
always_ff @(posedge clk) begin
  if(local_reset) begin
    counter <= 0;
  end else if(ena) begin
    counter <= counter_pp;
  end
  // this always exists:
  // else counter <= counter;
end

logic interal_rst; always_comb interal_rst = rst|out;

//counter start
logic c_out;
logic [N-1:0] counter, counter_next;
adder_n #(.N(N)) addn(counter,0,1,counter_next,c_out);
always_ff @(posedge clk) begin
  if(interal_rst) counter <= 0;
  else if (ena) counter <= counter_next;
end
//counter end

comparator_eq #(.N(N+1)) comp_lt({1'b0, counter_next},{1'b0, ticks},out);

endmodule
