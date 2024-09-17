transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -vlog01compat -work work +incdir+C:/Users/leona/OneDrive\ -\ student.kit.edu/Dokumente/Git/UltrasonicBoard/Firmware/FPGA\ primary/db {C:/Users/leona/OneDrive - student.kit.edu/Dokumente/Git/UltrasonicBoard/Firmware/FPGA primary/db/masterclock_altpll.v}
vcom -93 -work work {C:/Users/leona/OneDrive - student.kit.edu/Dokumente/Git/UltrasonicBoard/Firmware/FPGA primary/src/Distribute.vhd}
vcom -93 -work work {C:/Users/leona/OneDrive - student.kit.edu/Dokumente/Git/UltrasonicBoard/Firmware/FPGA primary/src/Divider.vhd}
vcom -93 -work work {C:/Users/leona/OneDrive - student.kit.edu/Dokumente/Git/UltrasonicBoard/Firmware/FPGA primary/src/RSSFilter_1.vhd}
vcom -93 -work work {C:/Users/leona/OneDrive - student.kit.edu/Dokumente/Git/UltrasonicBoard/Firmware/FPGA primary/src/UARTReader.vhd}
vcom -93 -work work {C:/Users/leona/OneDrive - student.kit.edu/Dokumente/Git/UltrasonicBoard/Firmware/FPGA primary/src/PhaseLine.vhd}
vcom -93 -work work {C:/Users/leona/OneDrive - student.kit.edu/Dokumente/Git/UltrasonicBoard/Firmware/FPGA primary/src/Masterclock.vhd}
vcom -93 -work work {C:/Users/leona/OneDrive - student.kit.edu/Dokumente/Git/UltrasonicBoard/Firmware/FPGA primary/src/Counter.vhd}
vcom -93 -work work {C:/Users/leona/OneDrive - student.kit.edu/Dokumente/Git/UltrasonicBoard/Firmware/FPGA primary/src/Mux8.vhd}
vcom -93 -work work {C:/Users/leona/OneDrive - student.kit.edu/Dokumente/Git/UltrasonicBoard/Firmware/FPGA primary/src/AllChannels.vhd}
vcom -93 -work work {C:/Users/leona/OneDrive - student.kit.edu/Dokumente/Git/UltrasonicBoard/Firmware/FPGA primary/src/PulseExpander.vhd}
vcom -93 -work work {C:/Users/leona/OneDrive - student.kit.edu/Dokumente/Git/UltrasonicBoard/Firmware/FPGA primary/src/LatchBuffer.vhd}

vcom -93 -work work {C:/Users/leona/OneDrive - student.kit.edu/Dokumente/Git/UltrasonicBoard/Firmware/FPGA primary/src/UARTReader_tb.vhd}

vsim -t 1ps -L altera -L lpm -L sgate -L altera_mf -L altera_lnsim -L cycloneive -L rtl_work -L work -voptargs="+acc"  UARTReader_tb

add wave *
view structure
view signals
run 50000 ns
