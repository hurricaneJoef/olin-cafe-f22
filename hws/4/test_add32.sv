`timescale 1ns / 1ps
`default_nettype none

`define SIMULATION

module test_add32;
  logic ci;
  logic co;
  logic [31:0] ina;
  logic [31:0] inb;
  wire [31:0] out;
  logic [32:0] correctout;
  add32 UUT(ina,inb,ci,co,out);
// copied from 3 to 8 mux
  initial begin // In standard programming land (line by line execution)
    // Collect waveforms
    $dumpfile("add32.fst");
    $dumpvars(0, UUT);
    
    
    $display("ci|            ina                   |    inb                           |        out              co     || correct out");
    ci = 1'd0; ina = 32'd0; inb = 32'd0; correctout = 33'd0;
    #100 $display("%1b | %32b | %32b | %32b | %1b || %33b", ci, ina, inb, out, co, correctout);
    ci = 1'd0; ina = 32'd0; inb = 32'd4294967295; correctout = 33'd4294967295;
    #100 $display("%1b | %32b | %32b | %32b | %1b || %33b", ci, ina, inb, out, co, correctout);
    ci = 1'd0; ina = 32'd0; inb = 32'd1431655765; correctout = 33'd1431655765;
    #100 $display("%1b | %32b | %32b | %32b | %1b || %33b", ci, ina, inb, out, co, correctout);
    ci = 1'd0; ina = 32'd0; inb = 32'd2863311530; correctout = 33'd2863311530;
    #100 $display("%1b | %32b | %32b | %32b | %1b || %33b", ci, ina, inb, out, co, correctout);
    ci = 1'd0; ina = 32'd4294967295; inb = 32'd0; correctout = 33'd4294967295;
    #100 $display("%1b | %32b | %32b | %32b | %1b || %33b", ci, ina, inb, out, co, correctout);
    ci = 1'd0; ina = 32'd4294967295; inb = 32'd4294967295; correctout = 33'd8589934590;
    #100 $display("%1b | %32b | %32b | %32b | %1b || %33b", ci, ina, inb, out, co, correctout);
    ci = 1'd0; ina = 32'd4294967295; inb = 32'd1431655765; correctout = 33'd5726623060;
    #100 $display("%1b | %32b | %32b | %32b | %1b || %33b", ci, ina, inb, out, co, correctout);
    ci = 1'd0; ina = 32'd4294967295; inb = 32'd2863311530; correctout = 33'd7158278825;
    #100 $display("%1b | %32b | %32b | %32b | %1b || %33b", ci, ina, inb, out, co, correctout);
    ci = 1'd0; ina = 32'd1431655765; inb = 32'd0; correctout = 33'd1431655765;
    #100 $display("%1b | %32b | %32b | %32b | %1b || %33b", ci, ina, inb, out, co, correctout);
    ci = 1'd0; ina = 32'd1431655765; inb = 32'd4294967295; correctout = 33'd5726623060;
    #100 $display("%1b | %32b | %32b | %32b | %1b || %33b", ci, ina, inb, out, co, correctout);
    ci = 1'd0; ina = 32'd1431655765; inb = 32'd1431655765; correctout = 33'd2863311530;
    #100 $display("%1b | %32b | %32b | %32b | %1b || %33b", ci, ina, inb, out, co, correctout);
    ci = 1'd0; ina = 32'd1431655765; inb = 32'd2863311530; correctout = 33'd4294967295;
    #100 $display("%1b | %32b | %32b | %32b | %1b || %33b", ci, ina, inb, out, co, correctout);
    ci = 1'd0; ina = 32'd2863311530; inb = 32'd0; correctout = 33'd2863311530;
    #100 $display("%1b | %32b | %32b | %32b | %1b || %33b", ci, ina, inb, out, co, correctout);
    ci = 1'd0; ina = 32'd2863311530; inb = 32'd4294967295; correctout = 33'd7158278825;
    #100 $display("%1b | %32b | %32b | %32b | %1b || %33b", ci, ina, inb, out, co, correctout);
    ci = 1'd0; ina = 32'd2863311530; inb = 32'd1431655765; correctout = 33'd4294967295;
    #100 $display("%1b | %32b | %32b | %32b | %1b || %33b", ci, ina, inb, out, co, correctout);
    ci = 1'd0; ina = 32'd2863311530; inb = 32'd2863311530; correctout = 33'd5726623060;
    #100 $display("%1b | %32b | %32b | %32b | %1b || %33b", ci, ina, inb, out, co, correctout);
    ci = 1'd1; ina = 32'd0; inb = 32'd0; correctout = 33'd1;
    #100 $display("%1b | %32b | %32b | %32b | %1b || %33b", ci, ina, inb, out, co, correctout);
    ci = 1'd1; ina = 32'd0; inb = 32'd4294967295; correctout = 33'd4294967296;
    #100 $display("%1b | %32b | %32b | %32b | %1b || %33b", ci, ina, inb, out, co, correctout);
    ci = 1'd1; ina = 32'd0; inb = 32'd1431655765; correctout = 33'd1431655766;
    #100 $display("%1b | %32b | %32b | %32b | %1b || %33b", ci, ina, inb, out, co, correctout);
    ci = 1'd1; ina = 32'd0; inb = 32'd2863311530; correctout = 33'd2863311531;
    #100 $display("%1b | %32b | %32b | %32b | %1b || %33b", ci, ina, inb, out, co, correctout);
    ci = 1'd1; ina = 32'd4294967295; inb = 32'd0; correctout = 33'd4294967296;
    #100 $display("%1b | %32b | %32b | %32b | %1b || %33b", ci, ina, inb, out, co, correctout);
    ci = 1'd1; ina = 32'd4294967295; inb = 32'd4294967295; correctout = 33'd8589934591;
    #100 $display("%1b | %32b | %32b | %32b | %1b || %33b", ci, ina, inb, out, co, correctout);
    ci = 1'd1; ina = 32'd4294967295; inb = 32'd1431655765; correctout = 33'd5726623061;
    #100 $display("%1b | %32b | %32b | %32b | %1b || %33b", ci, ina, inb, out, co, correctout);
    ci = 1'd1; ina = 32'd4294967295; inb = 32'd2863311530; correctout = 33'd7158278826;
    #100 $display("%1b | %32b | %32b | %32b | %1b || %33b", ci, ina, inb, out, co, correctout);
    ci = 1'd1; ina = 32'd1431655765; inb = 32'd0; correctout = 33'd1431655766;
    #100 $display("%1b | %32b | %32b | %32b | %1b || %33b", ci, ina, inb, out, co, correctout);
    ci = 1'd1; ina = 32'd1431655765; inb = 32'd4294967295; correctout = 33'd5726623061;
    #100 $display("%1b | %32b | %32b | %32b | %1b || %33b", ci, ina, inb, out, co, correctout);
    ci = 1'd1; ina = 32'd1431655765; inb = 32'd1431655765; correctout = 33'd2863311531;
    #100 $display("%1b | %32b | %32b | %32b | %1b || %33b", ci, ina, inb, out, co, correctout);
    ci = 1'd1; ina = 32'd1431655765; inb = 32'd2863311530; correctout = 33'd4294967296;
    #100 $display("%1b | %32b | %32b | %32b | %1b || %33b", ci, ina, inb, out, co, correctout);
    ci = 1'd1; ina = 32'd2863311530; inb = 32'd0; correctout = 33'd2863311531;
    #100 $display("%1b | %32b | %32b | %32b | %1b || %33b", ci, ina, inb, out, co, correctout);
    ci = 1'd1; ina = 32'd2863311530; inb = 32'd4294967295; correctout = 33'd7158278826;
    #100 $display("%1b | %32b | %32b | %32b | %1b || %33b", ci, ina, inb, out, co, correctout);
    ci = 1'd1; ina = 32'd2863311530; inb = 32'd1431655765; correctout = 33'd4294967296;
    #100 $display("%1b | %32b | %32b | %32b | %1b || %33b", ci, ina, inb, out, co, correctout);
    ci = 1'd1; ina = 32'd2863311530; inb = 32'd2863311530; correctout = 33'd5726623061;
    #100 $display("%1b | %32b | %32b | %32b | %1b || %33b", ci, ina, inb, out, co, correctout);
    
    $finish;      
	end

endmodule