onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -radix hexadecimal /testbench_large_imm_integrated/clk
add wave -noupdate -radix hexadecimal /testbench_large_imm_integrated/uut/pc_current
add wave -noupdate -radix hexadecimal /testbench_large_imm_integrated/uut/instr
add wave -noupdate -radix hexadecimal /testbench_large_imm_integrated/uut/alu_out
add wave -noupdate -radix hexadecimal /testbench_large_imm_integrated/uut/reg_write_en
add wave -noupdate -radix hexadecimal /testbench_large_imm_integrated/uut/alu_a_value
add wave -noupdate -radix hexadecimal /testbench_large_imm_integrated/uut/alu_b_value
add wave -noupdate -radix hexadecimal /testbench_large_imm_integrated/uut/rd_value
add wave -noupdate -radix hexadecimal {/testbench_large_imm_integrated/uut/regs/reg_array[1]}
add wave -noupdate -radix hexadecimal {/testbench_large_imm_integrated/uut/regs/reg_array[2]}
add wave -noupdate -radix hexadecimal {/testbench_large_imm_integrated/uut/regs/reg_array[3]}
add wave -noupdate -radix hexadecimal {/testbench_large_imm_integrated/uut/regs/reg_array[4]}
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
