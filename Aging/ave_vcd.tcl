set power_enable_analysis TRUE
set power_analysis_mode averaged


#####################################################################
# Read and link the Gate Level Netlist
#####################################################################
set target_library "./saed90nm_typ_ht.db"
set link_library "* ./saed90nm_typ_ht.db"
read_db -library saed90nm_typ_ht.db
read_verilog   Decode.v
current_design Decode
link
#####################################################################
#       set transition time / annotate parasitics
#####################################################################
read_sdc ./Decode.sdc
read_parasitics ./parasitic_file_Decode.spef
#####################################################################
#       check/update/report timing 
#####################################################################
check_timing
update_timing
report_timing
#####################################################################
#       read switching activity file
#####################################################################
read_vcd "./Decode.vcd" -path "Decode" -strip_path "Decode"
report_switching_activity -list_not_annotated
#####################################################################
#       check/update/report power 
#####################################################################
check_power
update_power
report_power

quit
