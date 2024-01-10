############################################################
## This file is generated automatically by Vitis HLS.
## Please DO NOT edit it.
## Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
############################################################
open_project adder
set_top carry_lookahead_adder
add_files adder/carry_lookahead_adder.cpp
add_files adder/carry_lookahead_adder.h
add_files -tb adder/carry_lookahead_adder-tb.cpp
add_files -tb adder/carry_lookahead_adder-tb.h
open_solution "solution1" -flow_target vivado
set_part {xc7a100tcsg324-1}
create_clock -period 10 -name default
#source "./adder/solution1/directives.tcl"
csim_design
csynth_design
cosim_design
export_design -format ip_catalog
