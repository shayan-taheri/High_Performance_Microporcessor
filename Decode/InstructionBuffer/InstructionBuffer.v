
module InstructionBuffer ( clk, reset, flush_i, stall_i, decodeReady_i, 
        decodedVector_i, decodedPacket0_i, decodedPacket1_i, decodedPacket2_i, 
        decodedPacket3_i, decodedPacket4_i, decodedPacket5_i, decodedPacket6_i, 
        decodedPacket7_i, stallFetch_o, instBufferReady_o, decodedPacket0_o, 
        decodedPacket1_o, decodedPacket2_o, decodedPacket3_o, branchCount_o );
  input [7:0] decodedVector_i;
  input [125:0] decodedPacket0_i;
  input [125:0] decodedPacket1_i;
  input [125:0] decodedPacket2_i;
  input [125:0] decodedPacket3_i;
  input [125:0] decodedPacket4_i;
  input [125:0] decodedPacket5_i;
  input [125:0] decodedPacket6_i;
  input [125:0] decodedPacket7_i;
  output [125:0] decodedPacket0_o;
  output [125:0] decodedPacket1_o;
  output [125:0] decodedPacket2_o;
  output [125:0] decodedPacket3_o;
  output [2:0] branchCount_o;
  input clk, reset, flush_i, stall_i, decodeReady_i;
  output stallFetch_o, instBufferReady_o;
  wire   N52, N53, N54, N55, N56, N57, N58, N59, N97, N98, N99, N100, N101,
         N104, N105, N106, N107, N112, N113, N114, N115, N116, N119, N121,
         N122, N123, N124, N125, N126, N127, n94, n96, n97, n98, n99, n100,
         n102, n103, n104, n105, N4, N3, N81, N80, N79, N78, N77, N74, N73,
         N72, N68, N67, N63, N62, N39, N38, N37, N36, N34, N33, N32, N29, N28,
         N25, N24, \add_309/carry[3] , \add_309/carry[2] , \add_309/carry[1] ,
         \add_308/carry[3] , \add_308/carry[2] , \add_308/carry[1] ,
         \add_307/carry[3] , \add_307/carry[2] , \sub_284_aco/carry[4] ,
         \sub_284_aco/carry[3] , \add_230/carry[3] , \add_230/carry[2] ,
         \add_230/carry[1] , \add_229/carry[3] , \add_229/carry[2] ,
         \add_229/carry[1] , \add_228/carry[3] , \add_228/carry[2] ,
         \add_228/carry[1] , \add_227/carry[3] , \add_227/carry[2] ,
         \add_227/carry[1] , \add_226/carry[3] , \add_226/carry[2] ,
         \add_226/carry[1] , \add_225/carry[3] , \add_225/carry[2] ,
         \add_225/carry[1] , \add_224/carry[3] , \add_224/carry[2] ,
         \add_0_root_add_3_root_add_278_8/carry[4] ,
         \add_0_root_add_3_root_add_278_8/carry[3] ,
         \add_0_root_add_3_root_add_278_8/carry[2] ,
         \add_0_root_add_3_root_add_278_8/carry[1] ,
         \add_2_root_add_3_root_add_278_8/carry[4] ,
         \add_2_root_add_3_root_add_278_8/carry[3] ,
         \add_2_root_add_3_root_add_278_8/carry[2] ,
         \add_2_root_add_3_root_add_278_8/carry[1] ,
         \add_1_root_add_3_root_add_278_8/carry[1] , n107, n108, n109, n110,
         n111, n112, n113, n114, n115, n116, n117, n118, n119, n120, n121,
         n122, n123, n124, n125, n126, n127;
  wire   [4:0] instCount;
  wire   [4:0] instcnt_f;
  tri   clk;
  tri   [125:0] decodedPacket0_i;
  tri   [125:0] decodedPacket1_i;
  tri   [125:0] decodedPacket2_i;
  tri   [125:0] decodedPacket3_i;
  tri   [125:0] decodedPacket4_i;
  tri   [125:0] decodedPacket5_i;
  tri   [125:0] decodedPacket6_i;
  tri   [125:0] decodedPacket7_i;
  tri   [125:0] decodedPacket0_o;
  tri   [125:0] decodedPacket1_o;
  tri   [125:0] decodedPacket2_o;
  tri   [125:0] decodedPacket3_o;
  tri   [3:0] readAddr1;
  tri   [3:0] readAddr2;
  tri   [3:0] readAddr3;
  tri   writeEnable0;
  tri   [3:0] writeAddr0;
  tri   writeEnable1;
  tri   [3:0] writeAddr1;
  tri   writeEnable2;
  tri   [3:0] writeAddr2;
  tri   writeEnable3;
  tri   [3:0] writeAddr3;
  tri   writeEnable4;
  tri   [3:0] writeAddr4;
  tri   writeEnable5;
  tri   [3:0] writeAddr5;
  tri   writeEnable6;
  tri   [3:0] writeAddr6;
  tri   writeEnable7;
  tri   [3:0] writeAddr7;
  tri   _0_net_;
  tri   [3:0] headPtr;
  tri   N13;
  tri   N14;

  AND2X1 C152 ( .IN1(N127), .IN2(n111), .Q(writeEnable7) );
  AND2X1 C149 ( .IN1(N126), .IN2(n111), .Q(writeEnable6) );
  AND2X1 C146 ( .IN1(N125), .IN2(n111), .Q(writeEnable5) );
  AND2X1 C143 ( .IN1(N124), .IN2(n111), .Q(writeEnable4) );
  AND2X1 C140 ( .IN1(N123), .IN2(n111), .Q(writeEnable3) );
  AND2X1 C137 ( .IN1(N122), .IN2(n111), .Q(writeEnable2) );
  AND2X1 C134 ( .IN1(N121), .IN2(n111), .Q(writeEnable1) );
  AND2X1 C131 ( .IN1(N119), .IN2(n111), .Q(writeEnable0) );
  OR2X1 C116 ( .IN1(reset), .IN2(flush_i), .Q(_0_net_) );
  DFFX1 \instCount_reg[0]  ( .D(N112), .CLK(clk), .Q(instCount[0]) );
  DFFX1 \instCount_reg[4]  ( .D(N116), .CLK(clk), .Q(instCount[4]) );
  DFFX1 \headPtr_reg[3]  ( .D(n105), .CLK(clk), .Q(headPtr[3]) );
  DFFX1 \tailPtr_reg[3]  ( .D(N59), .CLK(clk), .Q(writeAddr0[3]) );
  DFFX1 \tailPtr_reg[2]  ( .D(N58), .CLK(clk), .Q(writeAddr0[2]) );
  DFFX1 \tailPtr_reg[1]  ( .D(N57), .CLK(clk), .Q(writeAddr0[1]) );
  DFFX1 \tailPtr_reg[0]  ( .D(N56), .CLK(clk), .Q(writeAddr0[0]) );
  DFFX1 \instCount_reg[3]  ( .D(N115), .CLK(clk), .Q(instCount[3]) );
  DFFX1 \instCount_reg[2]  ( .D(N114), .CLK(clk), .Q(instCount[2]) );
  DFFX1 \instCount_reg[1]  ( .D(N113), .CLK(clk), .Q(instCount[1]) );
  DFFX1 \headPtr_reg[0]  ( .D(n104), .CLK(clk), .Q(N13) );
  DFFX1 \headPtr_reg[1]  ( .D(n103), .CLK(clk), .Q(N14) );
  DFFX1 \headPtr_reg[2]  ( .D(n102), .CLK(clk), .Q(headPtr[2]) );
  XNOR2X1 U4 ( .IN1(headPtr[2]), .IN2(N107), .Q(n94) );
  AND2X1 U5 ( .IN1(N14), .IN2(n96), .Q(n103) );
  AND2X1 U6 ( .IN1(N13), .IN2(n96), .Q(n104) );
  XOR2X1 U22 ( .IN1(n98), .IN2(headPtr[3]), .Q(n97) );
  AND2X1 U25 ( .IN1(N55), .IN2(n96), .Q(N59) );
  AND2X1 U26 ( .IN1(N54), .IN2(n96), .Q(N58) );
  AND2X1 U27 ( .IN1(N53), .IN2(n96), .Q(N57) );
  AND2X1 U28 ( .IN1(N52), .IN2(n96), .Q(N56) );
  AND2X1 U29 ( .IN1(decodedVector_i[7]), .IN2(decodeReady_i), .Q(N127) );
  AND2X1 U30 ( .IN1(decodedVector_i[6]), .IN2(decodeReady_i), .Q(N126) );
  AND2X1 U31 ( .IN1(decodedVector_i[5]), .IN2(decodeReady_i), .Q(N125) );
  AND2X1 U32 ( .IN1(decodedVector_i[4]), .IN2(decodeReady_i), .Q(N124) );
  AND2X1 U33 ( .IN1(decodedVector_i[3]), .IN2(decodeReady_i), .Q(N123) );
  AND2X1 U34 ( .IN1(decodedVector_i[2]), .IN2(decodeReady_i), .Q(N122) );
  AND2X1 U35 ( .IN1(decodedVector_i[1]), .IN2(decodeReady_i), .Q(N121) );
  AND2X1 U36 ( .IN1(decodedVector_i[0]), .IN2(decodeReady_i), .Q(N119) );
  AND2X1 U37 ( .IN1(instcnt_f[4]), .IN2(n96), .Q(N116) );
  AND2X1 U38 ( .IN1(instcnt_f[3]), .IN2(n96), .Q(N115) );
  AND2X1 U39 ( .IN1(instcnt_f[2]), .IN2(n96), .Q(N114) );
  AND2X1 U40 ( .IN1(instcnt_f[1]), .IN2(n96), .Q(N113) );
  AND2X1 U41 ( .IN1(instcnt_f[0]), .IN2(n96), .Q(N112) );
  NOR3X0 U44 ( .IN1(instCount[3]), .IN2(instCount[4]), .IN3(instCount[2]), 
        .QN(n99) );
  AO22X1 U45 ( .IN1(instCount[4]), .IN2(n100), .IN3(N101), .IN4(n110), .Q(N106) );
  AO22X1 U46 ( .IN1(instCount[3]), .IN2(n100), .IN3(N100), .IN4(n110), .Q(N105) );
  AO22X1 U47 ( .IN1(instCount[2]), .IN2(n100), .IN3(N99), .IN4(n110), .Q(N104)
         );
  AO22X1 U48 ( .IN1(instCount[1]), .IN2(n100), .IN3(N98), .IN4(n110), .Q(
        instcnt_f[1]) );
  AO22X1 U49 ( .IN1(instCount[0]), .IN2(n100), .IN3(N97), .IN4(n110), .Q(
        instcnt_f[0]) );
  SRAM_8R8W instBuffer ( .addr0_i({headPtr[3:2], N14, N13}), .addr1_i(
        readAddr1), .addr2_i(readAddr2), .addr3_i(readAddr3), .we0_i(
        writeEnable0), .addr0wr_i(writeAddr0), .data0wr_i(decodedPacket0_i), 
        .we1_i(writeEnable1), .addr1wr_i(writeAddr1), .data1wr_i(
        decodedPacket1_i), .we2_i(writeEnable2), .addr2wr_i(writeAddr2), 
        .data2wr_i(decodedPacket2_i), .we3_i(writeEnable3), .addr3wr_i(
        writeAddr3), .data3wr_i(decodedPacket3_i), .we4_i(writeEnable4), 
        .addr4wr_i(writeAddr4), .data4wr_i(decodedPacket4_i), .we5_i(
        writeEnable5), .addr5wr_i(writeAddr5), .data5wr_i(decodedPacket5_i), 
        .we6_i(writeEnable6), .addr6wr_i(writeAddr6), .data6wr_i(
        decodedPacket6_i), .we7_i(writeEnable7), .addr7wr_i(writeAddr7), 
        .data7wr_i(decodedPacket7_i), .clk(clk), .reset(_0_net_), .data0_o(
        decodedPacket0_o), .data1_o(decodedPacket1_o), .data2_o(
        decodedPacket2_o), .data3_o(decodedPacket3_o) );
  FADDX1 \add_309/U1_0  ( .A(N13), .B(1'b1), .CI(1'b0), .CO(\add_309/carry[1] ), .S(readAddr3[0]) );
  FADDX1 \add_309/U1_1  ( .A(N14), .B(1'b1), .CI(\add_309/carry[1] ), .CO(
        \add_309/carry[2] ), .S(readAddr3[1]) );
  FADDX1 \add_309/U1_2  ( .A(headPtr[2]), .B(1'b0), .CI(\add_309/carry[2] ), 
        .CO(\add_309/carry[3] ), .S(readAddr3[2]) );
  FADDX1 \add_309/U1_3  ( .A(headPtr[3]), .B(1'b0), .CI(\add_309/carry[3] ), 
        .S(readAddr3[3]) );
  FADDX1 \add_308/U1_0  ( .A(N13), .B(1'b0), .CI(1'b0), .CO(\add_308/carry[1] ), .S(readAddr2[0]) );
  FADDX1 \add_308/U1_1  ( .A(N14), .B(1'b1), .CI(\add_308/carry[1] ), .CO(
        \add_308/carry[2] ), .S(readAddr2[1]) );
  FADDX1 \add_308/U1_2  ( .A(headPtr[2]), .B(1'b0), .CI(\add_308/carry[2] ), 
        .CO(\add_308/carry[3] ), .S(readAddr2[2]) );
  FADDX1 \add_308/U1_3  ( .A(headPtr[3]), .B(1'b0), .CI(\add_308/carry[3] ), 
        .S(readAddr2[3]) );
  HADDX1 \add_307/U1_1_1  ( .A0(N14), .B0(N13), .C1(\add_307/carry[2] ), .SO(
        readAddr1[1]) );
  HADDX1 \add_307/U1_1_2  ( .A0(headPtr[2]), .B0(\add_307/carry[2] ), .C1(
        \add_307/carry[3] ), .SO(readAddr1[2]) );
  HADDX1 \add_307/U1_1_3  ( .A0(headPtr[3]), .B0(\add_307/carry[3] ), .SO(
        readAddr1[3]) );
  FADDX1 \add_230/U1_0  ( .A(writeAddr0[0]), .B(1'b1), .CI(1'b0), .CO(
        \add_230/carry[1] ), .S(writeAddr7[0]) );
  FADDX1 \add_230/U1_1  ( .A(writeAddr0[1]), .B(1'b1), .CI(\add_230/carry[1] ), 
        .CO(\add_230/carry[2] ), .S(writeAddr7[1]) );
  FADDX1 \add_230/U1_2  ( .A(writeAddr0[2]), .B(1'b1), .CI(\add_230/carry[2] ), 
        .CO(\add_230/carry[3] ), .S(writeAddr7[2]) );
  FADDX1 \add_230/U1_3  ( .A(writeAddr0[3]), .B(1'b0), .CI(\add_230/carry[3] ), 
        .S(writeAddr7[3]) );
  FADDX1 \add_229/U1_0  ( .A(writeAddr0[0]), .B(1'b0), .CI(1'b0), .CO(
        \add_229/carry[1] ), .S(writeAddr6[0]) );
  FADDX1 \add_229/U1_1  ( .A(writeAddr0[1]), .B(1'b1), .CI(\add_229/carry[1] ), 
        .CO(\add_229/carry[2] ), .S(writeAddr6[1]) );
  FADDX1 \add_229/U1_2  ( .A(writeAddr0[2]), .B(1'b1), .CI(\add_229/carry[2] ), 
        .CO(\add_229/carry[3] ), .S(writeAddr6[2]) );
  FADDX1 \add_229/U1_3  ( .A(writeAddr0[3]), .B(1'b0), .CI(\add_229/carry[3] ), 
        .S(writeAddr6[3]) );
  FADDX1 \add_228/U1_0  ( .A(writeAddr0[0]), .B(1'b1), .CI(1'b0), .CO(
        \add_228/carry[1] ), .S(writeAddr5[0]) );
  FADDX1 \add_228/U1_1  ( .A(writeAddr0[1]), .B(1'b0), .CI(\add_228/carry[1] ), 
        .CO(\add_228/carry[2] ), .S(writeAddr5[1]) );
  FADDX1 \add_228/U1_2  ( .A(writeAddr0[2]), .B(1'b1), .CI(\add_228/carry[2] ), 
        .CO(\add_228/carry[3] ), .S(writeAddr5[2]) );
  FADDX1 \add_228/U1_3  ( .A(writeAddr0[3]), .B(1'b0), .CI(\add_228/carry[3] ), 
        .S(writeAddr5[3]) );
  FADDX1 \add_227/U1_0  ( .A(writeAddr0[0]), .B(1'b0), .CI(1'b0), .CO(
        \add_227/carry[1] ), .S(writeAddr4[0]) );
  FADDX1 \add_227/U1_1  ( .A(writeAddr0[1]), .B(1'b0), .CI(\add_227/carry[1] ), 
        .CO(\add_227/carry[2] ), .S(writeAddr4[1]) );
  FADDX1 \add_227/U1_2  ( .A(writeAddr0[2]), .B(1'b1), .CI(\add_227/carry[2] ), 
        .CO(\add_227/carry[3] ), .S(writeAddr4[2]) );
  FADDX1 \add_227/U1_3  ( .A(writeAddr0[3]), .B(1'b0), .CI(\add_227/carry[3] ), 
        .S(writeAddr4[3]) );
  FADDX1 \add_226/U1_0  ( .A(writeAddr0[0]), .B(1'b1), .CI(1'b0), .CO(
        \add_226/carry[1] ), .S(writeAddr3[0]) );
  FADDX1 \add_226/U1_1  ( .A(writeAddr0[1]), .B(1'b1), .CI(\add_226/carry[1] ), 
        .CO(\add_226/carry[2] ), .S(writeAddr3[1]) );
  FADDX1 \add_226/U1_2  ( .A(writeAddr0[2]), .B(1'b0), .CI(\add_226/carry[2] ), 
        .CO(\add_226/carry[3] ), .S(writeAddr3[2]) );
  FADDX1 \add_226/U1_3  ( .A(writeAddr0[3]), .B(1'b0), .CI(\add_226/carry[3] ), 
        .S(writeAddr3[3]) );
  FADDX1 \add_225/U1_0  ( .A(writeAddr0[0]), .B(1'b0), .CI(1'b0), .CO(
        \add_225/carry[1] ), .S(writeAddr2[0]) );
  FADDX1 \add_225/U1_1  ( .A(writeAddr0[1]), .B(1'b1), .CI(\add_225/carry[1] ), 
        .CO(\add_225/carry[2] ), .S(writeAddr2[1]) );
  FADDX1 \add_225/U1_2  ( .A(writeAddr0[2]), .B(1'b0), .CI(\add_225/carry[2] ), 
        .CO(\add_225/carry[3] ), .S(writeAddr2[2]) );
  FADDX1 \add_225/U1_3  ( .A(writeAddr0[3]), .B(1'b0), .CI(\add_225/carry[3] ), 
        .S(writeAddr2[3]) );
  HADDX1 \add_224/U1_1_1  ( .A0(writeAddr0[1]), .B0(writeAddr0[0]), .C1(
        \add_224/carry[2] ), .SO(writeAddr1[1]) );
  HADDX1 \add_224/U1_1_2  ( .A0(writeAddr0[2]), .B0(\add_224/carry[2] ), .C1(
        \add_224/carry[3] ), .SO(writeAddr1[2]) );
  HADDX1 \add_224/U1_1_3  ( .A0(writeAddr0[3]), .B0(\add_224/carry[3] ), .SO(
        writeAddr1[3]) );
  FADDX1 \add_0_root_add_3_root_add_278_8/U1_1  ( .A(N73), .B(N78), .CI(
        \add_0_root_add_3_root_add_278_8/carry[1] ), .CO(
        \add_0_root_add_3_root_add_278_8/carry[2] ), .S(N98) );
  FADDX1 \add_0_root_add_3_root_add_278_8/U1_2  ( .A(N74), .B(N79), .CI(
        \add_0_root_add_3_root_add_278_8/carry[2] ), .CO(
        \add_0_root_add_3_root_add_278_8/carry[3] ), .S(N99) );
  FADDX1 \add_2_root_add_3_root_add_278_8/U1_0  ( .A(decodedVector_i[6]), .B(
        instCount[0]), .CI(decodedVector_i[1]), .CO(
        \add_2_root_add_3_root_add_278_8/carry[1] ), .S(N77) );
  FADDX1 \add_1_root_add_3_root_add_278_8/U1_1  ( .A(N63), .B(N68), .CI(
        \add_1_root_add_3_root_add_278_8/carry[1] ), .CO(N74), .S(N73) );
  FADDX1 \add_4_root_add_3_root_add_278_8/U1_0  ( .A(decodedVector_i[2]), .B(
        decodedVector_i[0]), .CI(decodedVector_i[5]), .CO(N68), .S(N67) );
  FADDX1 \add_3_root_add_3_root_add_278_8/U1_0  ( .A(decodedVector_i[4]), .B(
        decodedVector_i[7]), .CI(decodedVector_i[3]), .CO(N63), .S(N62) );
  INVX0 \add_307/U0  ( .INP(N13), .ZN(readAddr1[0]) );
  INVX0 \add_224/U0  ( .INP(writeAddr0[0]), .ZN(writeAddr1[0]) );
  INVX0 U53 ( .INP(stallFetch_o), .ZN(n111) );
  INVX0 U54 ( .INP(n100), .ZN(n110) );
  INVX0 U55 ( .INP(N107), .ZN(n107) );
  INVX0 U56 ( .INP(n96), .ZN(n109) );
  INVX0 U57 ( .INP(n99), .ZN(instBufferReady_o) );
  NAND2X1 U58 ( .IN1(writeAddr0[1]), .IN2(n120), .QN(n118) );
  NAND2X1 U59 ( .IN1(decodeReady_i), .IN2(n111), .QN(n100) );
  NOR2X0 U60 ( .IN1(n118), .IN2(n119), .QN(n117) );
  INVX0 U61 ( .INP(writeAddr0[2]), .ZN(n119) );
  NOR2X0 U62 ( .IN1(stall_i), .IN2(n99), .QN(N107) );
  NOR2X0 U63 ( .IN1(n97), .IN2(n109), .QN(n105) );
  NAND2X1 U64 ( .IN1(N107), .IN2(headPtr[2]), .QN(n98) );
  NOR2X0 U65 ( .IN1(n94), .IN2(n109), .QN(n102) );
  NOR2X0 U66 ( .IN1(reset), .IN2(flush_i), .QN(n96) );
  NAND2X1 U67 ( .IN1(N3), .IN2(decodedPacket3_o[121]), .QN(n126) );
  XNOR2X1 U68 ( .IN1(\sub_284_aco/carry[4] ), .IN2(N106), .Q(instcnt_f[4]) );
  OR2X1 U69 ( .IN1(\sub_284_aco/carry[3] ), .IN2(N105), .Q(
        \sub_284_aco/carry[4] ) );
  XNOR2X1 U70 ( .IN1(N105), .IN2(\sub_284_aco/carry[3] ), .Q(instcnt_f[3]) );
  OR2X1 U71 ( .IN1(n107), .IN2(N104), .Q(\sub_284_aco/carry[3] ) );
  XNOR2X1 U72 ( .IN1(N104), .IN2(n107), .Q(instcnt_f[2]) );
  XOR2X1 U73 ( .IN1(N81), .IN2(\add_0_root_add_3_root_add_278_8/carry[4] ), 
        .Q(N101) );
  AND2X1 U74 ( .IN1(\add_0_root_add_3_root_add_278_8/carry[3] ), .IN2(N80), 
        .Q(\add_0_root_add_3_root_add_278_8/carry[4] ) );
  XOR2X1 U75 ( .IN1(N80), .IN2(\add_0_root_add_3_root_add_278_8/carry[3] ), 
        .Q(N100) );
  XOR2X1 U76 ( .IN1(instCount[4]), .IN2(
        \add_2_root_add_3_root_add_278_8/carry[4] ), .Q(N81) );
  AND2X1 U77 ( .IN1(\add_2_root_add_3_root_add_278_8/carry[3] ), .IN2(
        instCount[3]), .Q(\add_2_root_add_3_root_add_278_8/carry[4] ) );
  XOR2X1 U78 ( .IN1(instCount[3]), .IN2(
        \add_2_root_add_3_root_add_278_8/carry[3] ), .Q(N80) );
  AND2X1 U79 ( .IN1(\add_2_root_add_3_root_add_278_8/carry[2] ), .IN2(
        instCount[2]), .Q(\add_2_root_add_3_root_add_278_8/carry[3] ) );
  XOR2X1 U80 ( .IN1(instCount[2]), .IN2(
        \add_2_root_add_3_root_add_278_8/carry[2] ), .Q(N79) );
  AND2X1 U81 ( .IN1(\add_2_root_add_3_root_add_278_8/carry[1] ), .IN2(
        instCount[1]), .Q(\add_2_root_add_3_root_add_278_8/carry[2] ) );
  XOR2X1 U82 ( .IN1(instCount[1]), .IN2(
        \add_2_root_add_3_root_add_278_8/carry[1] ), .Q(N78) );
  AND2X1 U83 ( .IN1(N72), .IN2(N77), .Q(
        \add_0_root_add_3_root_add_278_8/carry[1] ) );
  XOR2X1 U84 ( .IN1(N77), .IN2(N72), .Q(N97) );
  AND2X1 U85 ( .IN1(N62), .IN2(N67), .Q(
        \add_1_root_add_3_root_add_278_8/carry[1] ) );
  XOR2X1 U86 ( .IN1(N67), .IN2(N62), .Q(N72) );
  OR2X1 U127 ( .IN1(instCount[1]), .IN2(instCount[0]), .Q(n108) );
  AO221X1 U128 ( .IN1(instCount[3]), .IN2(instCount[2]), .IN3(instCount[3]), 
        .IN4(n108), .IN5(instCount[4]), .Q(stallFetch_o) );
  XNOR2X1 U129 ( .IN1(N39), .IN2(n112), .Q(N55) );
  AOI22X1 U130 ( .IN1(n113), .IN2(N34), .IN3(n114), .IN4(N38), .QN(n112) );
  OR2X1 U131 ( .IN1(N38), .IN2(n114), .Q(n113) );
  XOR3X1 U132 ( .IN1(N34), .IN2(N38), .IN3(n114), .Q(N54) );
  AO22X1 U133 ( .IN1(N37), .IN2(n115), .IN3(N33), .IN4(n116), .Q(n114) );
  OR2X1 U134 ( .IN1(N37), .IN2(n115), .Q(n116) );
  XOR3X1 U135 ( .IN1(N33), .IN2(N37), .IN3(n115), .Q(N53) );
  AND2X1 U136 ( .IN1(N32), .IN2(N36), .Q(n115) );
  XOR2X1 U137 ( .IN1(N32), .IN2(N36), .Q(N52) );
  XOR2X1 U138 ( .IN1(writeAddr0[3]), .IN2(n117), .Q(N39) );
  XNOR2X1 U139 ( .IN1(writeAddr0[2]), .IN2(n118), .Q(N38) );
  XOR2X1 U140 ( .IN1(n120), .IN2(writeAddr0[1]), .Q(N37) );
  AO22X1 U141 ( .IN1(writeEnable7), .IN2(writeAddr0[0]), .IN3(writeEnable1), 
        .IN4(n121), .Q(n120) );
  XOR2X1 U142 ( .IN1(writeEnable1), .IN2(n121), .Q(N36) );
  XOR2X1 U143 ( .IN1(writeEnable7), .IN2(writeAddr0[0]), .Q(n121) );
  AO22X1 U144 ( .IN1(N29), .IN2(n122), .IN3(N25), .IN4(n123), .Q(N34) );
  OR2X1 U145 ( .IN1(N29), .IN2(n122), .Q(n123) );
  XOR3X1 U146 ( .IN1(N25), .IN2(N29), .IN3(n122), .Q(N33) );
  AND2X1 U147 ( .IN1(N24), .IN2(N28), .Q(n122) );
  XOR2X1 U148 ( .IN1(N24), .IN2(N28), .Q(N32) );
  AO22X1 U149 ( .IN1(writeEnable6), .IN2(writeEnable4), .IN3(writeEnable3), 
        .IN4(n124), .Q(N25) );
  XOR2X1 U150 ( .IN1(writeEnable3), .IN2(n124), .Q(N24) );
  XOR2X1 U151 ( .IN1(writeEnable6), .IN2(writeEnable4), .Q(n124) );
  AO22X1 U152 ( .IN1(writeEnable2), .IN2(writeEnable0), .IN3(writeEnable5), 
        .IN4(n125), .Q(N29) );
  XOR2X1 U153 ( .IN1(writeEnable5), .IN2(n125), .Q(N28) );
  XOR2X1 U154 ( .IN1(writeEnable2), .IN2(writeEnable0), .Q(n125) );
  AND3X1 U155 ( .IN1(N4), .IN2(decodedPacket3_o[121]), .IN3(N3), .Q(
        branchCount_o[2]) );
  XNOR2X1 U156 ( .IN1(N4), .IN2(n126), .Q(branchCount_o[1]) );
  XOR2X1 U157 ( .IN1(N3), .IN2(decodedPacket3_o[121]), .Q(branchCount_o[0]) );
  AO22X1 U158 ( .IN1(decodedPacket1_o[121]), .IN2(decodedPacket2_o[121]), 
        .IN3(decodedPacket0_o[121]), .IN4(n127), .Q(N4) );
  XOR2X1 U159 ( .IN1(decodedPacket0_o[121]), .IN2(n127), .Q(N3) );
  XOR2X1 U160 ( .IN1(decodedPacket1_o[121]), .IN2(decodedPacket2_o[121]), .Q(
        n127) );
endmodule

