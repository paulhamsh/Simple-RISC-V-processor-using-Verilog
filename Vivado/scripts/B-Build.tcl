set PROJECT B-Instruction-Memory
set DIR $PATH/$PROJECT

create_project -force $PROJECT $DIR -part $PART

add_files $DIR/src/instruction_memory.v 
add_files $DIR/src/processor.v 

add_files $DIR/src/test_prog.mem 

add_files -fileset sim_1 $DIR/src/testbench_instruction_memory.v 
add_files -fileset sim_1 $DIR/src/testbench_instruction_memory_integrated.v 
add_files -fileset sim_1 $DIR/src/testbench_instruction_memory_integrated_behav.wcfg 

import_files -force

update_compile_order -fileset sources_1
update_compile_order -fileset sim_1

close_project

