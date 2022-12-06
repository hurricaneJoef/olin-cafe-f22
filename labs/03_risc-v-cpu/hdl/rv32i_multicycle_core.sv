`timescale 1ns/1ps
`default_nettype none

`include "alu_types.sv"
`include "rv32i_defines.sv"

module rv32i_multicycle_core(
  clk, rst, ena,
  mem_addr, mem_rd_data, mem_wr_data, mem_wr_ena,
  PC
);

parameter PC_START_ADDRESS=0;

// Standard control signals.
input  wire clk, rst, ena; // <- worry about implementing the ena signal last.

// Memory interface.
output logic [31:0] mem_addr, mem_wr_data;
input   wire [31:0] mem_rd_data;
output logic mem_wr_ena;

// Program Counter
output wire [31:0] PC;
wire [31:0] PC_old;
logic PC_ena;
logic [31:0] PC_next; 

// Program Counter Registers
register #(.N(32), .RESET(PC_START_ADDRESS)) PC_REGISTER (
  .clk(clk), .rst(rst), .ena(PC_ena), .d(PC_next), .q(PC)
);
register #(.N(32)) PC_OLD_REGISTER(
  .clk(clk), .rst(rst), .ena(PC_ena), .d(PC), .q(PC_old)
);

//  an example of how to make named inputs for a mux:
/*
    enum logic {MEM_SRC_PC, MEM_SRC_RESULT} mem_src;
    always_comb begin : memory_read_address_mux
      case(mem_src)
        MEM_SRC_RESULT : mem_rd_addr = alu_result;
        MEM_SRC_PC : mem_rd_addr = PC;
        default: mem_rd_addr = 0;
    end
*/

// Register file
logic reg_write;
logic [4:0] rd, rs1, rs2;
logic [31:0] rfile_wr_data;
wire [31:0] reg_data1, reg_data2;
register_file REGISTER_FILE(
  .clk(clk), 
  .wr_ena(reg_write), .wr_addr(rd), .wr_data(rfile_wr_data),
  .rd_addr0(rs1), .rd_addr1(rs2),
  .rd_data0(reg_data1), .rd_data1(reg_data2)
);

// ALU and related control signals
// Feel free to replace with your ALU from the homework.
logic [31:0] src_a, src_b;
alu_control_t alu_control;
wire [31:0] alu_result;
wire overflow, zero, equal;
alu_behavioural ALU (
  .a(src_a), .b(src_b), .result(alu_result),
  .control(alu_control),
  .overflow(overflow), .zero(zero), .equal(equal)
);

// Implement your multicycle rv32i CPU here!

//defines 
logic [31:0] instruction, mem_rd_data, memory_data, rs1_data, rs2_data, alu_result_old, result;
logic IR_write;

// =========  registers 

// IR_RD_DATA register 
register #(.N(32)) IR_RD_DATA(
  .clk(clk), .rst(rst), .ena(IR_write), .d(mem_rd_data), .q(instruction)
);

// ram data register 
register #(.N(32)) data_reg(
  .clk(clk), .rst(rst), .ena(1'b1), .d(mem_rd_data), .q(memory_data)
);

// register data output registers
register #(.N(32)) reg_reg_1(
  .clk(clk), .rst(rst), .ena(1'b1), .d(reg_data1), .q(rs1_data)
);
register #(.N(32)) reg_reg_2(
  .clk(clk), .rst(rst), .ena(1'b1), .d(reg_data2), .q(rs2_data)
);

// ALU result old register 
register #(.N(32)) alu_result_old_reg(
  .clk(clk), .rst(rst), .ena(1'b1), .d(alu_result), .q(alu_result_old)
);
// end reg


// muxes

// address mux
enum logic {MEM_SRC_PC, MEM_SRC_RESULT} addr_slt;
always_comb begin : memory_read_address_mux
  case(addr_slt)
    MEM_SRC_RESULT : mem_addr = alu_result;
    MEM_SRC_PC : mem_addr = PC;
    default: mem_addr = 0;
  endcase
end


//====== alu muxes
//a
enum logic [1:0] {CURRENT_PC, OLD_PC_REG, RS1_DATA_REG} alu_a_slt;
always_comb begin : alu_a_mux
  case(alu_a_slt)
    CURRENT_PC : src_a = PC;
    OLD_PC_REG : src_a = PC_old;
    RS1_DATA_REG : src_a = reg_data1;
    default: src_a = 0;
  endcase
end
//b
enum logic [1:0] {FOUR, IMM_EXT, RS2_DATA_REG} alu_b_slt;
always_comb begin : alu_b_mux
  case(alu_a_slt)
    FOUR : src_b = 32'd4;
    IMM_EXT : src_b = 0'bxxx; 
    RS1_DATA_REG : src_b = reg_data2;
    default: src_b = 0;
  endcase
end

// alu result mux
enum logic [1:0] {OLD_RESULT, RESULT, MEMORY} result_slt;
always_comb begin : result_mux
  case(alu_a_slt)
    OLD_RESULT : result = alu_result_old;
    RESULT : result = alu_result; 
    MEMORY : result = memory_data;
    default: result = 0;
  endcase
end

// end muxes


//=========================================================
// = = = = = = = = = = = control logic = = = = = = = = = = 
//=========================================================
logic [6:0] op;
logic [2:0] funct3;
logic [6:0] funct7;
always_comb begin : instruction_decoder
  op = instruction[6:0];

  funct3 = op[2] ? 3'd0 : instruction[14:12]; // always around except for u and j and some others

  funct7 = &(op ~^ 7'b0110011) ? instruction[31:25] : 7'd0;// only r types have this so same it for them

  rs1 = ~op[2]&(op[3]^op[4]) ? instruction[19:15] :  5'd0;
  rs2 = op[5]&~op[2] ? instruction[24:20] : 5'd0;
  rd  = op[5]&~(op[2]|op[4]) ? 5'd0 : instruction[11:7];
end



// alu contols



endmodule
