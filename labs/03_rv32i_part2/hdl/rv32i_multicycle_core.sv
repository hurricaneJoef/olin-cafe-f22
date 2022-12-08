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
logic [31:0] instruction, memory_data, rs1_data, rs2_data, alu_result_old, result;
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
  case(alu_b_slt)
    FOUR : src_b = 32'd4;
    IMM_EXT : src_b = imm; 
    RS1_DATA_REG : src_b = reg_data2;
    default: src_b = 0;
  endcase
end

// alu result mux
enum logic [1:0] {OLD_RESULT, RESULT, MEMORY} result_slt;
always_comb begin : result_mux
  case(result_slt)
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
/*always_comb begin : instruction_decoder
  op = instruction[6:0];

  funct3 = op[2] ? 3'd0 : instruction[14:12]; // always around except for u and j and some others

  funct7 = (&({op[6],op[4:0]} ~^ 6'b010011))&(op[5] | &(funct3 ~^ 3'b101)) ? instruction[31:25] : 7'd0;// only r types have this so same it for them

  rs1 = ~op[2]&(op[6]|op[4]) ? instruction[19:15] :  5'd0;
  rs2 = op[5]&~op[2] ? instruction[24:20] : 5'd0;
  rd  = op[5]&~(op[2]|op[4]) ? 5'd0 : instruction[11:7];
end

/*
always_comb begin : alu_decode
  case({funct7[5],funct3})
  //4'b0000:alu_control = ALU_ADD;
  4'b1000:alu_control = ALU_SUB;
  4'b0001:alu_control = ALU_SLL;
  4'b0010:alu_control = ALU_SLT;
  4'b0011:alu_control = ALU_SLTU;
  4'b0100:alu_control = ALU_XOR;
  4'b0101:alu_control = ALU_SRL;
  4'b1101:alu_control = ALU_SRA;
  4'b0110:alu_control = ALU_OR;
  4'b0111:alu_control = ALU_AND;
  default :alu_control = ALU_ADD;
  endcase
end//*/

// end alu contols
logic [31:0] imm;
always_comb begin : control_cl
  op = instruction[6:0];
  funct3 = instruction[14:12];
  funct7 = instruction[31:25];
  rs1 = instruction[19:15];
  rs2 = instruction[24:20];
  rd  = instruction[11:7];
  case(state)
  S_FETCH,S_RST: imm = 32'b0;
  default :begin
    case(op)
    OP_LTYPE :  begin
      case(funct3)
      default: imm = {{20{instruction[31]}},instruction[31:20]};
      endcase
    end
    OP_ITYPE: begin
      imm = {{20{instruction[31]}},instruction[31:20]};
    end
    OP_STYPE: begin
      imm = {{15{instruction[31]}},instruction[31:25],rd};
    end
    OP_BTYPE: begin
      imm = {{20{funct3[1] ? 0 : instruction[31]}},instruction[7],instruction[30:25],instruction[11:8],1'b0};
    end
    OP_JAL: begin 
      imm = {{12{funct3[1] ? 0 : instruction[31]}},instruction[7],instruction[30:25],instruction[11:8],1'b0};
    end
    default: begin
      imm = 32'b0;
    end
    endcase
  end
  endcase

  case(state)
  S_FETCH : begin
    mem_wr_ena = 1'b0;
    addr_slt = MEM_SRC_PC;
    IR_write = 1'b1;
    rd_addr = 5'b0;

    // set alu to creat pc+4
    alu_a_slt = CURRENT_PC;
    alu_b_slt = FOUR;
    alu_control = ALU_ADD;

    // set up pc+4 in next pc
    result_slt = RESULT;
    // and get ready to bring it into the pc counter
    PC_ena = 1'b1;
  end
  S_DECODE : begin
    mem_wr_ena = 1'b0;
    IR_write = 1'b0;
    PC_ena = 1'b0;
    rd_addr = 5'b0;
    //setup for j and b
    alu_a_slt = OLD_PC_REG;
    alu_b_slt = imm;
    alu_control = ALU_ADD;
    case(op)
    OP_LTYPE : next_state = S_MEMADDR;
    OP_ITYPE : next_state = S_EXE_I;
    //OP_AUIPC : next_state = S_RST; //FIX ME 
    OP_STYPE : next_state = S_MEMADDR;
    OP_RTYPE : next_state = S_EXE_R;
    //OP_LUI   : next_state = S_RST; //FIX ME
    OP_BTYPE : next_state = S_BRANCH;
    //OP_JALR  : next_state = S_RST; //FIX ME
    OP_JAL   : next_state = S_JAL;
    default: next_state = S_RST;
    endcase
  end
  S_JAL : begin
    mem_wr_ena = 1'b0;
    IR_write = 1'b0;
    rd_addr = 5'b0;
    // shift in new pc
    PC_ena = 1'b1;
    result_slt = OLD_RESULT;

  //setup alu for write back data
    alu_a_slt = OLD_PC_REG;
    alu_b_slt = FOUR;
    alu_control = ALU_ADD;

  // next state
  next_state = S_ALUWB;
  end
  S_EXE_I : begin
    mem_wr_ena = 1'b0;
    IR_write = 1'b0;
    PC_ena = 1'b0;
    rd_addr = 5'b0;

    alu_a_slt = RS1_DATA_REG;
    alu_b_slt = IMM_EXT;
    //set alu
    case(funct3)
    FUNCT3_ADD          : alu_control = ALU_ADD;
    FUNCT3_SLL          : alu_control = ALU_SLL;
    FUNCT3_SLT          : alu_control = ALU_SLT;
    FUNCT3_SLTU         : alu_control = ALU_SLTU;
    FUNCT3_XOR          : alu_control = ALU_XOR;
    FUNCT3_SHIFT_RIGHT  : alu_control = funct7[5] ? ALU_SRA : ALU_SRL;
    FUNCT3_OR           : alu_control = ALU_OR;
    FUNCT3_AND          : alu_control = ALU_AND;
    endcase
  
  // next state
  next_state = S_ALUWB;
  end
  S_EXE_R : begin
    mem_wr_ena = 1'b0;
    IR_write = 1'b0;
    PC_ena = 1'b0;
    rd_addr = 5'b0;

    alu_a_slt = RS1_DATA_REG;
    alu_b_slt = RS2_DATA_REG;
    //set alu
    case(funct3)
    FUNCT3_ADD          : alu_control = ALU_ADD;
    FUNCT3_SLL          : alu_control = ALU_SLL;
    FUNCT3_SLT          : alu_control = ALU_SLT;
    FUNCT3_SLTU         : alu_control = ALU_SLTU;
    FUNCT3_XOR          : alu_control = ALU_XOR;
    FUNCT3_SHIFT_RIGHT  : alu_control = funct7[5] ? ALU_SRA : ALU_SRL;
    FUNCT3_OR           : alu_control = ALU_OR;
    FUNCT3_AND          : alu_control = ALU_AND;
    endcase

    // next state
    next_state = S_ALUWB;
  end
  S_MEMADDR : begin
    mem_wr_ena = 1'b0;
    IR_write = 1'b0;
    PC_ena = 1'b0;
    rd_addr = 5'b0;
    alu_a_slt = RS1_DATA_REG;
    alu_b_slt = IMM_EXT;
    alu_control = ALU_ADD;
    case(op)
      OP_LTYPE: next_state = S_MEMRD;
      OP_STYPE: next_state = S_MEMWR;
      default: next_state = S_RST;
    endcase
  end
  S_BRANCH : begin
    mem_wr_ena = 1'b0;
    IR_write = 1'b0;
    result_slt = OLD_RESULT;
    //PC_ena = 1'b0;
    rd_addr = 5'b0;
    case(funct3)
    FUNCT3_BNE: PC_ena = ~ equal;
    
    default:PC_ena = equal;
    endcase

    next_state = S_FETCH;
  end
  S_ALUWB : begin
    mem_wr_ena = 1'b0;
    IR_write = 1'b0;
    PC_ena = 1'b0;
    result_slt = OLD_RESULT;
    rd_addr = rd;
    next_state = S_FETCH;
  end
  S_MEMWR : begin
    mem_wr_ena = 1'b1;
    IR_write = 1'b0;
    PC_ena = 1'b0;
    rd_addr = 5'b0;
    addr_slt = MEM_SRC_RESULT;

    next_state = S_FETCH;

  end
  S_MEMRD : begin
    mem_wr_ena = 1'b0;
    IR_write = 1'b0;
    PC_ena = 1'b0;
    rd_addr = 5'b0;
    addr_slt = MEM_SRC_RESULT;

    next_state = S_MEMWB;
  end
  S_MEMWB : begin
    mem_wr_ena = 1'b0;
    IR_write = 1'b0;
    PC_ena = 1'b0;
    rd_addr = rd;
    result_slt = MEMORY;

    next_state = S_FETCH;

  end
  default : begin
    mem_wr_ena = 1'b0;
    IR_write = 1'b0;
    PC_ena = 1'b0;
    rd_addr = 5'b0;
  end
  endcase
end

enum logic[3:0]{
  S_FETCH,
  S_DECODE,
  S_JAL,
  S_EXE_I,
  S_EXE_R,
  S_MEMADDR,
  S_BRANCH,
  S_ALUWB,
  S_MEMWR,
  S_MEMRD,
  S_MEMWB,
  S_RST
} state, next_state;


always_ff @(posedge clk) begin : control_fsm
  if(rst) begin
    state <= S_RST;
  end
  else begin
    if(ena) begin
      state <= next_state;
    end
  end
end


endmodule
