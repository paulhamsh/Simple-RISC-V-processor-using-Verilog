onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -radix hexadecimal /testbench_alu_integrated/clk
add wave -noupdate -radix hexadecimal /testbench_alu_integrated/uut/pc_current
add wave -noupdate -radix hexadecimal /testbench_alu_integrated/uut/instr
add wave -noupdate -radix hexadecimal /testbench_alu_integrated/uut/alu_op
add wave -noupdate -radix hexadecimal /testbench_alu_integrated/uut/rs1
add wave -noupdate -radix hexadecimal /testbench_alu_integrated/uut/rs1_value
add wave -noupdate -radix hexadecimal /testbench_alu_integrated/uut/rs2
add wave -noupdate -radix hexadecimal /testbench_alu_integrated/uut/rs2_value
add wave -noupdate -radix hexadecimal /testbench_alu_integrated/uut/alu_out
add wave -noupdate -radix hexadecimal /testbench_alu_integrated/uut/rd
add wave -noupdate -radix hexadecimal /testbench_alu_integrated/uut/rd_value
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {0 ps} 0}
quietly wave cursor active 0
configure wave -namecolwidth 150
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 0
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ns
update
WaveRestoreZoom {0 ps} {41344 ps}
