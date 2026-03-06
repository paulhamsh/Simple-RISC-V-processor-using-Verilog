set PROJECT A-Program-Counter
set DIR $PATH/$PROJECT

create_project -force $PROJECT $DIR -part $PART

add_files $DIR/src/processor.v 

add_files -fileset sim_1 $DIR/src/testbench_pc.v 
add_files -fileset sim_1 $DIR/src/testbench_pc_behav.wcfg 

import_files -force

update_compile_order -fileset sources_1
update_compile_order -fileset sim_1

close_project

