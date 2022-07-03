
################################################################
# This is a generated script based on design: mips
#
# Though there are limitations about the generated script,
# the main purpose of this utility is to make learning
# IP Integrator Tcl commands easier.
################################################################

namespace eval _tcl {
proc get_script_folder {} {
   set script_path [file normalize [info script]]
   set script_folder [file dirname $script_path]
   return $script_folder
}
}
variable script_folder
set script_folder [_tcl::get_script_folder]

################################################################
# Check if script is running in correct Vivado version.
################################################################
set scripts_vivado_version 2020.2
set current_vivado_version [version -short]

if { [string first $scripts_vivado_version $current_vivado_version] == -1 } {
   puts ""
   catch {common::send_gid_msg -ssname BD::TCL -id 2041 -severity "ERROR" "This script was generated using Vivado <$scripts_vivado_version> and is being run in <$current_vivado_version> of Vivado. Please run the script in Vivado <$scripts_vivado_version> then open the design in Vivado <$current_vivado_version>. Upgrade the design by running \"Tools => Report => Report IP Status...\", then run write_bd_tcl to create an updated script."}

   return 1
}

################################################################
# START
################################################################

# To test this script, run the following commands from Vivado Tcl console:
# source mips_script.tcl


# The design that will be created by this Tcl script contains the following 
# module references:
# RegFile, adder, alu, andGate, controlLogic, ctrlHDU, dataMemory, instructionMemory, mux, mux, mux, mux, mux, programCounter, shiftLeft, FU, mux2, mux2, regFileFW, pipeline, pipeline, pipeline, pipeline, pipeline, pipeline, pipeline, pipeline, pipeline, pipeline, pipeline, pipeline, pipeline, pipeline, pipeline, pipeline, pipeline, pipeline, pipeline, pipeline, pipeline, pipeline, pipeline, pipeline, pipeline, pipeline, pipeline, pipeline, pipeline, concat, pipeline, pipeline, pipeline, pipeline, pipeline, adder, signExtern

# Please add the sources of those modules before sourcing this Tcl script.

# If there is no project opened, this script will create a
# project, but make sure you do not have an existing project
# <./myproj/project_1.xpr> in the current working folder.

set list_projs [get_projects -quiet]
if { $list_projs eq "" } {
   create_project project_1 myproj -part xc7z020clg400-1
   set_property BOARD_PART digilentinc.com:zybo-z7-20:part0:1.0 [current_project]
}


# CHANGE DESIGN NAME HERE
variable design_name
set design_name mips

# If you do not already have an existing IP Integrator design open,
# you can create a design using the following command:
#    create_bd_design $design_name

# Creating design if needed
set errMsg ""
set nRet 0

set cur_design [current_bd_design -quiet]
set list_cells [get_bd_cells -quiet]

if { ${design_name} eq "" } {
   # USE CASES:
   #    1) Design_name not set

   set errMsg "Please set the variable <design_name> to a non-empty value."
   set nRet 1

} elseif { ${cur_design} ne "" && ${list_cells} eq "" } {
   # USE CASES:
   #    2): Current design opened AND is empty AND names same.
   #    3): Current design opened AND is empty AND names diff; design_name NOT in project.
   #    4): Current design opened AND is empty AND names diff; design_name exists in project.

   if { $cur_design ne $design_name } {
      common::send_gid_msg -ssname BD::TCL -id 2001 -severity "INFO" "Changing value of <design_name> from <$design_name> to <$cur_design> since current design is empty."
      set design_name [get_property NAME $cur_design]
   }
   common::send_gid_msg -ssname BD::TCL -id 2002 -severity "INFO" "Constructing design in IPI design <$cur_design>..."

} elseif { ${cur_design} ne "" && $list_cells ne "" && $cur_design eq $design_name } {
   # USE CASES:
   #    5) Current design opened AND has components AND same names.

   set errMsg "Design <$design_name> already exists in your project, please set the variable <design_name> to another value."
   set nRet 1
} elseif { [get_files -quiet ${design_name}.bd] ne "" } {
   # USE CASES: 
   #    6) Current opened design, has components, but diff names, design_name exists in project.
   #    7) No opened design, design_name exists in project.

   set errMsg "Design <$design_name> already exists in your project, please set the variable <design_name> to another value."
   set nRet 2

} else {
   # USE CASES:
   #    8) No opened design, design_name not in project.
   #    9) Current opened design, has components, but diff names, design_name not in project.

   common::send_gid_msg -ssname BD::TCL -id 2003 -severity "INFO" "Currently there is no design <$design_name> in project, so creating one..."

   create_bd_design $design_name

   common::send_gid_msg -ssname BD::TCL -id 2004 -severity "INFO" "Making design <$design_name> as current_bd_design."
   current_bd_design $design_name

}

common::send_gid_msg -ssname BD::TCL -id 2005 -severity "INFO" "Currently the variable <design_name> is equal to \"$design_name\"."

if { $nRet != 0 } {
   catch {common::send_gid_msg -ssname BD::TCL -id 2006 -severity "ERROR" $errMsg}
   return $nRet
}

##################################################################
# DESIGN PROCs
##################################################################


# Hierarchical cell: slice_and_Extend
proc create_hier_cell_slice_and_Extend { parentCell nameHier } {

  variable script_folder

  if { $parentCell eq "" || $nameHier eq "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2092 -severity "ERROR" "create_hier_cell_slice_and_Extend() - Empty argument(s)!"}
     return
  }

  # Get object for parentCell
  set parentObj [get_bd_cells $parentCell]
  if { $parentObj == "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2090 -severity "ERROR" "Unable to find parent cell <$parentCell>!"}
     return
  }

  # Make sure parentObj is hier blk
  set parentType [get_property TYPE $parentObj]
  if { $parentType ne "hier" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2091 -severity "ERROR" "Parent <$parentObj> has TYPE = <$parentType>. Expected to be <hier>."}
     return
  }

  # Save current instance; Restore later
  set oldCurInst [current_bd_instance .]

  # Set parent object as current
  current_bd_instance $parentObj

  # Create cell and set as current instance
  set hier_obj [create_bd_cell -type hier $nameHier]
  current_bd_instance $hier_obj

  # Create interface pins

  # Create pins
  create_bd_pin -dir I -from 31 -to 0 Din
  create_bd_pin -dir O -from 31 -to 0 outData

  # Create instance: signExtern_0, and set properties
  set block_name signExtern
  set block_cell_name signExtern_0
  if { [catch {set signExtern_0 [create_bd_cell -type module -reference $block_name $block_cell_name] } errmsg] } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2095 -severity "ERROR" "Unable to add referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   } elseif { $signExtern_0 eq "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2096 -severity "ERROR" "Unable to referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   }
  
  # Create instance: xlslice_3, and set properties
  set xlslice_3 [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 xlslice_3 ]
  set_property -dict [ list \
   CONFIG.DIN_FROM {15} \
   CONFIG.DOUT_WIDTH {16} \
 ] $xlslice_3

  # Create port connections
  connect_bd_net -net pipeline_0_Q [get_bd_pins Din] [get_bd_pins xlslice_3/Din]
  connect_bd_net -net signExtern_0_outData [get_bd_pins outData] [get_bd_pins signExtern_0/outData]
  connect_bd_net -net xlslice_3_Dout [get_bd_pins signExtern_0/inData] [get_bd_pins xlslice_3/Dout]

  # Restore current instance
  current_bd_instance $oldCurInst
}

# Hierarchical cell: instructionSlice
proc create_hier_cell_instructionSlice { parentCell nameHier } {

  variable script_folder

  if { $parentCell eq "" || $nameHier eq "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2092 -severity "ERROR" "create_hier_cell_instructionSlice() - Empty argument(s)!"}
     return
  }

  # Get object for parentCell
  set parentObj [get_bd_cells $parentCell]
  if { $parentObj == "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2090 -severity "ERROR" "Unable to find parent cell <$parentCell>!"}
     return
  }

  # Make sure parentObj is hier blk
  set parentType [get_property TYPE $parentObj]
  if { $parentType ne "hier" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2091 -severity "ERROR" "Parent <$parentObj> has TYPE = <$parentType>. Expected to be <hier>."}
     return
  }

  # Save current instance; Restore later
  set oldCurInst [current_bd_instance .]

  # Set parent object as current
  current_bd_instance $parentObj

  # Create cell and set as current instance
  set hier_obj [create_bd_cell -type hier $nameHier]
  current_bd_instance $hier_obj

  # Create interface pins

  # Create pins
  create_bd_pin -dir I -from 31 -to 0 Din
  create_bd_pin -dir O -from 4 -to 0 Dout
  create_bd_pin -dir O -from 4 -to 0 Dout1
  create_bd_pin -dir O -from 4 -to 0 Dout2

  # Create instance: xlslice_0, and set properties
  set xlslice_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 xlslice_0 ]
  set_property -dict [ list \
   CONFIG.DIN_FROM {25} \
   CONFIG.DIN_TO {21} \
   CONFIG.DOUT_WIDTH {5} \
 ] $xlslice_0

  # Create instance: xlslice_1, and set properties
  set xlslice_1 [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 xlslice_1 ]
  set_property -dict [ list \
   CONFIG.DIN_FROM {20} \
   CONFIG.DIN_TO {16} \
   CONFIG.DOUT_WIDTH {5} \
 ] $xlslice_1

  # Create instance: xlslice_2, and set properties
  set xlslice_2 [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 xlslice_2 ]
  set_property -dict [ list \
   CONFIG.DIN_FROM {15} \
   CONFIG.DIN_TO {11} \
   CONFIG.DOUT_WIDTH {5} \
 ] $xlslice_2

  # Create port connections
  connect_bd_net -net pipeline_0_Q [get_bd_pins Din] [get_bd_pins xlslice_0/Din] [get_bd_pins xlslice_1/Din] [get_bd_pins xlslice_2/Din]
  connect_bd_net -net xlslice_0_Dout [get_bd_pins Dout] [get_bd_pins xlslice_0/Dout]
  connect_bd_net -net xlslice_1_Dout [get_bd_pins Dout1] [get_bd_pins xlslice_1/Dout]
  connect_bd_net -net xlslice_2_Dout [get_bd_pins Dout2] [get_bd_pins xlslice_2/Dout]

  # Restore current instance
  current_bd_instance $oldCurInst
}

# Hierarchical cell: PCplus4Adder
proc create_hier_cell_PCplus4Adder { parentCell nameHier } {

  variable script_folder

  if { $parentCell eq "" || $nameHier eq "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2092 -severity "ERROR" "create_hier_cell_PCplus4Adder() - Empty argument(s)!"}
     return
  }

  # Get object for parentCell
  set parentObj [get_bd_cells $parentCell]
  if { $parentObj == "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2090 -severity "ERROR" "Unable to find parent cell <$parentCell>!"}
     return
  }

  # Make sure parentObj is hier blk
  set parentType [get_property TYPE $parentObj]
  if { $parentType ne "hier" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2091 -severity "ERROR" "Parent <$parentObj> has TYPE = <$parentType>. Expected to be <hier>."}
     return
  }

  # Save current instance; Restore later
  set oldCurInst [current_bd_instance .]

  # Set parent object as current
  current_bd_instance $parentObj

  # Create cell and set as current instance
  set hier_obj [create_bd_cell -type hier $nameHier]
  current_bd_instance $hier_obj

  # Create interface pins

  # Create pins
  create_bd_pin -dir O -from 31 -to 0 adderOut
  create_bd_pin -dir I -from 31 -to 0 op1

  # Create instance: adder_0, and set properties
  set block_name adder
  set block_cell_name adder_0
  if { [catch {set adder_0 [create_bd_cell -type module -reference $block_name $block_cell_name] } errmsg] } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2095 -severity "ERROR" "Unable to add referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   } elseif { $adder_0 eq "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2096 -severity "ERROR" "Unable to referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   }
    set_property -dict [ list \
   CONFIG.width {32} \
 ] $adder_0

  # Create instance: constantFour, and set properties
  set constantFour [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlconstant:1.1 constantFour ]
  set_property -dict [ list \
   CONFIG.CONST_VAL {4} \
   CONFIG.CONST_WIDTH {32} \
 ] $constantFour

  # Create port connections
  connect_bd_net -net adder_0_adderOut [get_bd_pins adderOut] [get_bd_pins adder_0/adderOut]
  connect_bd_net -net constantFour_dout [get_bd_pins adder_0/op2] [get_bd_pins constantFour/dout]
  connect_bd_net -net programCounter_0_pcOut [get_bd_pins op1] [get_bd_pins adder_0/op1]

  # Restore current instance
  current_bd_instance $oldCurInst
}

# Hierarchical cell: MEM_WB
proc create_hier_cell_MEM_WB { parentCell nameHier } {

  variable script_folder

  if { $parentCell eq "" || $nameHier eq "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2092 -severity "ERROR" "create_hier_cell_MEM_WB() - Empty argument(s)!"}
     return
  }

  # Get object for parentCell
  set parentObj [get_bd_cells $parentCell]
  if { $parentObj == "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2090 -severity "ERROR" "Unable to find parent cell <$parentCell>!"}
     return
  }

  # Make sure parentObj is hier blk
  set parentType [get_property TYPE $parentObj]
  if { $parentType ne "hier" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2091 -severity "ERROR" "Parent <$parentObj> has TYPE = <$parentType>. Expected to be <hier>."}
     return
  }

  # Save current instance; Restore later
  set oldCurInst [current_bd_instance .]

  # Set parent object as current
  current_bd_instance $parentObj

  # Create cell and set as current instance
  set hier_obj [create_bd_cell -type hier $nameHier]
  current_bd_instance $hier_obj

  # Create interface pins

  # Create pins
  create_bd_pin -dir I -from 31 -to 0 D
  create_bd_pin -dir I -from 31 -to 0 D1
  create_bd_pin -dir I -from 0 -to 0 D2
  create_bd_pin -dir I -from 0 -to 0 D3
  create_bd_pin -dir I -from 4 -to 0 D4
  create_bd_pin -dir O -from 31 -to 0 Q
  create_bd_pin -dir O -from 31 -to 0 Q1
  create_bd_pin -dir O -from 0 -to 0 Q2
  create_bd_pin -dir O -from 0 -to 0 Q3
  create_bd_pin -dir O -from 4 -to 0 Q4
  create_bd_pin -dir I -type clk in_clock

  # Create instance: pipeline_0, and set properties
  set block_name pipeline
  set block_cell_name pipeline_0
  if { [catch {set pipeline_0 [create_bd_cell -type module -reference $block_name $block_cell_name] } errmsg] } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2095 -severity "ERROR" "Unable to add referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   } elseif { $pipeline_0 eq "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2096 -severity "ERROR" "Unable to referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   }
  
  # Create instance: pipeline_1, and set properties
  set block_name pipeline
  set block_cell_name pipeline_1
  if { [catch {set pipeline_1 [create_bd_cell -type module -reference $block_name $block_cell_name] } errmsg] } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2095 -severity "ERROR" "Unable to add referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   } elseif { $pipeline_1 eq "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2096 -severity "ERROR" "Unable to referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   }
  
  # Create instance: pipeline_2, and set properties
  set block_name pipeline
  set block_cell_name pipeline_2
  if { [catch {set pipeline_2 [create_bd_cell -type module -reference $block_name $block_cell_name] } errmsg] } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2095 -severity "ERROR" "Unable to add referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   } elseif { $pipeline_2 eq "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2096 -severity "ERROR" "Unable to referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   }
    set_property -dict [ list \
   CONFIG.width {1} \
 ] $pipeline_2

  # Create instance: pipeline_3, and set properties
  set block_name pipeline
  set block_cell_name pipeline_3
  if { [catch {set pipeline_3 [create_bd_cell -type module -reference $block_name $block_cell_name] } errmsg] } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2095 -severity "ERROR" "Unable to add referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   } elseif { $pipeline_3 eq "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2096 -severity "ERROR" "Unable to referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   }
    set_property -dict [ list \
   CONFIG.width {1} \
 ] $pipeline_3

  # Create instance: pipeline_4, and set properties
  set block_name pipeline
  set block_cell_name pipeline_4
  if { [catch {set pipeline_4 [create_bd_cell -type module -reference $block_name $block_cell_name] } errmsg] } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2095 -severity "ERROR" "Unable to add referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   } elseif { $pipeline_4 eq "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2096 -severity "ERROR" "Unable to referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   }
    set_property -dict [ list \
   CONFIG.width {5} \
 ] $pipeline_4

  # Create instance: xlconstant_0, and set properties
  set xlconstant_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlconstant:1.1 xlconstant_0 ]

  # Create port connections
  connect_bd_net -net D2_1 [get_bd_pins D2] [get_bd_pins pipeline_2/D]
  connect_bd_net -net D3_1 [get_bd_pins D3] [get_bd_pins pipeline_3/D]
  connect_bd_net -net D4_1 [get_bd_pins D4] [get_bd_pins pipeline_4/D]
  connect_bd_net -net dataMemory_0_readData [get_bd_pins D1] [get_bd_pins pipeline_1/D]
  connect_bd_net -net i_clk_0_1 [get_bd_pins in_clock] [get_bd_pins pipeline_0/clk] [get_bd_pins pipeline_1/clk] [get_bd_pins pipeline_2/clk] [get_bd_pins pipeline_3/clk] [get_bd_pins pipeline_4/clk]
  connect_bd_net -net pipeline_0_Q2 [get_bd_pins D] [get_bd_pins pipeline_0/D]
  connect_bd_net -net pipeline_0_Q3 [get_bd_pins Q] [get_bd_pins pipeline_0/Q]
  connect_bd_net -net pipeline_1_Q3 [get_bd_pins Q1] [get_bd_pins pipeline_1/Q]
  connect_bd_net -net pipeline_2_Q [get_bd_pins Q2] [get_bd_pins pipeline_2/Q]
  connect_bd_net -net pipeline_3_Q [get_bd_pins Q3] [get_bd_pins pipeline_3/Q]
  connect_bd_net -net pipeline_4_Q [get_bd_pins Q4] [get_bd_pins pipeline_4/Q]
  connect_bd_net -net xlconstant_0_dout [get_bd_pins pipeline_0/En] [get_bd_pins pipeline_1/En] [get_bd_pins pipeline_2/En] [get_bd_pins pipeline_3/En] [get_bd_pins pipeline_4/En] [get_bd_pins xlconstant_0/dout]

  # Restore current instance
  current_bd_instance $oldCurInst
}

# Hierarchical cell: Jump_Block
proc create_hier_cell_Jump_Block { parentCell nameHier } {

  variable script_folder

  if { $parentCell eq "" || $nameHier eq "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2092 -severity "ERROR" "create_hier_cell_Jump_Block() - Empty argument(s)!"}
     return
  }

  # Get object for parentCell
  set parentObj [get_bd_cells $parentCell]
  if { $parentObj == "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2090 -severity "ERROR" "Unable to find parent cell <$parentCell>!"}
     return
  }

  # Make sure parentObj is hier blk
  set parentType [get_property TYPE $parentObj]
  if { $parentType ne "hier" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2091 -severity "ERROR" "Parent <$parentObj> has TYPE = <$parentType>. Expected to be <hier>."}
     return
  }

  # Save current instance; Restore later
  set oldCurInst [current_bd_instance .]

  # Set parent object as current
  current_bd_instance $parentObj

  # Create cell and set as current instance
  set hier_obj [create_bd_cell -type hier $nameHier]
  current_bd_instance $hier_obj

  # Create interface pins

  # Create pins
  create_bd_pin -dir I -from 31 -to 0 Din
  create_bd_pin -dir I -from 31 -to 0 Din1
  create_bd_pin -dir O -from 31 -to 0 address_jump

  # Create instance: concat_0, and set properties
  set block_name concat
  set block_cell_name concat_0
  if { [catch {set concat_0 [create_bd_cell -type module -reference $block_name $block_cell_name] } errmsg] } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2095 -severity "ERROR" "Unable to add referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   } elseif { $concat_0 eq "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2096 -severity "ERROR" "Unable to referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   }
  
  # Create instance: xlslice_4, and set properties
  set xlslice_4 [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 xlslice_4 ]
  set_property -dict [ list \
   CONFIG.DIN_FROM {31} \
   CONFIG.DIN_TO {28} \
   CONFIG.DOUT_WIDTH {4} \
 ] $xlslice_4

  # Create instance: xlslice_5, and set properties
  set xlslice_5 [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 xlslice_5 ]
  set_property -dict [ list \
   CONFIG.DIN_FROM {25} \
   CONFIG.DIN_TO {0} \
   CONFIG.DOUT_WIDTH {26} \
 ] $xlslice_5

  # Create port connections
  connect_bd_net -net concat_0_address_jump [get_bd_pins address_jump] [get_bd_pins concat_0/address_jump]
  connect_bd_net -net pipeline_0_Q [get_bd_pins Din] [get_bd_pins xlslice_5/Din]
  connect_bd_net -net pipeline_1_Q [get_bd_pins Din1] [get_bd_pins xlslice_4/Din]
  connect_bd_net -net xlslice_4_Dout [get_bd_pins concat_0/pc_plus_four] [get_bd_pins xlslice_4/Dout]
  connect_bd_net -net xlslice_5_Dout [get_bd_pins concat_0/instrn_25_to_0] [get_bd_pins xlslice_5/Dout]

  # Restore current instance
  current_bd_instance $oldCurInst
}

# Hierarchical cell: IF_ID
proc create_hier_cell_IF_ID { parentCell nameHier } {

  variable script_folder

  if { $parentCell eq "" || $nameHier eq "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2092 -severity "ERROR" "create_hier_cell_IF_ID() - Empty argument(s)!"}
     return
  }

  # Get object for parentCell
  set parentObj [get_bd_cells $parentCell]
  if { $parentObj == "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2090 -severity "ERROR" "Unable to find parent cell <$parentCell>!"}
     return
  }

  # Make sure parentObj is hier blk
  set parentType [get_property TYPE $parentObj]
  if { $parentType ne "hier" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2091 -severity "ERROR" "Parent <$parentObj> has TYPE = <$parentType>. Expected to be <hier>."}
     return
  }

  # Save current instance; Restore later
  set oldCurInst [current_bd_instance .]

  # Set parent object as current
  current_bd_instance $parentObj

  # Create cell and set as current instance
  set hier_obj [create_bd_cell -type hier $nameHier]
  current_bd_instance $hier_obj

  # Create interface pins

  # Create pins
  create_bd_pin -dir I -from 31 -to 0 D
  create_bd_pin -dir I -from 0 -to 0 D1
  create_bd_pin -dir I -from 0 -to 0 D2
  create_bd_pin -dir I -from 0 -to 0 D3
  create_bd_pin -dir I -from 2 -to 0 D5
  create_bd_pin -dir I -from 0 -to 0 D6
  create_bd_pin -dir I -from 0 -to 0 D7
  create_bd_pin -dir I -from 0 -to 0 D8
  create_bd_pin -dir I En
  create_bd_pin -dir O -from 31 -to 0 Q
  create_bd_pin -dir O -from 31 -to 0 Q1
  create_bd_pin -dir O -from 0 -to 0 Q2
  create_bd_pin -dir O -from 0 -to 0 Q3
  create_bd_pin -dir O -from 0 -to 0 Q4
  create_bd_pin -dir O -from 2 -to 0 Q6
  create_bd_pin -dir O -from 0 -to 0 Q7
  create_bd_pin -dir O -from 0 -to 0 Q8
  create_bd_pin -dir O -from 0 -to 0 Q9
  create_bd_pin -dir I -type clk in_clock
  create_bd_pin -dir I -from 31 -to 0 instruction

  # Create instance: pipeline_0, and set properties
  set block_name pipeline
  set block_cell_name pipeline_0
  if { [catch {set pipeline_0 [create_bd_cell -type module -reference $block_name $block_cell_name] } errmsg] } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2095 -severity "ERROR" "Unable to add referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   } elseif { $pipeline_0 eq "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2096 -severity "ERROR" "Unable to referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   }
  
  # Create instance: pipeline_1, and set properties
  set block_name pipeline
  set block_cell_name pipeline_1
  if { [catch {set pipeline_1 [create_bd_cell -type module -reference $block_name $block_cell_name] } errmsg] } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2095 -severity "ERROR" "Unable to add referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   } elseif { $pipeline_1 eq "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2096 -severity "ERROR" "Unable to referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   }
  
  # Create instance: pipeline_2, and set properties
  set block_name pipeline
  set block_cell_name pipeline_2
  if { [catch {set pipeline_2 [create_bd_cell -type module -reference $block_name $block_cell_name] } errmsg] } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2095 -severity "ERROR" "Unable to add referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   } elseif { $pipeline_2 eq "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2096 -severity "ERROR" "Unable to referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   }
    set_property -dict [ list \
   CONFIG.width {1} \
 ] $pipeline_2

  # Create instance: pipeline_3, and set properties
  set block_name pipeline
  set block_cell_name pipeline_3
  if { [catch {set pipeline_3 [create_bd_cell -type module -reference $block_name $block_cell_name] } errmsg] } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2095 -severity "ERROR" "Unable to add referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   } elseif { $pipeline_3 eq "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2096 -severity "ERROR" "Unable to referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   }
    set_property -dict [ list \
   CONFIG.width {1} \
 ] $pipeline_3

  # Create instance: pipeline_4, and set properties
  set block_name pipeline
  set block_cell_name pipeline_4
  if { [catch {set pipeline_4 [create_bd_cell -type module -reference $block_name $block_cell_name] } errmsg] } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2095 -severity "ERROR" "Unable to add referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   } elseif { $pipeline_4 eq "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2096 -severity "ERROR" "Unable to referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   }
    set_property -dict [ list \
   CONFIG.width {1} \
 ] $pipeline_4

  # Create instance: pipeline_6, and set properties
  set block_name pipeline
  set block_cell_name pipeline_6
  if { [catch {set pipeline_6 [create_bd_cell -type module -reference $block_name $block_cell_name] } errmsg] } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2095 -severity "ERROR" "Unable to add referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   } elseif { $pipeline_6 eq "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2096 -severity "ERROR" "Unable to referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   }
    set_property -dict [ list \
   CONFIG.width {3} \
 ] $pipeline_6

  # Create instance: pipeline_7, and set properties
  set block_name pipeline
  set block_cell_name pipeline_7
  if { [catch {set pipeline_7 [create_bd_cell -type module -reference $block_name $block_cell_name] } errmsg] } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2095 -severity "ERROR" "Unable to add referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   } elseif { $pipeline_7 eq "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2096 -severity "ERROR" "Unable to referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   }
    set_property -dict [ list \
   CONFIG.width {1} \
 ] $pipeline_7

  # Create instance: pipeline_8, and set properties
  set block_name pipeline
  set block_cell_name pipeline_8
  if { [catch {set pipeline_8 [create_bd_cell -type module -reference $block_name $block_cell_name] } errmsg] } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2095 -severity "ERROR" "Unable to add referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   } elseif { $pipeline_8 eq "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2096 -severity "ERROR" "Unable to referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   }
    set_property -dict [ list \
   CONFIG.width {1} \
 ] $pipeline_8

  # Create instance: pipeline_9, and set properties
  set block_name pipeline
  set block_cell_name pipeline_9
  if { [catch {set pipeline_9 [create_bd_cell -type module -reference $block_name $block_cell_name] } errmsg] } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2095 -severity "ERROR" "Unable to add referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   } elseif { $pipeline_9 eq "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2096 -severity "ERROR" "Unable to referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   }
    set_property -dict [ list \
   CONFIG.width {1} \
 ] $pipeline_9

  # Create port connections
  connect_bd_net -net D1_1 [get_bd_pins D1] [get_bd_pins pipeline_2/D]
  connect_bd_net -net D2_1 [get_bd_pins D2] [get_bd_pins pipeline_3/D]
  connect_bd_net -net D3_1 [get_bd_pins D3] [get_bd_pins pipeline_4/D]
  connect_bd_net -net D5_1 [get_bd_pins D5] [get_bd_pins pipeline_6/D]
  connect_bd_net -net D6_1 [get_bd_pins D6] [get_bd_pins pipeline_7/D]
  connect_bd_net -net D7_1 [get_bd_pins D7] [get_bd_pins pipeline_8/D]
  connect_bd_net -net D8_1 [get_bd_pins D8] [get_bd_pins pipeline_9/D]
  connect_bd_net -net En_1 [get_bd_pins En] [get_bd_pins pipeline_0/En] [get_bd_pins pipeline_1/En] [get_bd_pins pipeline_2/En] [get_bd_pins pipeline_3/En] [get_bd_pins pipeline_4/En] [get_bd_pins pipeline_6/En] [get_bd_pins pipeline_7/En] [get_bd_pins pipeline_8/En] [get_bd_pins pipeline_9/En]
  connect_bd_net -net adder_0_adderOut [get_bd_pins D] [get_bd_pins pipeline_1/D]
  connect_bd_net -net i_clk_0_1 [get_bd_pins in_clock] [get_bd_pins pipeline_0/clk] [get_bd_pins pipeline_1/clk] [get_bd_pins pipeline_2/clk] [get_bd_pins pipeline_3/clk] [get_bd_pins pipeline_4/clk] [get_bd_pins pipeline_6/clk] [get_bd_pins pipeline_7/clk] [get_bd_pins pipeline_8/clk] [get_bd_pins pipeline_9/clk]
  connect_bd_net -net instructionMemory_0_instruction [get_bd_pins instruction] [get_bd_pins pipeline_0/D]
  connect_bd_net -net pipeline_0_Q [get_bd_pins Q] [get_bd_pins pipeline_0/Q]
  connect_bd_net -net pipeline_1_Q [get_bd_pins Q1] [get_bd_pins pipeline_1/Q]
  connect_bd_net -net pipeline_2_Q [get_bd_pins Q2] [get_bd_pins pipeline_2/Q]
  connect_bd_net -net pipeline_3_Q [get_bd_pins Q3] [get_bd_pins pipeline_3/Q]
  connect_bd_net -net pipeline_4_Q [get_bd_pins Q4] [get_bd_pins pipeline_4/Q]
  connect_bd_net -net pipeline_6_Q [get_bd_pins Q6] [get_bd_pins pipeline_6/Q]
  connect_bd_net -net pipeline_7_Q [get_bd_pins Q7] [get_bd_pins pipeline_7/Q]
  connect_bd_net -net pipeline_8_Q [get_bd_pins Q8] [get_bd_pins pipeline_8/Q]
  connect_bd_net -net pipeline_9_Q [get_bd_pins Q9] [get_bd_pins pipeline_9/Q]

  # Restore current instance
  current_bd_instance $oldCurInst
}

# Hierarchical cell: ID_EX
proc create_hier_cell_ID_EX { parentCell nameHier } {

  variable script_folder

  if { $parentCell eq "" || $nameHier eq "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2092 -severity "ERROR" "create_hier_cell_ID_EX() - Empty argument(s)!"}
     return
  }

  # Get object for parentCell
  set parentObj [get_bd_cells $parentCell]
  if { $parentObj == "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2090 -severity "ERROR" "Unable to find parent cell <$parentCell>!"}
     return
  }

  # Make sure parentObj is hier blk
  set parentType [get_property TYPE $parentObj]
  if { $parentType ne "hier" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2091 -severity "ERROR" "Parent <$parentObj> has TYPE = <$parentType>. Expected to be <hier>."}
     return
  }

  # Save current instance; Restore later
  set oldCurInst [current_bd_instance .]

  # Set parent object as current
  current_bd_instance $parentObj

  # Create cell and set as current instance
  set hier_obj [create_bd_cell -type hier $nameHier]
  current_bd_instance $hier_obj

  # Create interface pins

  # Create pins
  create_bd_pin -dir I -from 31 -to 0 D
  create_bd_pin -dir I -from 31 -to 0 D1
  create_bd_pin -dir I -from 31 -to 0 D2
  create_bd_pin -dir I -from 31 -to 0 D3
  create_bd_pin -dir I -from 4 -to 0 D4
  create_bd_pin -dir I -from 0 -to 0 D5
  create_bd_pin -dir I -from 0 -to 0 D6
  create_bd_pin -dir I -from 2 -to 0 D7
  create_bd_pin -dir I -from 4 -to 0 D8
  create_bd_pin -dir I -from 0 -to 0 D9
  create_bd_pin -dir I -from 0 -to 0 D10
  create_bd_pin -dir I -from 0 -to 0 D11
  create_bd_pin -dir I -from 0 -to 0 D12
  create_bd_pin -dir I -from 4 -to 0 D13
  create_bd_pin -dir O -from 31 -to 0 Q
  create_bd_pin -dir O -from 31 -to 0 Q1
  create_bd_pin -dir O -from 31 -to 0 Q2
  create_bd_pin -dir O -from 31 -to 0 Q3
  create_bd_pin -dir O -from 4 -to 0 Q4
  create_bd_pin -dir O -from 0 -to 0 Q5
  create_bd_pin -dir O -from 0 -to 0 Q6
  create_bd_pin -dir O -from 2 -to 0 Q7
  create_bd_pin -dir O -from 4 -to 0 Q8
  create_bd_pin -dir O -from 0 -to 0 Q9
  create_bd_pin -dir O -from 0 -to 0 Q10
  create_bd_pin -dir O -from 0 -to 0 Q11
  create_bd_pin -dir O -from 0 -to 0 Q12
  create_bd_pin -dir O -from 4 -to 0 Q13
  create_bd_pin -dir I -type clk in_clock

  # Create instance: pipeline_0, and set properties
  set block_name pipeline
  set block_cell_name pipeline_0
  if { [catch {set pipeline_0 [create_bd_cell -type module -reference $block_name $block_cell_name] } errmsg] } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2095 -severity "ERROR" "Unable to add referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   } elseif { $pipeline_0 eq "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2096 -severity "ERROR" "Unable to referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   }
  
  # Create instance: pipeline_1, and set properties
  set block_name pipeline
  set block_cell_name pipeline_1
  if { [catch {set pipeline_1 [create_bd_cell -type module -reference $block_name $block_cell_name] } errmsg] } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2095 -severity "ERROR" "Unable to add referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   } elseif { $pipeline_1 eq "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2096 -severity "ERROR" "Unable to referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   }
  
  # Create instance: pipeline_2, and set properties
  set block_name pipeline
  set block_cell_name pipeline_2
  if { [catch {set pipeline_2 [create_bd_cell -type module -reference $block_name $block_cell_name] } errmsg] } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2095 -severity "ERROR" "Unable to add referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   } elseif { $pipeline_2 eq "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2096 -severity "ERROR" "Unable to referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   }
  
  # Create instance: pipeline_3, and set properties
  set block_name pipeline
  set block_cell_name pipeline_3
  if { [catch {set pipeline_3 [create_bd_cell -type module -reference $block_name $block_cell_name] } errmsg] } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2095 -severity "ERROR" "Unable to add referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   } elseif { $pipeline_3 eq "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2096 -severity "ERROR" "Unable to referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   }
  
  # Create instance: pipeline_4, and set properties
  set block_name pipeline
  set block_cell_name pipeline_4
  if { [catch {set pipeline_4 [create_bd_cell -type module -reference $block_name $block_cell_name] } errmsg] } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2095 -severity "ERROR" "Unable to add referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   } elseif { $pipeline_4 eq "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2096 -severity "ERROR" "Unable to referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   }
    set_property -dict [ list \
   CONFIG.width {5} \
 ] $pipeline_4

  # Create instance: pipeline_5, and set properties
  set block_name pipeline
  set block_cell_name pipeline_5
  if { [catch {set pipeline_5 [create_bd_cell -type module -reference $block_name $block_cell_name] } errmsg] } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2095 -severity "ERROR" "Unable to add referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   } elseif { $pipeline_5 eq "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2096 -severity "ERROR" "Unable to referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   }
    set_property -dict [ list \
   CONFIG.width {1} \
 ] $pipeline_5

  # Create instance: pipeline_6, and set properties
  set block_name pipeline
  set block_cell_name pipeline_6
  if { [catch {set pipeline_6 [create_bd_cell -type module -reference $block_name $block_cell_name] } errmsg] } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2095 -severity "ERROR" "Unable to add referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   } elseif { $pipeline_6 eq "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2096 -severity "ERROR" "Unable to referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   }
    set_property -dict [ list \
   CONFIG.width {1} \
 ] $pipeline_6

  # Create instance: pipeline_7, and set properties
  set block_name pipeline
  set block_cell_name pipeline_7
  if { [catch {set pipeline_7 [create_bd_cell -type module -reference $block_name $block_cell_name] } errmsg] } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2095 -severity "ERROR" "Unable to add referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   } elseif { $pipeline_7 eq "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2096 -severity "ERROR" "Unable to referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   }
    set_property -dict [ list \
   CONFIG.width {3} \
 ] $pipeline_7

  # Create instance: pipeline_8, and set properties
  set block_name pipeline
  set block_cell_name pipeline_8
  if { [catch {set pipeline_8 [create_bd_cell -type module -reference $block_name $block_cell_name] } errmsg] } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2095 -severity "ERROR" "Unable to add referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   } elseif { $pipeline_8 eq "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2096 -severity "ERROR" "Unable to referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   }
    set_property -dict [ list \
   CONFIG.width {5} \
 ] $pipeline_8

  # Create instance: pipeline_9, and set properties
  set block_name pipeline
  set block_cell_name pipeline_9
  if { [catch {set pipeline_9 [create_bd_cell -type module -reference $block_name $block_cell_name] } errmsg] } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2095 -severity "ERROR" "Unable to add referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   } elseif { $pipeline_9 eq "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2096 -severity "ERROR" "Unable to referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   }
    set_property -dict [ list \
   CONFIG.width {1} \
 ] $pipeline_9

  # Create instance: pipeline_10, and set properties
  set block_name pipeline
  set block_cell_name pipeline_10
  if { [catch {set pipeline_10 [create_bd_cell -type module -reference $block_name $block_cell_name] } errmsg] } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2095 -severity "ERROR" "Unable to add referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   } elseif { $pipeline_10 eq "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2096 -severity "ERROR" "Unable to referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   }
    set_property -dict [ list \
   CONFIG.width {1} \
 ] $pipeline_10

  # Create instance: pipeline_11, and set properties
  set block_name pipeline
  set block_cell_name pipeline_11
  if { [catch {set pipeline_11 [create_bd_cell -type module -reference $block_name $block_cell_name] } errmsg] } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2095 -severity "ERROR" "Unable to add referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   } elseif { $pipeline_11 eq "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2096 -severity "ERROR" "Unable to referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   }
    set_property -dict [ list \
   CONFIG.width {1} \
 ] $pipeline_11

  # Create instance: pipeline_12, and set properties
  set block_name pipeline
  set block_cell_name pipeline_12
  if { [catch {set pipeline_12 [create_bd_cell -type module -reference $block_name $block_cell_name] } errmsg] } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2095 -severity "ERROR" "Unable to add referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   } elseif { $pipeline_12 eq "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2096 -severity "ERROR" "Unable to referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   }
    set_property -dict [ list \
   CONFIG.width {1} \
 ] $pipeline_12

  # Create instance: pipeline_13, and set properties
  set block_name pipeline
  set block_cell_name pipeline_13
  if { [catch {set pipeline_13 [create_bd_cell -type module -reference $block_name $block_cell_name] } errmsg] } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2095 -severity "ERROR" "Unable to add referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   } elseif { $pipeline_13 eq "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2096 -severity "ERROR" "Unable to referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   }
    set_property -dict [ list \
   CONFIG.width {5} \
 ] $pipeline_13

  # Create instance: xlconstant_0, and set properties
  set xlconstant_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlconstant:1.1 xlconstant_0 ]

  # Create port connections
  connect_bd_net -net D10_1 [get_bd_pins D10] [get_bd_pins pipeline_10/D]
  connect_bd_net -net D11_1 [get_bd_pins D11] [get_bd_pins pipeline_11/D]
  connect_bd_net -net D12_1 [get_bd_pins D12] [get_bd_pins pipeline_12/D]
  connect_bd_net -net D13_1 [get_bd_pins D13] [get_bd_pins pipeline_13/D]
  connect_bd_net -net D4_1 [get_bd_pins D4] [get_bd_pins pipeline_4/D]
  connect_bd_net -net D5_1 [get_bd_pins D5] [get_bd_pins pipeline_5/D]
  connect_bd_net -net D6_1 [get_bd_pins D6] [get_bd_pins pipeline_6/D]
  connect_bd_net -net D7_1 [get_bd_pins D7] [get_bd_pins pipeline_7/D]
  connect_bd_net -net D8_1 [get_bd_pins D8] [get_bd_pins pipeline_8/D]
  connect_bd_net -net D9_1 [get_bd_pins D9] [get_bd_pins pipeline_9/D]
  connect_bd_net -net RegFile_0_regRdData1 [get_bd_pins D] [get_bd_pins pipeline_0/D]
  connect_bd_net -net RegFile_0_regRdData2 [get_bd_pins D3] [get_bd_pins pipeline_1/D]
  connect_bd_net -net i_clk_0_1 [get_bd_pins in_clock] [get_bd_pins pipeline_0/clk] [get_bd_pins pipeline_1/clk] [get_bd_pins pipeline_10/clk] [get_bd_pins pipeline_11/clk] [get_bd_pins pipeline_12/clk] [get_bd_pins pipeline_13/clk] [get_bd_pins pipeline_2/clk] [get_bd_pins pipeline_3/clk] [get_bd_pins pipeline_4/clk] [get_bd_pins pipeline_5/clk] [get_bd_pins pipeline_6/clk] [get_bd_pins pipeline_7/clk] [get_bd_pins pipeline_8/clk] [get_bd_pins pipeline_9/clk]
  connect_bd_net -net pipeline_0_Q1 [get_bd_pins Q] [get_bd_pins pipeline_0/Q]
  connect_bd_net -net pipeline_10_Q [get_bd_pins Q10] [get_bd_pins pipeline_10/Q]
  connect_bd_net -net pipeline_11_Q [get_bd_pins Q11] [get_bd_pins pipeline_11/Q]
  connect_bd_net -net pipeline_12_Q [get_bd_pins Q12] [get_bd_pins pipeline_12/Q]
  connect_bd_net -net pipeline_13_Q [get_bd_pins Q13] [get_bd_pins pipeline_13/Q]
  connect_bd_net -net pipeline_1_Q [get_bd_pins D2] [get_bd_pins pipeline_3/D]
  connect_bd_net -net pipeline_1_Q1 [get_bd_pins Q3] [get_bd_pins pipeline_1/Q]
  connect_bd_net -net pipeline_2_Q [get_bd_pins Q1] [get_bd_pins pipeline_2/Q]
  connect_bd_net -net pipeline_3_Q [get_bd_pins Q2] [get_bd_pins pipeline_3/Q]
  connect_bd_net -net pipeline_4_Q [get_bd_pins Q4] [get_bd_pins pipeline_4/Q]
  connect_bd_net -net pipeline_5_Q [get_bd_pins Q5] [get_bd_pins pipeline_5/Q]
  connect_bd_net -net pipeline_6_Q [get_bd_pins Q6] [get_bd_pins pipeline_6/Q]
  connect_bd_net -net pipeline_7_Q [get_bd_pins Q7] [get_bd_pins pipeline_7/Q]
  connect_bd_net -net pipeline_8_Q [get_bd_pins Q8] [get_bd_pins pipeline_8/Q]
  connect_bd_net -net pipeline_9_Q [get_bd_pins Q9] [get_bd_pins pipeline_9/Q]
  connect_bd_net -net signExtern_0_outData [get_bd_pins D1] [get_bd_pins pipeline_2/D]
  connect_bd_net -net xlconstant_0_dout [get_bd_pins pipeline_0/En] [get_bd_pins pipeline_1/En] [get_bd_pins pipeline_10/En] [get_bd_pins pipeline_11/En] [get_bd_pins pipeline_12/En] [get_bd_pins pipeline_13/En] [get_bd_pins pipeline_2/En] [get_bd_pins pipeline_3/En] [get_bd_pins pipeline_4/En] [get_bd_pins pipeline_5/En] [get_bd_pins pipeline_6/En] [get_bd_pins pipeline_7/En] [get_bd_pins pipeline_8/En] [get_bd_pins pipeline_9/En] [get_bd_pins xlconstant_0/dout]

  # Restore current instance
  current_bd_instance $oldCurInst
}

# Hierarchical cell: EX_MEM
proc create_hier_cell_EX_MEM { parentCell nameHier } {

  variable script_folder

  if { $parentCell eq "" || $nameHier eq "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2092 -severity "ERROR" "create_hier_cell_EX_MEM() - Empty argument(s)!"}
     return
  }

  # Get object for parentCell
  set parentObj [get_bd_cells $parentCell]
  if { $parentObj == "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2090 -severity "ERROR" "Unable to find parent cell <$parentCell>!"}
     return
  }

  # Make sure parentObj is hier blk
  set parentType [get_property TYPE $parentObj]
  if { $parentType ne "hier" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2091 -severity "ERROR" "Parent <$parentObj> has TYPE = <$parentType>. Expected to be <hier>."}
     return
  }

  # Save current instance; Restore later
  set oldCurInst [current_bd_instance .]

  # Set parent object as current
  current_bd_instance $parentObj

  # Create cell and set as current instance
  set hier_obj [create_bd_cell -type hier $nameHier]
  current_bd_instance $hier_obj

  # Create interface pins

  # Create pins
  create_bd_pin -dir I -from 31 -to 0 D
  create_bd_pin -dir I -from 31 -to 0 D1
  create_bd_pin -dir I -from 4 -to 0 D2
  create_bd_pin -dir I -from 0 -to 0 D3
  create_bd_pin -dir I -from 0 -to 0 D4
  create_bd_pin -dir I -from 0 -to 0 D5
  create_bd_pin -dir O -from 31 -to 0 Q
  create_bd_pin -dir O -from 31 -to 0 Q1
  create_bd_pin -dir O -from 4 -to 0 Q2
  create_bd_pin -dir O -from 0 -to 0 Q3
  create_bd_pin -dir O -from 0 -to 0 Q4
  create_bd_pin -dir O -from 0 -to 0 Q5
  create_bd_pin -dir I -type clk in_clock

  # Create instance: pipeline_0, and set properties
  set block_name pipeline
  set block_cell_name pipeline_0
  if { [catch {set pipeline_0 [create_bd_cell -type module -reference $block_name $block_cell_name] } errmsg] } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2095 -severity "ERROR" "Unable to add referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   } elseif { $pipeline_0 eq "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2096 -severity "ERROR" "Unable to referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   }
  
  # Create instance: pipeline_1, and set properties
  set block_name pipeline
  set block_cell_name pipeline_1
  if { [catch {set pipeline_1 [create_bd_cell -type module -reference $block_name $block_cell_name] } errmsg] } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2095 -severity "ERROR" "Unable to add referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   } elseif { $pipeline_1 eq "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2096 -severity "ERROR" "Unable to referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   }
  
  # Create instance: pipeline_2, and set properties
  set block_name pipeline
  set block_cell_name pipeline_2
  if { [catch {set pipeline_2 [create_bd_cell -type module -reference $block_name $block_cell_name] } errmsg] } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2095 -severity "ERROR" "Unable to add referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   } elseif { $pipeline_2 eq "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2096 -severity "ERROR" "Unable to referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   }
    set_property -dict [ list \
   CONFIG.width {5} \
 ] $pipeline_2

  # Create instance: pipeline_3, and set properties
  set block_name pipeline
  set block_cell_name pipeline_3
  if { [catch {set pipeline_3 [create_bd_cell -type module -reference $block_name $block_cell_name] } errmsg] } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2095 -severity "ERROR" "Unable to add referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   } elseif { $pipeline_3 eq "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2096 -severity "ERROR" "Unable to referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   }
    set_property -dict [ list \
   CONFIG.width {1} \
 ] $pipeline_3

  # Create instance: pipeline_4, and set properties
  set block_name pipeline
  set block_cell_name pipeline_4
  if { [catch {set pipeline_4 [create_bd_cell -type module -reference $block_name $block_cell_name] } errmsg] } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2095 -severity "ERROR" "Unable to add referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   } elseif { $pipeline_4 eq "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2096 -severity "ERROR" "Unable to referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   }
    set_property -dict [ list \
   CONFIG.width {1} \
 ] $pipeline_4

  # Create instance: pipeline_5, and set properties
  set block_name pipeline
  set block_cell_name pipeline_5
  if { [catch {set pipeline_5 [create_bd_cell -type module -reference $block_name $block_cell_name] } errmsg] } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2095 -severity "ERROR" "Unable to add referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   } elseif { $pipeline_5 eq "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2096 -severity "ERROR" "Unable to referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   }
    set_property -dict [ list \
   CONFIG.width {1} \
 ] $pipeline_5

  # Create instance: xlconstant_0, and set properties
  set xlconstant_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlconstant:1.1 xlconstant_0 ]

  # Create port connections
  connect_bd_net -net D2_1 [get_bd_pins D2] [get_bd_pins pipeline_2/D]
  connect_bd_net -net D3_1 [get_bd_pins D3] [get_bd_pins pipeline_3/D]
  connect_bd_net -net D4_1 [get_bd_pins D4] [get_bd_pins pipeline_4/D]
  connect_bd_net -net D5_1 [get_bd_pins D5] [get_bd_pins pipeline_5/D]
  connect_bd_net -net alu_0_zeroFlag [get_bd_pins D] [get_bd_pins pipeline_0/D]
  connect_bd_net -net i_clk_0_1 [get_bd_pins in_clock] [get_bd_pins pipeline_0/clk] [get_bd_pins pipeline_1/clk] [get_bd_pins pipeline_2/clk] [get_bd_pins pipeline_3/clk] [get_bd_pins pipeline_4/clk] [get_bd_pins pipeline_5/clk]
  connect_bd_net -net pipeline_0_Q2 [get_bd_pins Q] [get_bd_pins pipeline_0/Q]
  connect_bd_net -net pipeline_1_Q1 [get_bd_pins D1] [get_bd_pins pipeline_1/D]
  connect_bd_net -net pipeline_1_Q2 [get_bd_pins Q1] [get_bd_pins pipeline_1/Q]
  connect_bd_net -net pipeline_2_Q [get_bd_pins Q2] [get_bd_pins pipeline_2/Q]
  connect_bd_net -net pipeline_3_Q [get_bd_pins Q3] [get_bd_pins pipeline_3/Q]
  connect_bd_net -net pipeline_4_Q [get_bd_pins Q4] [get_bd_pins pipeline_4/Q]
  connect_bd_net -net pipeline_5_Q [get_bd_pins Q5] [get_bd_pins pipeline_5/Q]
  connect_bd_net -net xlconstant_0_dout [get_bd_pins pipeline_0/En] [get_bd_pins pipeline_1/En] [get_bd_pins pipeline_2/En] [get_bd_pins pipeline_3/En] [get_bd_pins pipeline_4/En] [get_bd_pins pipeline_5/En] [get_bd_pins xlconstant_0/dout]

  # Restore current instance
  current_bd_instance $oldCurInst
}

# Hierarchical cell: DataHazardUnit
proc create_hier_cell_DataHazardUnit { parentCell nameHier } {

  variable script_folder

  if { $parentCell eq "" || $nameHier eq "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2092 -severity "ERROR" "create_hier_cell_DataHazardUnit() - Empty argument(s)!"}
     return
  }

  # Get object for parentCell
  set parentObj [get_bd_cells $parentCell]
  if { $parentObj == "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2090 -severity "ERROR" "Unable to find parent cell <$parentCell>!"}
     return
  }

  # Make sure parentObj is hier blk
  set parentType [get_property TYPE $parentObj]
  if { $parentType ne "hier" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2091 -severity "ERROR" "Parent <$parentObj> has TYPE = <$parentType>. Expected to be <hier>."}
     return
  }

  # Save current instance; Restore later
  set oldCurInst [current_bd_instance .]

  # Set parent object as current
  current_bd_instance $parentObj

  # Create cell and set as current instance
  set hier_obj [create_bd_cell -type hier $nameHier]
  current_bd_instance $hier_obj

  # Create interface pins

  # Create pins
  create_bd_pin -dir I EX_MEM_RegWrite
  create_bd_pin -dir I -from 4 -to 0 EX_MEM_RegisterRd
  create_bd_pin -dir I EX_MEM_memToReg
  create_bd_pin -dir I -from 4 -to 0 ID_EX_RegisterRs
  create_bd_pin -dir I -from 4 -to 0 ID_EX_RegisterRt
  create_bd_pin -dir I MEM_WB_RegWrite
  create_bd_pin -dir I -from 4 -to 0 MEM_WB_RegisterRd
  create_bd_pin -dir I -from 31 -to 0 in0
  create_bd_pin -dir I -from 31 -to 0 in1
  create_bd_pin -dir I -from 31 -to 0 in2
  create_bd_pin -dir I -from 31 -to 0 in3
  create_bd_pin -dir O -from 31 -to 0 muxOut
  create_bd_pin -dir O -from 31 -to 0 muxOut1
  create_bd_pin -dir O -from 31 -to 0 regData1
  create_bd_pin -dir O -from 31 -to 0 regData2
  create_bd_pin -dir I -from 4 -to 0 regRdAddr1
  create_bd_pin -dir I -from 4 -to 0 regRdAddr2
  create_bd_pin -dir I -from 31 -to 0 regRdData1
  create_bd_pin -dir I -from 31 -to 0 regRdData2
  create_bd_pin -dir I -from 31 -to 0 regWrData

  # Create instance: FU_0, and set properties
  set block_name FU
  set block_cell_name FU_0
  if { [catch {set FU_0 [create_bd_cell -type module -reference $block_name $block_cell_name] } errmsg] } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2095 -severity "ERROR" "Unable to add referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   } elseif { $FU_0 eq "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2096 -severity "ERROR" "Unable to referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   }
  
  # Create instance: mux2_0, and set properties
  set block_name mux2
  set block_cell_name mux2_0
  if { [catch {set mux2_0 [create_bd_cell -type module -reference $block_name $block_cell_name] } errmsg] } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2095 -severity "ERROR" "Unable to add referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   } elseif { $mux2_0 eq "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2096 -severity "ERROR" "Unable to referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   }
  
  # Create instance: mux2_1, and set properties
  set block_name mux2
  set block_cell_name mux2_1
  if { [catch {set mux2_1 [create_bd_cell -type module -reference $block_name $block_cell_name] } errmsg] } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2095 -severity "ERROR" "Unable to add referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   } elseif { $mux2_1 eq "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2096 -severity "ERROR" "Unable to referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   }
  
  # Create instance: regFileFW_0, and set properties
  set block_name regFileFW
  set block_cell_name regFileFW_0
  if { [catch {set regFileFW_0 [create_bd_cell -type module -reference $block_name $block_cell_name] } errmsg] } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2095 -severity "ERROR" "Unable to add referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   } elseif { $regFileFW_0 eq "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2096 -severity "ERROR" "Unable to referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   }
  
  # Create port connections
  connect_bd_net -net EX_MEM_RegWrite_1 [get_bd_pins EX_MEM_RegWrite] [get_bd_pins FU_0/EX_MEM_RegWrite]
  connect_bd_net -net EX_MEM_RegisterRd_1 [get_bd_pins EX_MEM_RegisterRd] [get_bd_pins FU_0/EX_MEM_RegisterRd]
  connect_bd_net -net EX_MEM_memToReg_1 [get_bd_pins EX_MEM_memToReg] [get_bd_pins FU_0/EX_MEM_memToReg]
  connect_bd_net -net FU_0_ForwardA [get_bd_pins FU_0/ForwardA] [get_bd_pins mux2_0/ctrl]
  connect_bd_net -net FU_0_ForwardB [get_bd_pins FU_0/ForwardB] [get_bd_pins mux2_1/ctrl]
  connect_bd_net -net ID_EX_RegisterRs_1 [get_bd_pins ID_EX_RegisterRs] [get_bd_pins FU_0/ID_EX_RegisterRs]
  connect_bd_net -net ID_EX_RegisterRt_1 [get_bd_pins ID_EX_RegisterRt] [get_bd_pins FU_0/ID_EX_RegisterRt]
  connect_bd_net -net MEM_WB_RegWrite_1 [get_bd_pins MEM_WB_RegWrite] [get_bd_pins FU_0/MEM_WB_RegWrite] [get_bd_pins regFileFW_0/regWrEn]
  connect_bd_net -net MEM_WB_RegisterRd_1 [get_bd_pins MEM_WB_RegisterRd] [get_bd_pins FU_0/MEM_WB_RegisterRd] [get_bd_pins regFileFW_0/regWrAddr]
  connect_bd_net -net in0_1 [get_bd_pins in0] [get_bd_pins mux2_1/in0]
  connect_bd_net -net in1_1 [get_bd_pins in1] [get_bd_pins mux2_0/in1] [get_bd_pins mux2_1/in1]
  connect_bd_net -net in2_1 [get_bd_pins in2] [get_bd_pins mux2_0/in2] [get_bd_pins mux2_1/in2]
  connect_bd_net -net in3_1 [get_bd_pins in3] [get_bd_pins mux2_0/in0]
  connect_bd_net -net mux2_0_muxOut [get_bd_pins muxOut1] [get_bd_pins mux2_0/muxOut]
  connect_bd_net -net mux2_1_muxOut [get_bd_pins muxOut] [get_bd_pins mux2_1/muxOut]
  connect_bd_net -net regFileFW_0_regData1 [get_bd_pins regData1] [get_bd_pins regFileFW_0/regData1]
  connect_bd_net -net regFileFW_0_regData2 [get_bd_pins regData2] [get_bd_pins regFileFW_0/regData2]
  connect_bd_net -net regRdAddr1_1 [get_bd_pins regRdAddr1] [get_bd_pins regFileFW_0/regRdAddr1]
  connect_bd_net -net regRdAddr2_1 [get_bd_pins regRdAddr2] [get_bd_pins regFileFW_0/regRdAddr2]
  connect_bd_net -net regRdData1_1 [get_bd_pins regRdData1] [get_bd_pins regFileFW_0/regRdData1]
  connect_bd_net -net regRdData2_1 [get_bd_pins regRdData2] [get_bd_pins regFileFW_0/regRdData2]
  connect_bd_net -net regWrData_1 [get_bd_pins regWrData] [get_bd_pins mux2_0/in3] [get_bd_pins mux2_1/in3] [get_bd_pins regFileFW_0/regWrData]

  # Restore current instance
  current_bd_instance $oldCurInst
}


# Procedure to create entire design; Provide argument to make
# procedure reusable. If parentCell is "", will use root.
proc create_root_design { parentCell } {

  variable script_folder
  variable design_name

  if { $parentCell eq "" } {
     set parentCell [get_bd_cells /]
  }

  # Get object for parentCell
  set parentObj [get_bd_cells $parentCell]
  if { $parentObj == "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2090 -severity "ERROR" "Unable to find parent cell <$parentCell>!"}
     return
  }

  # Make sure parentObj is hier blk
  set parentType [get_property TYPE $parentObj]
  if { $parentType ne "hier" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2091 -severity "ERROR" "Parent <$parentObj> has TYPE = <$parentType>. Expected to be <hier>."}
     return
  }

  # Save current instance; Restore later
  set oldCurInst [current_bd_instance .]

  # Set parent object as current
  current_bd_instance $parentObj


  # Create interface ports

  # Create ports
  set in_clock [ create_bd_port -dir I -type clk in_clock ]

  # Create instance: DataHazardUnit
  create_hier_cell_DataHazardUnit [current_bd_instance .] DataHazardUnit

  # Create instance: EX_MEM
  create_hier_cell_EX_MEM [current_bd_instance .] EX_MEM

  # Create instance: ID_EX
  create_hier_cell_ID_EX [current_bd_instance .] ID_EX

  # Create instance: IF_ID
  create_hier_cell_IF_ID [current_bd_instance .] IF_ID

  # Create instance: Jump_Block
  create_hier_cell_Jump_Block [current_bd_instance .] Jump_Block

  # Create instance: MEM_WB
  create_hier_cell_MEM_WB [current_bd_instance .] MEM_WB

  # Create instance: PCplus4Adder
  create_hier_cell_PCplus4Adder [current_bd_instance .] PCplus4Adder

  # Create instance: RegFile_0, and set properties
  set block_name RegFile
  set block_cell_name RegFile_0
  if { [catch {set RegFile_0 [create_bd_cell -type module -reference $block_name $block_cell_name] } errmsg] } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2095 -severity "ERROR" "Unable to add referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   } elseif { $RegFile_0 eq "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2096 -severity "ERROR" "Unable to referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   }
  
  # Create instance: adder_1, and set properties
  set block_name adder
  set block_cell_name adder_1
  if { [catch {set adder_1 [create_bd_cell -type module -reference $block_name $block_cell_name] } errmsg] } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2095 -severity "ERROR" "Unable to add referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   } elseif { $adder_1 eq "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2096 -severity "ERROR" "Unable to referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   }
    set_property -dict [ list \
   CONFIG.width {32} \
 ] $adder_1

  # Create instance: alu_0, and set properties
  set block_name alu
  set block_cell_name alu_0
  if { [catch {set alu_0 [create_bd_cell -type module -reference $block_name $block_cell_name] } errmsg] } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2095 -severity "ERROR" "Unable to add referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   } elseif { $alu_0 eq "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2096 -severity "ERROR" "Unable to referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   }
  
  # Create instance: andGate_0, and set properties
  set block_name andGate
  set block_cell_name andGate_0
  if { [catch {set andGate_0 [create_bd_cell -type module -reference $block_name $block_cell_name] } errmsg] } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2095 -severity "ERROR" "Unable to add referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   } elseif { $andGate_0 eq "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2096 -severity "ERROR" "Unable to referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   }
  
  # Create instance: controlLogic_0, and set properties
  set block_name controlLogic
  set block_cell_name controlLogic_0
  if { [catch {set controlLogic_0 [create_bd_cell -type module -reference $block_name $block_cell_name] } errmsg] } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2095 -severity "ERROR" "Unable to add referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   } elseif { $controlLogic_0 eq "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2096 -severity "ERROR" "Unable to referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   }
  
  # Create instance: ctrlHDU_0, and set properties
  set block_name ctrlHDU
  set block_cell_name ctrlHDU_0
  if { [catch {set ctrlHDU_0 [create_bd_cell -type module -reference $block_name $block_cell_name] } errmsg] } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2095 -severity "ERROR" "Unable to add referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   } elseif { $ctrlHDU_0 eq "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2096 -severity "ERROR" "Unable to referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   }
  
  # Create instance: dataMemory_0, and set properties
  set block_name dataMemory
  set block_cell_name dataMemory_0
  if { [catch {set dataMemory_0 [create_bd_cell -type module -reference $block_name $block_cell_name] } errmsg] } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2095 -severity "ERROR" "Unable to add referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   } elseif { $dataMemory_0 eq "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2096 -severity "ERROR" "Unable to referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   }
  
  # Create instance: instructionMemory_0, and set properties
  set block_name instructionMemory
  set block_cell_name instructionMemory_0
  if { [catch {set instructionMemory_0 [create_bd_cell -type module -reference $block_name $block_cell_name] } errmsg] } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2095 -severity "ERROR" "Unable to add referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   } elseif { $instructionMemory_0 eq "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2096 -severity "ERROR" "Unable to referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   }
  
  # Create instance: instructionSlice
  create_hier_cell_instructionSlice [current_bd_instance .] instructionSlice

  # Create instance: mux_0, and set properties
  set block_name mux
  set block_cell_name mux_0
  if { [catch {set mux_0 [create_bd_cell -type module -reference $block_name $block_cell_name] } errmsg] } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2095 -severity "ERROR" "Unable to add referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   } elseif { $mux_0 eq "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2096 -severity "ERROR" "Unable to referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   }
    set_property -dict [ list \
   CONFIG.width {5} \
 ] $mux_0

  # Create instance: mux_1, and set properties
  set block_name mux
  set block_cell_name mux_1
  if { [catch {set mux_1 [create_bd_cell -type module -reference $block_name $block_cell_name] } errmsg] } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2095 -severity "ERROR" "Unable to add referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   } elseif { $mux_1 eq "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2096 -severity "ERROR" "Unable to referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   }
    set_property -dict [ list \
   CONFIG.width {32} \
 ] $mux_1

  # Create instance: mux_2, and set properties
  set block_name mux
  set block_cell_name mux_2
  if { [catch {set mux_2 [create_bd_cell -type module -reference $block_name $block_cell_name] } errmsg] } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2095 -severity "ERROR" "Unable to add referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   } elseif { $mux_2 eq "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2096 -severity "ERROR" "Unable to referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   }
    set_property -dict [ list \
   CONFIG.width {32} \
 ] $mux_2

  # Create instance: mux_3, and set properties
  set block_name mux
  set block_cell_name mux_3
  if { [catch {set mux_3 [create_bd_cell -type module -reference $block_name $block_cell_name] } errmsg] } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2095 -severity "ERROR" "Unable to add referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   } elseif { $mux_3 eq "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2096 -severity "ERROR" "Unable to referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   }
    set_property -dict [ list \
   CONFIG.width {32} \
 ] $mux_3

  # Create instance: mux_4, and set properties
  set block_name mux
  set block_cell_name mux_4
  if { [catch {set mux_4 [create_bd_cell -type module -reference $block_name $block_cell_name] } errmsg] } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2095 -severity "ERROR" "Unable to add referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   } elseif { $mux_4 eq "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2096 -severity "ERROR" "Unable to referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   }
    set_property -dict [ list \
   CONFIG.width {32} \
 ] $mux_4

  # Create instance: programCounter_0, and set properties
  set block_name programCounter
  set block_cell_name programCounter_0
  if { [catch {set programCounter_0 [create_bd_cell -type module -reference $block_name $block_cell_name] } errmsg] } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2095 -severity "ERROR" "Unable to add referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   } elseif { $programCounter_0 eq "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2096 -severity "ERROR" "Unable to referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   }
  
  # Create instance: shiftLeft_0, and set properties
  set block_name shiftLeft
  set block_cell_name shiftLeft_0
  if { [catch {set shiftLeft_0 [create_bd_cell -type module -reference $block_name $block_cell_name] } errmsg] } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2095 -severity "ERROR" "Unable to add referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   } elseif { $shiftLeft_0 eq "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2096 -severity "ERROR" "Unable to referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   }
  
  # Create instance: slice_and_Extend
  create_hier_cell_slice_and_Extend [current_bd_instance .] slice_and_Extend

  # Create port connections
  connect_bd_net -net D10_1 [get_bd_pins ID_EX/D10] [get_bd_pins IF_ID/Q8]
  connect_bd_net -net D11_1 [get_bd_pins IF_ID/Q9] [get_bd_pins ctrlHDU_0/IF_ID_PCSrc]
  connect_bd_net -net D3_1 [get_bd_pins DataHazardUnit/regData2] [get_bd_pins ID_EX/D3]
  connect_bd_net -net D5_1 [get_bd_pins ID_EX/D5] [get_bd_pins IF_ID/Q3]
  connect_bd_net -net D6_1 [get_bd_pins ID_EX/D6] [get_bd_pins IF_ID/Q4]
  connect_bd_net -net D7_1 [get_bd_pins ID_EX/D7] [get_bd_pins IF_ID/Q6]
  connect_bd_net -net D9_1 [get_bd_pins ID_EX/D9] [get_bd_pins IF_ID/Q7]
  connect_bd_net -net D_1 [get_bd_pins DataHazardUnit/regData1] [get_bd_pins ID_EX/D]
  connect_bd_net -net DataHazardUnit_muxOut1 [get_bd_pins DataHazardUnit/muxOut1] [get_bd_pins alu_0/op1]
  connect_bd_net -net EX_MEM_Q2 [get_bd_pins DataHazardUnit/EX_MEM_RegisterRd] [get_bd_pins EX_MEM/Q2] [get_bd_pins MEM_WB/D4]
  connect_bd_net -net EX_MEM_Q3 [get_bd_pins DataHazardUnit/EX_MEM_RegWrite] [get_bd_pins EX_MEM/Q3] [get_bd_pins MEM_WB/D2]
  connect_bd_net -net EX_MEM_Q4 [get_bd_pins EX_MEM/Q4] [get_bd_pins dataMemory_0/memWrite]
  connect_bd_net -net EX_MEM_Q5 [get_bd_pins DataHazardUnit/EX_MEM_memToReg] [get_bd_pins EX_MEM/Q5] [get_bd_pins MEM_WB/D3]
  connect_bd_net -net ID_EX_Q [get_bd_pins DataHazardUnit/in3] [get_bd_pins ID_EX/Q]
  connect_bd_net -net ID_EX_Q3 [get_bd_pins DataHazardUnit/in0] [get_bd_pins ID_EX/Q3]
  connect_bd_net -net ID_EX_Q4 [get_bd_pins DataHazardUnit/ID_EX_RegisterRt] [get_bd_pins ID_EX/Q4] [get_bd_pins mux_0/in0]
  connect_bd_net -net ID_EX_Q5 [get_bd_pins EX_MEM/D3] [get_bd_pins ID_EX/Q5]
  connect_bd_net -net ID_EX_Q6 [get_bd_pins ID_EX/Q6] [get_bd_pins mux_1/ctrl]
  connect_bd_net -net ID_EX_Q7 [get_bd_pins ID_EX/Q7] [get_bd_pins alu_0/aluOp]
  connect_bd_net -net ID_EX_Q8 [get_bd_pins ID_EX/Q8] [get_bd_pins mux_0/in1]
  connect_bd_net -net ID_EX_Q9 [get_bd_pins EX_MEM/D4] [get_bd_pins ID_EX/Q9]
  connect_bd_net -net ID_EX_Q10 [get_bd_pins EX_MEM/D5] [get_bd_pins ID_EX/Q10]
  connect_bd_net -net ID_EX_Q11 [get_bd_pins ID_EX/Q11] [get_bd_pins andGate_0/pcSrc]
  connect_bd_net -net ID_EX_Q12 [get_bd_pins ID_EX/Q12] [get_bd_pins mux_0/ctrl]
  connect_bd_net -net ID_EX_Q13 [get_bd_pins DataHazardUnit/ID_EX_RegisterRs] [get_bd_pins ID_EX/Q13]
  connect_bd_net -net IF_ID_Q2 [get_bd_pins ID_EX/D12] [get_bd_pins IF_ID/Q2]
  connect_bd_net -net Jump_Block_address_jump [get_bd_pins Jump_Block/address_jump] [get_bd_pins mux_3/in1]
  connect_bd_net -net MEM_WB_Q2 [get_bd_pins DataHazardUnit/MEM_WB_RegWrite] [get_bd_pins MEM_WB/Q2] [get_bd_pins RegFile_0/regWrEn]
  connect_bd_net -net MEM_WB_Q3 [get_bd_pins MEM_WB/Q3] [get_bd_pins mux_2/ctrl]
  connect_bd_net -net MEM_WB_Q4 [get_bd_pins DataHazardUnit/MEM_WB_RegisterRd] [get_bd_pins MEM_WB/Q4] [get_bd_pins RegFile_0/regWrAddr]
  connect_bd_net -net RegFile_0_regRdData1 [get_bd_pins DataHazardUnit/regRdData1] [get_bd_pins RegFile_0/regRdData1]
  connect_bd_net -net RegFile_0_regRdData2 [get_bd_pins DataHazardUnit/regRdData2] [get_bd_pins RegFile_0/regRdData2]
  connect_bd_net -net adder_0_adderOut [get_bd_pins IF_ID/D] [get_bd_pins Jump_Block/Din1] [get_bd_pins PCplus4Adder/adderOut] [get_bd_pins mux_3/in0]
  connect_bd_net -net adder_1_adderOut [get_bd_pins adder_1/adderOut] [get_bd_pins mux_4/in1]
  connect_bd_net -net alu_0_zeroFlag [get_bd_pins EX_MEM/D] [get_bd_pins alu_0/aluOut]
  connect_bd_net -net alu_0_zeroFlag1 [get_bd_pins alu_0/zeroFlag] [get_bd_pins andGate_0/ZF]
  connect_bd_net -net andGate_0_branchSignal [get_bd_pins andGate_0/branchSignal] [get_bd_pins ctrlHDU_0/branch] [get_bd_pins mux_4/ctrl]
  connect_bd_net -net controlLogic_0_aluOp [get_bd_pins IF_ID/D5] [get_bd_pins controlLogic_0/aluOp]
  connect_bd_net -net controlLogic_0_aluSrc [get_bd_pins IF_ID/D3] [get_bd_pins controlLogic_0/aluSrc]
  connect_bd_net -net controlLogic_0_jmpdetect [get_bd_pins controlLogic_0/jmpdetect] [get_bd_pins mux_3/ctrl]
  connect_bd_net -net controlLogic_0_memToReg [get_bd_pins IF_ID/D7] [get_bd_pins controlLogic_0/memToReg]
  connect_bd_net -net controlLogic_0_memWrite [get_bd_pins IF_ID/D6] [get_bd_pins controlLogic_0/memWrite]
  connect_bd_net -net controlLogic_0_pcSrc [get_bd_pins IF_ID/D8] [get_bd_pins controlLogic_0/pcSrc]
  connect_bd_net -net controlLogic_0_regDst [get_bd_pins IF_ID/D1] [get_bd_pins controlLogic_0/regDst]
  connect_bd_net -net controlLogic_0_regWrite [get_bd_pins IF_ID/D2] [get_bd_pins controlLogic_0/regWrite]
  connect_bd_net -net ctrlHDU_0_IF_ID_Write [get_bd_pins IF_ID/En] [get_bd_pins ctrlHDU_0/IF_ID_Write]
  connect_bd_net -net ctrlHDU_0_PCSrcOut [get_bd_pins ID_EX/D11] [get_bd_pins ctrlHDU_0/PCSrcOut]
  connect_bd_net -net ctrlHDU_0_PCWrite [get_bd_pins ctrlHDU_0/PCWrite] [get_bd_pins programCounter_0/PCEn]
  connect_bd_net -net dataMemory_0_readData [get_bd_pins DataHazardUnit/in2] [get_bd_pins MEM_WB/D1] [get_bd_pins dataMemory_0/readData]
  connect_bd_net -net i_clk_0_1 [get_bd_ports in_clock] [get_bd_pins EX_MEM/in_clock] [get_bd_pins ID_EX/in_clock] [get_bd_pins IF_ID/in_clock] [get_bd_pins MEM_WB/in_clock] [get_bd_pins RegFile_0/i_clk] [get_bd_pins ctrlHDU_0/clk] [get_bd_pins dataMemory_0/i_clk] [get_bd_pins programCounter_0/i_clk]
  connect_bd_net -net instructionMemory_0_instruction [get_bd_pins IF_ID/instruction] [get_bd_pins Jump_Block/Din] [get_bd_pins controlLogic_0/instruction] [get_bd_pins instructionMemory_0/instruction]
  connect_bd_net -net instructionSlice_Dout2 [get_bd_pins ID_EX/D8] [get_bd_pins instructionSlice/Dout2]
  connect_bd_net -net mux_0_muxOut [get_bd_pins EX_MEM/D2] [get_bd_pins mux_0/muxOut]
  connect_bd_net -net mux_1_muxOut [get_bd_pins alu_0/op2] [get_bd_pins mux_1/muxOut]
  connect_bd_net -net mux_2_muxOut [get_bd_pins DataHazardUnit/regWrData] [get_bd_pins RegFile_0/regWrData] [get_bd_pins mux_2/muxOut]
  connect_bd_net -net mux_3_muxOut [get_bd_pins mux_3/muxOut] [get_bd_pins mux_4/in0]
  connect_bd_net -net mux_4_muxOut [get_bd_pins mux_4/muxOut] [get_bd_pins programCounter_0/pcIn]
  connect_bd_net -net pipeline_0_Q [get_bd_pins IF_ID/Q] [get_bd_pins instructionSlice/Din] [get_bd_pins slice_and_Extend/Din]
  connect_bd_net -net pipeline_0_Q2 [get_bd_pins DataHazardUnit/in1] [get_bd_pins EX_MEM/Q] [get_bd_pins MEM_WB/D] [get_bd_pins dataMemory_0/readAddress] [get_bd_pins dataMemory_0/writeAddress]
  connect_bd_net -net pipeline_0_Q3 [get_bd_pins MEM_WB/Q] [get_bd_pins mux_2/in0]
  connect_bd_net -net pipeline_1_Q [get_bd_pins ID_EX/D2] [get_bd_pins IF_ID/Q1]
  connect_bd_net -net pipeline_1_Q1 [get_bd_pins DataHazardUnit/muxOut] [get_bd_pins EX_MEM/D1] [get_bd_pins mux_1/in0]
  connect_bd_net -net pipeline_1_Q2 [get_bd_pins EX_MEM/Q1] [get_bd_pins dataMemory_0/writeData]
  connect_bd_net -net pipeline_1_Q3 [get_bd_pins MEM_WB/Q1] [get_bd_pins mux_2/in1]
  connect_bd_net -net pipeline_2_Q [get_bd_pins ID_EX/Q1] [get_bd_pins mux_1/in1] [get_bd_pins shiftLeft_0/inData]
  connect_bd_net -net pipeline_3_Q [get_bd_pins ID_EX/Q2] [get_bd_pins adder_1/op2]
  connect_bd_net -net programCounter_0_pcOut [get_bd_pins PCplus4Adder/op1] [get_bd_pins instructionMemory_0/addressBus] [get_bd_pins programCounter_0/pcOut]
  connect_bd_net -net shiftLeft_0_outData [get_bd_pins adder_1/op1] [get_bd_pins shiftLeft_0/outData]
  connect_bd_net -net signExtern_0_outData [get_bd_pins ID_EX/D1] [get_bd_pins slice_and_Extend/outData]
  connect_bd_net -net xlslice_0_Dout [get_bd_pins DataHazardUnit/regRdAddr1] [get_bd_pins ID_EX/D13] [get_bd_pins RegFile_0/regRdAddr1] [get_bd_pins instructionSlice/Dout]
  connect_bd_net -net xlslice_1_Dout [get_bd_pins DataHazardUnit/regRdAddr2] [get_bd_pins ID_EX/D4] [get_bd_pins RegFile_0/regRdAddr2] [get_bd_pins instructionSlice/Dout1]

  # Create address segments


  # Restore current instance
  current_bd_instance $oldCurInst

  validate_bd_design
  save_bd_design
}
# End of create_root_design()


##################################################################
# MAIN FLOW
##################################################################

create_root_design ""


