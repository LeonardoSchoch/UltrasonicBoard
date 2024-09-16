transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vcom -93 -work work {C:/Users/leona/OneDrive - student.kit.edu/Dokumente/Git/UltrasonicBoard/Firmware/FPGA primary/src/PhaseLine.vhd}
vcom -93 -work work {C:/Users/leona/OneDrive - student.kit.edu/Dokumente/Git/UltrasonicBoard/Firmware/FPGA primary/src/Mux8.vhd}
vcom -93 -work work {C:/Users/leona/OneDrive - student.kit.edu/Dokumente/Git/UltrasonicBoard/Firmware/FPGA primary/src/AllChannels.vhd}

vcom -93 -work work {C:/Users/leona/OneDrive - student.kit.edu/Dokumente/Git/UltrasonicBoard/Firmware/FPGA primary/src/AllChannels_tb.vhd}

vsim -t 1ps -L altera -L lpm -L sgate -L altera_mf -L altera_lnsim -L cycloneive -L rtl_work -L work -voptargs="+acc"  AllChannels_tb

add wave *
view structure
view signals
run 50000 ns
