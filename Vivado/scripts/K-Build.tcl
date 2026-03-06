set PROJECT K-Data-Aligned
set DIR $PATH/$PROJECT

create_project -force $PROJECT $DIR -part $PART

add_files $DIR/src/alu.v 
add_files $DIR/src/branch.v 
add_files $DIR/src/control_unit.v 
add_files $DIR/src/data_memory.v
add_files $DIR/src/imm.v 
add_files $DIR/src/instruction_memory.v 
add_files $DIR/src/processor.v 
add_files $DIR/src/registers.v 

add_files $DIR/src/test_prog.mem 
add_files $DIR/src/test_data.mem

add_files -fileset sim_1 $DIR/src/testbench_data_memory_aligned.v 
add_files -fileset sim_1 $DIR/src/testbench_data_memory_aligned_integrated.v 
add_files -fileset sim_1 $DIR/src/testbench_data_memory_aligned_integrated_behav.wcfg 

import_files -force

update_compile_order -fileset sources_1
update_compile_order -fileset sim_1

close_project

