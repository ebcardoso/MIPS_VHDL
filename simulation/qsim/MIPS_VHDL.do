onerror {exit -code 1}
vlib work
vlog -work work MIPS_VHDL.vo
vlog -work work simul.vwf.vt
vsim -novopt -c -t 1ps -L cycloneive_ver -L altera_ver -L altera_mf_ver -L 220model_ver -L sgate_ver -L altera_lnsim_ver work.mips_vhdl_vlg_vec_tst -voptargs="+acc"
vcd file -direction MIPS_VHDL.msim.vcd
vcd add -internal mips_vhdl_vlg_vec_tst/*
vcd add -internal mips_vhdl_vlg_vec_tst/i1/*
run -all
quit -f
