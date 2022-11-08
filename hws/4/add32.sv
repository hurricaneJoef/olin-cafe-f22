	
`timescale 1ns/1ps
`default_nettype none
/*
    lmao copied from mux32.sv
*/

module add32(ina,inb,ci,co,out);
	//parameter definitions
	parameter N = 32; // y tho
	//port definitions
	input  wire [(N-1):0] ina;
    input wire [(N-1):0] inb;
	input  wire ci;
    output logic co;
	output logic [(N-1):0] out;
    logic [(N-1):0] p;
    logic [(N-1):0] g;
    logic [(N-1):0] axb;
    logic [N:0] c;
    always_comb begin
        //p = ina ^ inb;
        //g = ina & inb;
        c[0] = ci;
        //c[N:1] = g | (p & c[(N-1):0]);
        //co = c[N];//g[31] | (p[31] & c[31]);
        //out[(N-1):0] = c[(N-1):0] ^ p;
        //😭
        //axb = ina ^ inb;
        //c[N:1] = (axb & c[(N-1):0]) | (ina & inb);
        //out = c[(N-1):0] ^ axb;
        //co = c[N];

        axb[0] = ina[0] ^ inb[0];
        c[1] = (ina[0] & inb[0]) | (axb[0] & c[0]);
        out[0] = axb[0] ^ c[0];

        axb[1] = ina[1] ^ inb[1];
        c[2] = (ina[1] & inb[1]) | (axb[1] & c[1]);
        out[1] = axb[1] ^ c[1];

        axb[2] = ina[2] ^ inb[2];
        c[3] = (ina[2] & inb[2]) | (axb[2] & c[2]);
        out[2] = axb[2] ^ c[2];

        axb[3] = ina[3] ^ inb[3];
        c[4] = (ina[3] & inb[3]) | (axb[3] & c[3]);
        out[3] = axb[3] ^ c[3];

        axb[4] = ina[4] ^ inb[4];
        c[5] = (ina[4] & inb[4]) | (axb[4] & c[4]);
        out[4] = axb[4] ^ c[4];

        axb[5] = ina[5] ^ inb[5];
        c[6] = (ina[5] & inb[5]) | (axb[5] & c[5]);
        out[5] = axb[5] ^ c[5];

        axb[6] = ina[6] ^ inb[6];
        c[7] = (ina[6] & inb[6]) | (axb[6] & c[6]);
        out[6] = axb[6] ^ c[6];

        axb[7] = ina[7] ^ inb[7];
        c[8] = (ina[7] & inb[7]) | (axb[7] & c[7]);
        out[7] = axb[7] ^ c[7];

        axb[8] = ina[8] ^ inb[8];
        c[9] = (ina[8] & inb[8]) | (axb[8] & c[8]);
        out[8] = axb[8] ^ c[8];

        axb[9] = ina[9] ^ inb[9];
        c[10] = (ina[9] & inb[9]) | (axb[9] & c[9]);
        out[9] = axb[9] ^ c[9];

        axb[10] = ina[10] ^ inb[10];
        c[11] = (ina[10] & inb[10]) | (axb[10] & c[10]);
        out[10] = axb[10] ^ c[10];

        axb[11] = ina[11] ^ inb[11];
        c[12] = (ina[11] & inb[11]) | (axb[11] & c[11]);
        out[11] = axb[11] ^ c[11];

        axb[12] = ina[12] ^ inb[12];
        c[13] = (ina[12] & inb[12]) | (axb[12] & c[12]);
        out[12] = axb[12] ^ c[12];

        axb[13] = ina[13] ^ inb[13];
        c[14] = (ina[13] & inb[13]) | (axb[13] & c[13]);
        out[13] = axb[13] ^ c[13];

        axb[14] = ina[14] ^ inb[14];
        c[15] = (ina[14] & inb[14]) | (axb[14] & c[14]);
        out[14] = axb[14] ^ c[14];

        axb[15] = ina[15] ^ inb[15];
        c[16] = (ina[15] & inb[15]) | (axb[15] & c[15]);
        out[15] = axb[15] ^ c[15];

        axb[16] = ina[16] ^ inb[16];
        c[17] = (ina[16] & inb[16]) | (axb[16] & c[16]);
        out[16] = axb[16] ^ c[16];

        axb[17] = ina[17] ^ inb[17];
        c[18] = (ina[17] & inb[17]) | (axb[17] & c[17]);
        out[17] = axb[17] ^ c[17];

        axb[18] = ina[18] ^ inb[18];
        c[19] = (ina[18] & inb[18]) | (axb[18] & c[18]);
        out[18] = axb[18] ^ c[18];

        axb[19] = ina[19] ^ inb[19];
        c[20] = (ina[19] & inb[19]) | (axb[19] & c[19]);
        out[19] = axb[19] ^ c[19];

        axb[20] = ina[20] ^ inb[20];
        c[21] = (ina[20] & inb[20]) | (axb[20] & c[20]);
        out[20] = axb[20] ^ c[20];

        axb[21] = ina[21] ^ inb[21];
        c[22] = (ina[21] & inb[21]) | (axb[21] & c[21]);
        out[21] = axb[21] ^ c[21];

        axb[22] = ina[22] ^ inb[22];
        c[23] = (ina[22] & inb[22]) | (axb[22] & c[22]);
        out[22] = axb[22] ^ c[22];

        axb[23] = ina[23] ^ inb[23];
        c[24] = (ina[23] & inb[23]) | (axb[23] & c[23]);
        out[23] = axb[23] ^ c[23];

        axb[24] = ina[24] ^ inb[24];
        c[25] = (ina[24] & inb[24]) | (axb[24] & c[24]);
        out[24] = axb[24] ^ c[24];

        axb[25] = ina[25] ^ inb[25];
        c[26] = (ina[25] & inb[25]) | (axb[25] & c[25]);
        out[25] = axb[25] ^ c[25];

        axb[26] = ina[26] ^ inb[26];
        c[27] = (ina[26] & inb[26]) | (axb[26] & c[26]);
        out[26] = axb[26] ^ c[26];

        axb[27] = ina[27] ^ inb[27];
        c[28] = (ina[27] & inb[27]) | (axb[27] & c[27]);
        out[27] = axb[27] ^ c[27];

        axb[28] = ina[28] ^ inb[28];
        c[29] = (ina[28] & inb[28]) | (axb[28] & c[28]);
        out[28] = axb[28] ^ c[28];

        axb[29] = ina[29] ^ inb[29];
        c[30] = (ina[29] & inb[29]) | (axb[29] & c[29]);
        out[29] = axb[29] ^ c[29];

        axb[30] = ina[30] ^ inb[30];
        c[31] = (ina[30] & inb[30]) | (axb[30] & c[30]);
        out[30] = axb[30] ^ c[30];

        axb[31] = ina[31] ^ inb[31];
        co = (ina[31] & inb[31]) | (axb[31] & c[31]);
        out[31] = axb[31] ^ c[31];
    end



endmodule