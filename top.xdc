## Clock signal
set_property PACKAGE_PIN W5 [get_ports clk]
	set_property IOSTANDARD LVCMOS33 [get_ports clk]
	create_clock -add -name sys_clk_pin -period 10.00 -waveform {0 5} [get_ports clk]
	
#ButtonD for Reset
set_property PACKAGE_PIN U17 [get_ports reset]
	set_property IOSTANDARD LVCMOS33 [get_ports reset]
	
#ButtonC for Up/Down
set_property PACKAGE_PIN U18 [get_ports dir]
	set_property IOSTANDARD LVCMOS33 [get_ports dir]

#set_property PACKAGE_PIN V17 [get_ports {dir}]
#	set_property IOSTANDARD LVCMOS33 [get_ports {dir}]
	
#SW5 for Count start stop
set_property PACKAGE_PIN V15 [get_ports {cnt}]
	set_property IOSTANDARD LVCMOS33 [get_ports {cnt}]

#7 Segment Display
set_property PACKAGE_PIN W7 [get_ports {segout[6]}]
	set_property IOSTANDARD LVCMOS33 [get_ports {segout[6]}]
set_property PACKAGE_PIN W6 [get_ports {segout[5]}]
	set_property IOSTANDARD LVCMOS33 [get_ports {segout[5]}]
set_property PACKAGE_PIN U8 [get_ports {segout[4]}]
	set_property IOSTANDARD LVCMOS33 [get_ports {segout[4]}]
set_property PACKAGE_PIN V8 [get_ports {segout[3]}]
	set_property IOSTANDARD LVCMOS33 [get_ports {segout[3]}]
set_property PACKAGE_PIN U5 [get_ports {segout[2]}]
	set_property IOSTANDARD LVCMOS33 [get_ports {segout[2]}]
set_property PACKAGE_PIN V5 [get_ports {segout[1]}]
	set_property IOSTANDARD LVCMOS33 [get_ports {segout[1]}]
set_property PACKAGE_PIN U7 [get_ports {segout[0]}]
	set_property IOSTANDARD LVCMOS33 [get_ports {segout[0]}]

set_property PACKAGE_PIN V7 [get_ports dp]
	set_property IOSTANDARD LVCMOS33 [get_ports dp]

#Anodes of 7 Segments
set_property PACKAGE_PIN U2 [get_ports {AnodeSelection[0]}]
	set_property IOSTANDARD LVCMOS33 [get_ports {AnodeSelection[0]}]
set_property PACKAGE_PIN U4 [get_ports {AnodeSelection[1]}]
	set_property IOSTANDARD LVCMOS33 [get_ports {AnodeSelection[1]}]
set_property PACKAGE_PIN V4 [get_ports {AnodeSelection[2]}]
	set_property IOSTANDARD LVCMOS33 [get_ports {AnodeSelection[2]}]
set_property PACKAGE_PIN W4 [get_ports {AnodeSelection[3]}]
	set_property IOSTANDARD LVCMOS33 [get_ports {AnodeSelection[3]}]