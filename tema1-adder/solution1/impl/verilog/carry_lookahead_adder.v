// ==============================================================
// RTL generated by Vitis HLS - High-Level Synthesis from C, C++ and OpenCL v2022.1 (64-bit)
// Version: 2022.1
// Copyright (C) Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
// 
// ===========================================================

`timescale 1 ns / 1 ps 

(* CORE_GENERATION_INFO="carry_lookahead_adder_carry_lookahead_adder,hls_ip_2022_1,{HLS_INPUT_TYPE=cxx,HLS_INPUT_FLOAT=0,HLS_INPUT_FIXED=0,HLS_INPUT_PART=xc7a100t-csg324-1,HLS_INPUT_CLOCK=10.000000,HLS_INPUT_ARCH=others,HLS_SYN_CLOCK=6.260000,HLS_SYN_LAT=18,HLS_SYN_TPT=none,HLS_SYN_MEM=0,HLS_SYN_DSP=0,HLS_SYN_FF=14,HLS_SYN_LUT=77,HLS_VERSION=2022_1}" *)

module carry_lookahead_adder (
        ap_clk,
        ap_rst,
        a_address0,
        a_ce0,
        a_q0,
        b_address0,
        b_ce0,
        b_q0,
        sum_address0,
        sum_ce0,
        sum_we0,
        sum_d0,
        ap_return
);

parameter    ap_ST_fsm_pp0_stage0 = 1'd1;

input   ap_clk;
input   ap_rst;
output  [3:0] a_address0;
output   a_ce0;
input  [0:0] a_q0;
output  [3:0] b_address0;
output   b_ce0;
input  [0:0] b_q0;
output  [3:0] sum_address0;
output   sum_ce0;
output   sum_we0;
output  [0:0] sum_d0;
output  [0:0] ap_return;

reg a_ce0;
reg b_ce0;
reg sum_ce0;
reg sum_we0;

(* fsm_encoding = "none" *) reg   [0:0] ap_CS_fsm;
wire    ap_CS_fsm_pp0_stage0;
wire    ap_block_state1_pp0_stage0_iter0;
wire    ap_block_state2_pp0_stage0_iter1;
wire    ap_block_pp0_stage0_subdone;
wire   [0:0] icmp_ln15_fu_110_p2;
reg    ap_condition_exit_pp0_iter0_stage0;
reg    ap_ready_int;
reg   [0:0] carry_reg_91;
reg   [0:0] icmp_ln15_reg_171;
wire    ap_block_pp0_stage0_11001;
wire   [63:0] i_cast_fu_122_p1;
reg   [63:0] i_cast_reg_175;
wire   [0:0] carry_1_fu_158_p2;
reg    ap_enable_reg_pp0_iter1;
reg   [0:0] ap_phi_mux_carry_phi_fu_94_p4;
wire    ap_block_pp0_stage0;
wire    ap_loop_init;
reg   [4:0] i_fu_48;
wire   [4:0] add_ln15_fu_116_p2;
reg   [4:0] ap_sig_allocacmp_i_1;
wire   [0:0] p_fu_133_p2;
wire   [0:0] g_fu_146_p2;
wire   [0:0] and_ln19_fu_152_p2;
reg   [0:0] ap_NS_fsm;
reg    ap_idle_pp0;
wire    ap_enable_pp0;
wire    ap_start_int;
wire    ap_ready;
wire    ap_done;
wire    ap_continue_int;
reg    ap_condition_162;
reg    ap_condition_165;
reg    ap_condition_95;
wire    ap_ce_reg;

// power-on initialization
initial begin
#0 ap_CS_fsm = 1'd1;
#0 ap_enable_reg_pp0_iter1 = 1'b0;
end

carry_lookahead_adder_flow_control_loop_pipe_no_ap_cont flow_control_loop_pipe_no_ap_cont_U(
    .ap_clk(ap_clk),
    .ap_rst(ap_rst),
    .ap_start(1'b1),
    .ap_ready(ap_ready),
    .ap_done(ap_done),
    .ap_start_int(ap_start_int),
    .ap_loop_init(ap_loop_init),
    .ap_ready_int(ap_ready_int),
    .ap_loop_exit_ready(ap_condition_exit_pp0_iter0_stage0),
    .ap_loop_exit_done(1'b0),
    .ap_continue_int(ap_continue_int),
    .ap_done_int(1'b0)
);

always @ (posedge ap_clk) begin
    if (ap_rst == 1'b1) begin
        ap_CS_fsm <= ap_ST_fsm_pp0_stage0;
    end else begin
        ap_CS_fsm <= ap_NS_fsm;
    end
end

always @ (posedge ap_clk) begin
    if (ap_rst == 1'b1) begin
        ap_enable_reg_pp0_iter1 <= 1'b0;
    end else begin
        if ((1'b1 == ap_condition_exit_pp0_iter0_stage0)) begin
            ap_enable_reg_pp0_iter1 <= 1'b0;
        end else if (((1'b1 == ap_CS_fsm_pp0_stage0) & (1'b0 == ap_block_pp0_stage0_subdone))) begin
            ap_enable_reg_pp0_iter1 <= 1'b1;
        end
    end
end

always @ (posedge ap_clk) begin
    if ((1'b1 == ap_CS_fsm_pp0_stage0)) begin
        if (((ap_loop_init == 1'b1) & (1'b0 == ap_block_pp0_stage0_subdone))) begin
            carry_reg_91 <= 1'd0;
        end else if ((1'b1 == ap_condition_165)) begin
            carry_reg_91 <= carry_1_fu_158_p2;
        end
    end
end

always @ (posedge ap_clk) begin
    if ((1'b1 == ap_condition_95)) begin
        if ((icmp_ln15_fu_110_p2 == 1'd0)) begin
            i_fu_48 <= add_ln15_fu_116_p2;
        end else if ((ap_loop_init == 1'b1)) begin
            i_fu_48 <= 5'd0;
        end
    end
end

always @ (posedge ap_clk) begin
    if (((icmp_ln15_fu_110_p2 == 1'd0) & (1'b1 == ap_CS_fsm_pp0_stage0) & (1'b0 == ap_block_pp0_stage0_11001))) begin
        i_cast_reg_175[4 : 0] <= i_cast_fu_122_p1[4 : 0];
    end
end

always @ (posedge ap_clk) begin
    if (((1'b1 == ap_CS_fsm_pp0_stage0) & (1'b0 == ap_block_pp0_stage0_11001))) begin
        icmp_ln15_reg_171 <= icmp_ln15_fu_110_p2;
    end
end

always @ (*) begin
    if (((1'b1 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (1'b0 == ap_block_pp0_stage0_11001))) begin
        a_ce0 = 1'b1;
    end else begin
        a_ce0 = 1'b0;
    end
end

always @ (*) begin
    if (((icmp_ln15_fu_110_p2 == 1'd1) & (1'b1 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (1'b0 == ap_block_pp0_stage0_subdone))) begin
        ap_condition_exit_pp0_iter0_stage0 = 1'b1;
    end else begin
        ap_condition_exit_pp0_iter0_stage0 = 1'b0;
    end
end

always @ (*) begin
    if (((ap_enable_reg_pp0_iter1 == 1'b0) & (1'b1 == 1'b0))) begin
        ap_idle_pp0 = 1'b1;
    end else begin
        ap_idle_pp0 = 1'b0;
    end
end

always @ (*) begin
    if ((1'b1 == ap_CS_fsm_pp0_stage0)) begin
        if ((ap_loop_init == 1'b1)) begin
            ap_phi_mux_carry_phi_fu_94_p4 = 1'd0;
        end else if ((1'b1 == ap_condition_162)) begin
            ap_phi_mux_carry_phi_fu_94_p4 = carry_1_fu_158_p2;
        end else begin
            ap_phi_mux_carry_phi_fu_94_p4 = 1'd0;
        end
    end else begin
        ap_phi_mux_carry_phi_fu_94_p4 = 1'd0;
    end
end

always @ (*) begin
    if (((1'b1 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (1'b0 == ap_block_pp0_stage0_subdone))) begin
        ap_ready_int = 1'b1;
    end else begin
        ap_ready_int = 1'b0;
    end
end

always @ (*) begin
    if (((ap_loop_init == 1'b1) & (1'b1 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (1'b0 == ap_block_pp0_stage0))) begin
        ap_sig_allocacmp_i_1 = 5'd0;
    end else begin
        ap_sig_allocacmp_i_1 = i_fu_48;
    end
end

always @ (*) begin
    if (((1'b1 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (1'b0 == ap_block_pp0_stage0_11001))) begin
        b_ce0 = 1'b1;
    end else begin
        b_ce0 = 1'b0;
    end
end

always @ (*) begin
    if (((ap_enable_reg_pp0_iter1 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (1'b0 == ap_block_pp0_stage0_11001))) begin
        sum_ce0 = 1'b1;
    end else begin
        sum_ce0 = 1'b0;
    end
end

always @ (*) begin
    if (((ap_enable_reg_pp0_iter1 == 1'b1) & (icmp_ln15_reg_171 == 1'd0) & (1'b1 == ap_CS_fsm_pp0_stage0) & (1'b0 == ap_block_pp0_stage0_11001))) begin
        sum_we0 = 1'b1;
    end else begin
        sum_we0 = 1'b0;
    end
end

always @ (*) begin
    case (ap_CS_fsm)
        ap_ST_fsm_pp0_stage0 : begin
            ap_NS_fsm = ap_ST_fsm_pp0_stage0;
        end
        default : begin
            ap_NS_fsm = 'bx;
        end
    endcase
end

assign a_address0 = i_cast_fu_122_p1;

assign add_ln15_fu_116_p2 = (ap_sig_allocacmp_i_1 + 5'd1);

assign and_ln19_fu_152_p2 = (p_fu_133_p2 & carry_reg_91);

assign ap_CS_fsm_pp0_stage0 = ap_CS_fsm[32'd0];

assign ap_block_pp0_stage0 = ~(1'b1 == 1'b1);

assign ap_block_pp0_stage0_11001 = ~(1'b1 == 1'b1);

assign ap_block_pp0_stage0_subdone = ~(1'b1 == 1'b1);

assign ap_block_state1_pp0_stage0_iter0 = ~(1'b1 == 1'b1);

assign ap_block_state2_pp0_stage0_iter1 = ~(1'b1 == 1'b1);

always @ (*) begin
    ap_condition_162 = ((ap_enable_reg_pp0_iter1 == 1'b1) & (icmp_ln15_reg_171 == 1'd0) & (1'b0 == ap_block_pp0_stage0));
end

always @ (*) begin
    ap_condition_165 = ((ap_enable_reg_pp0_iter1 == 1'b1) & (icmp_ln15_reg_171 == 1'd0) & (1'b0 == ap_block_pp0_stage0_11001));
end

always @ (*) begin
    ap_condition_95 = ((1'b1 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (1'b0 == ap_block_pp0_stage0_11001));
end

assign ap_enable_pp0 = (ap_idle_pp0 ^ 1'b1);

assign ap_return = ap_phi_mux_carry_phi_fu_94_p4;

assign b_address0 = i_cast_fu_122_p1;

assign carry_1_fu_158_p2 = (g_fu_146_p2 | and_ln19_fu_152_p2);

assign g_fu_146_p2 = (b_q0 & a_q0);

assign i_cast_fu_122_p1 = ap_sig_allocacmp_i_1;

assign icmp_ln15_fu_110_p2 = ((ap_sig_allocacmp_i_1 == 5'd16) ? 1'b1 : 1'b0);

assign p_fu_133_p2 = (b_q0 ^ a_q0);

assign sum_address0 = i_cast_reg_175;

assign sum_d0 = (p_fu_133_p2 ^ carry_reg_91);

always @ (posedge ap_clk) begin
    i_cast_reg_175[63:5] <= 59'b00000000000000000000000000000000000000000000000000000000000;
end

endmodule //carry_lookahead_adder