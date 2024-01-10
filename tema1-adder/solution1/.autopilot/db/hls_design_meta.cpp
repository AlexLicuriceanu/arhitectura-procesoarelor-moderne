#include "hls_design_meta.h"
const Port_Property HLS_Design_Meta::port_props[]={
	Port_Property("ap_clk", 1, hls_in, -1, "", "", 1),
	Port_Property("ap_rst", 1, hls_in, -1, "", "", 1),
	Port_Property("a_address0", 4, hls_out, 0, "ap_memory", "mem_address", 1),
	Port_Property("a_ce0", 1, hls_out, 0, "ap_memory", "mem_ce", 1),
	Port_Property("a_q0", 1, hls_in, 0, "ap_memory", "in_data", 1),
	Port_Property("b_address0", 4, hls_out, 1, "ap_memory", "mem_address", 1),
	Port_Property("b_ce0", 1, hls_out, 1, "ap_memory", "mem_ce", 1),
	Port_Property("b_q0", 1, hls_in, 1, "ap_memory", "in_data", 1),
	Port_Property("sum_address0", 4, hls_out, 2, "ap_memory", "mem_address", 1),
	Port_Property("sum_ce0", 1, hls_out, 2, "ap_memory", "mem_ce", 1),
	Port_Property("sum_we0", 1, hls_out, 2, "ap_memory", "mem_we", 1),
	Port_Property("sum_d0", 1, hls_out, 2, "ap_memory", "mem_din", 1),
	Port_Property("ap_return", 1, hls_out, -1, "", "", 1),
};
const char* HLS_Design_Meta::dut_name = "carry_lookahead_adder";
