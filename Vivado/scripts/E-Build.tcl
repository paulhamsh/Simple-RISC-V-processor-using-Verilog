set PROJECT E-ALU
set DIR $PATH/$PROJECT

create_project -force $PROJECT $DIR -part $PART

add_files $DIR/src/alu.v 
add_files $DIR/src/control_unit.v 
add_files $DIR/src/instruction_memory.v 
add_files $DIR/src/processor.v 
add_files $DIR/src/registers.v 

add_files $DIR/src/test_prog.mem 

add_files -fileset sim_1 $DIR/src/testbench_alu.v 
add_files -fileset sim_1 $DIR/src/testbench_alu_integrated.v 
add_files -fileset sim_1 $DIR/src/testbench_alu_integrated_behav.wcfg 

import_files -force

update_compile_order -fileset sources_1
update_compile_order -fileset sim_1

close_project

