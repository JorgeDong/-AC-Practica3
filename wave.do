onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -radix unsigned /MIPS_Processor_TB/reset
add wave -noupdate -radix unsigned /MIPS_Processor_TB/clk
add wave -noupdate -radix unsigned /MIPS_Processor_TB/PortOut
add wave -noupdate -radix unsigned /MIPS_Processor_TB/PortIn
add wave -noupdate -radix unsigned /MIPS_Processor_TB/ALUResultOut
add wave -noupdate -divider ALU
add wave -noupdate -radix hexadecimal /MIPS_Processor_TB/DUV/Arithmetic_Logic_Unit/ALUOperation
add wave -noupdate -radix hexadecimal /MIPS_Processor_TB/DUV/Arithmetic_Logic_Unit/A
add wave -noupdate -radix hexadecimal /MIPS_Processor_TB/DUV/Arithmetic_Logic_Unit/B
add wave -noupdate -radix hexadecimal /MIPS_Processor_TB/DUV/Arithmetic_Logic_Unit/shamt
add wave -noupdate -radix hexadecimal /MIPS_Processor_TB/DUV/Arithmetic_Logic_Unit/ALUResult
add wave -noupdate -divider IF_ID
add wave -noupdate -radix hexadecimal /MIPS_Processor_TB/DUV/IF_ID/clk
add wave -noupdate -radix hexadecimal /MIPS_Processor_TB/DUV/IF_ID/reset
add wave -noupdate -radix hexadecimal /MIPS_Processor_TB/DUV/IF_ID/enable
add wave -noupdate -radix hexadecimal /MIPS_Processor_TB/DUV/IF_ID/DataInput
add wave -noupdate -radix hexadecimal /MIPS_Processor_TB/DUV/IF_ID/DataOutput
add wave -noupdate -radix hexadecimal /MIPS_Processor_TB/DUV/Instruction_wire_ID
add wave -noupdate -radix hexadecimal /MIPS_Processor_TB/DUV/PC_4_wire_ID
add wave -noupdate -divider ID_EX
add wave -noupdate -radix hexadecimal /MIPS_Processor_TB/DUV/ID_EX/enable
add wave -noupdate -radix hexadecimal /MIPS_Processor_TB/DUV/ID_EX/reset
add wave -noupdate -radix hexadecimal /MIPS_Processor_TB/DUV/ID_EX/DataInput
add wave -noupdate -radix hexadecimal /MIPS_Processor_TB/DUV/ID_EX/DataOutput
add wave -noupdate -radix hexadecimal /MIPS_Processor_TB/DUV/EX_BranchNE_wire
add wave -noupdate -radix hexadecimal /MIPS_Processor_TB/DUV/EX_ALUOp_wire
add wave -noupdate -radix hexadecimal /MIPS_Processor_TB/DUV/EX_ALUSrc_wire
add wave -noupdate -radix hexadecimal /MIPS_Processor_TB/DUV/EX_BranchEQ_wire
add wave -noupdate -radix hexadecimal /MIPS_Processor_TB/DUV/EX_ControlJr_wire
add wave -noupdate -radix hexadecimal /MIPS_Processor_TB/DUV/EX_ControlJump_wire
add wave -noupdate -radix hexadecimal /MIPS_Processor_TB/DUV/EX_InmmediateExtend_wire
add wave -noupdate -radix hexadecimal /MIPS_Processor_TB/DUV/EX_Instruction_wire
add wave -noupdate -radix hexadecimal /MIPS_Processor_TB/DUV/EX_MEM_out_wire
add wave -noupdate -radix hexadecimal /MIPS_Processor_TB/DUV/EX_MemRead_wire
add wave -noupdate -radix hexadecimal /MIPS_Processor_TB/DUV/EX_MemWrite_wire
add wave -noupdate -radix hexadecimal /MIPS_Processor_TB/DUV/EX_MemtoReg_wire
add wave -noupdate -radix hexadecimal /MIPS_Processor_TB/DUV/EX_PC_4_wire
add wave -noupdate -radix hexadecimal /MIPS_Processor_TB/DUV/EX_ReadData1_wire
add wave -noupdate -radix hexadecimal /MIPS_Processor_TB/DUV/EX_ReadData2_wire
add wave -noupdate -radix hexadecimal /MIPS_Processor_TB/DUV/EX_RegDst_wire
add wave -noupdate -radix hexadecimal /MIPS_Processor_TB/DUV/EX_RegWrite_wire
add wave -noupdate -radix hexadecimal /MIPS_Processor_TB/DUV/EX_Shamt_wire
add wave -noupdate -divider EX_MEM
add wave -noupdate -radix hexadecimal /MIPS_Processor_TB/DUV/EX_MEM/enable
add wave -noupdate -radix hexadecimal /MIPS_Processor_TB/DUV/EX_MEM/reset
add wave -noupdate -radix hexadecimal /MIPS_Processor_TB/DUV/EX_MEM/DataInput
add wave -noupdate -radix hexadecimal /MIPS_Processor_TB/DUV/EX_MEM/DataOutput
add wave -noupdate -radix hexadecimal /MIPS_Processor_TB/DUV/MEM_ALUResult_wire
add wave -noupdate -radix hexadecimal /MIPS_Processor_TB/DUV/MEM_AdderBranchResult_wire
add wave -noupdate -radix hexadecimal /MIPS_Processor_TB/DUV/MEM_BranchEQ_wire
add wave -noupdate -radix hexadecimal /MIPS_Processor_TB/DUV/MEM_BranchNE_wire
add wave -noupdate -radix hexadecimal /MIPS_Processor_TB/DUV/MEM_ControlJump_wire
add wave -noupdate -radix hexadecimal /MIPS_Processor_TB/DUV/MEM_MemRead_wire
add wave -noupdate -radix hexadecimal /MIPS_Processor_TB/DUV/MEM_MemWrite_wire
add wave -noupdate -radix hexadecimal /MIPS_Processor_TB/DUV/MEM_MemtoReg_wire
add wave -noupdate -radix hexadecimal /MIPS_Processor_TB/DUV/MEM_PC_4_wire
add wave -noupdate -radix hexadecimal /MIPS_Processor_TB/DUV/MEM_ReadData2_wire
add wave -noupdate -radix hexadecimal /MIPS_Processor_TB/DUV/MEM_RegWrite_wire
add wave -noupdate -radix hexadecimal /MIPS_Processor_TB/DUV/MEM_WB_out_wire
add wave -noupdate -radix hexadecimal /MIPS_Processor_TB/DUV/MEM_WriteRegister_wire
add wave -noupdate -radix hexadecimal /MIPS_Processor_TB/DUV/MEM_Zero_wire
add wave -noupdate -divider MEM_WB
add wave -noupdate -radix hexadecimal /MIPS_Processor_TB/DUV/MEM_WB/clk
add wave -noupdate -radix hexadecimal /MIPS_Processor_TB/DUV/MEM_WB/enable
add wave -noupdate -radix hexadecimal /MIPS_Processor_TB/DUV/MEM_WB/reset
add wave -noupdate -radix hexadecimal /MIPS_Processor_TB/DUV/MEM_WB/DataInput
add wave -noupdate -radix hexadecimal /MIPS_Processor_TB/DUV/MEM_WB/DataOutput
add wave -noupdate -radix hexadecimal /MIPS_Processor_TB/DUV/WB_ALUResult_wire
add wave -noupdate -radix hexadecimal /MIPS_Processor_TB/DUV/WB_ControlJump_wire
add wave -noupdate -radix hexadecimal /MIPS_Processor_TB/DUV/WB_DataMemorytoMUX
add wave -noupdate -radix hexadecimal /MIPS_Processor_TB/DUV/WB_MemtoReg_wire
add wave -noupdate -radix hexadecimal /MIPS_Processor_TB/DUV/WB_PC_4_wire
add wave -noupdate -radix hexadecimal /MIPS_Processor_TB/DUV/WB_RegWrite_wire
add wave -noupdate -radix hexadecimal /MIPS_Processor_TB/DUV/WB_WriteRegister_wire
add wave -noupdate -divider Registros
add wave -noupdate -label T0 -radix hexadecimal /MIPS_Processor_TB/DUV/Register_File/Register_t0/DataOutput
add wave -noupdate -label T1 -radix hexadecimal /MIPS_Processor_TB/DUV/Register_File/Register_t1/DataOutput
add wave -noupdate -label T2 -radix hexadecimal /MIPS_Processor_TB/DUV/Register_File/Register_t2/DataOutput
add wave -noupdate -label T3 -radix hexadecimal /MIPS_Processor_TB/DUV/Register_File/Register_t3/DataOutput
add wave -noupdate -label T4 -radix hexadecimal /MIPS_Processor_TB/DUV/Register_File/Register_t4/DataOutput
add wave -noupdate -label S0 -radix hexadecimal /MIPS_Processor_TB/DUV/Register_File/Register_s0/DataOutput
add wave -noupdate -label S1 -radix hexadecimal /MIPS_Processor_TB/DUV/Register_File/Register_s1/DataOutput
add wave -noupdate -label S2 -radix hexadecimal /MIPS_Processor_TB/DUV/Register_File/Register_s2/DataOutput
add wave -noupdate -label S3 -radix hexadecimal /MIPS_Processor_TB/DUV/Register_File/Register_s3/DataOutput
add wave -noupdate -label S4 -radix hexadecimal /MIPS_Processor_TB/DUV/Register_File/Register_s4/DataOutput
add wave -noupdate -label S7 -radix hexadecimal /MIPS_Processor_TB/DUV/Register_File/Register_s7/DataOutput
add wave -noupdate -label SP -radix hexadecimal /MIPS_Processor_TB/DUV/Register_File/Register_sp/DataOutput
add wave -noupdate -divider ForwardUnit
add wave -noupdate -radix hexadecimal /MIPS_Processor_TB/DUV/FwdUnit/EX_MEM_Rd_Reg
add wave -noupdate -radix hexadecimal /MIPS_Processor_TB/DUV/FwdUnit/EX_MEM_RegWrite
add wave -noupdate -radix hexadecimal /MIPS_Processor_TB/DUV/FwdUnit/ForwardA
add wave -noupdate -radix hexadecimal /MIPS_Processor_TB/DUV/FwdUnit/ForwardB
add wave -noupdate -radix hexadecimal /MIPS_Processor_TB/DUV/FwdUnit/ID_EX_Rs_Reg
add wave -noupdate -radix hexadecimal /MIPS_Processor_TB/DUV/FwdUnit/ID_EX_Rt_Reg
add wave -noupdate -radix hexadecimal /MIPS_Processor_TB/DUV/FwdUnit/MEM_WB_Rd_Reg
add wave -noupdate -radix hexadecimal /MIPS_Processor_TB/DUV/FwdUnit/MEM_WB_RegWrite
add wave -noupdate -divider DataMemory
add wave -noupdate -radix hexadecimal /MIPS_Processor_TB/DUV/Memory/clk
add wave -noupdate -radix hexadecimal /MIPS_Processor_TB/DUV/Memory/WriteData
add wave -noupdate -radix hexadecimal /MIPS_Processor_TB/DUV/Memory/ReadDataAux
add wave -noupdate -radix hexadecimal /MIPS_Processor_TB/DUV/Memory/ReadData
add wave -noupdate -radix hexadecimal /MIPS_Processor_TB/DUV/Memory/Address
add wave -noupdate -radix hexadecimal /MIPS_Processor_TB/DUV/Memory/MemWrite
add wave -noupdate -radix hexadecimal /MIPS_Processor_TB/DUV/Memory/MemRead
add wave -noupdate -divider Row1
add wave -noupdate -radix decimal {/MIPS_Processor_TB/DUV/Memory/ram[7]}
add wave -noupdate -radix decimal {/MIPS_Processor_TB/DUV/Memory/ram[6]}
add wave -noupdate -radix decimal {/MIPS_Processor_TB/DUV/Memory/ram[5]}
add wave -noupdate -radix decimal {/MIPS_Processor_TB/DUV/Memory/ram[4]}
add wave -noupdate -radix decimal {/MIPS_Processor_TB/DUV/Memory/ram[3]}
add wave -noupdate -radix decimal {/MIPS_Processor_TB/DUV/Memory/ram[2]}
add wave -noupdate -radix decimal {/MIPS_Processor_TB/DUV/Memory/ram[1]}
add wave -noupdate -radix decimal {/MIPS_Processor_TB/DUV/Memory/ram[0]}
add wave -noupdate -divider Row2
add wave -noupdate -radix decimal {/MIPS_Processor_TB/DUV/Memory/ram[15]}
add wave -noupdate -radix decimal {/MIPS_Processor_TB/DUV/Memory/ram[14]}
add wave -noupdate -radix decimal {/MIPS_Processor_TB/DUV/Memory/ram[13]}
add wave -noupdate -radix decimal {/MIPS_Processor_TB/DUV/Memory/ram[12]}
add wave -noupdate -radix decimal {/MIPS_Processor_TB/DUV/Memory/ram[11]}
add wave -noupdate -radix decimal {/MIPS_Processor_TB/DUV/Memory/ram[10]}
add wave -noupdate -radix decimal {/MIPS_Processor_TB/DUV/Memory/ram[9]}
add wave -noupdate -radix decimal {/MIPS_Processor_TB/DUV/Memory/ram[8]}
add wave -noupdate -divider Row3
add wave -noupdate -radix decimal {/MIPS_Processor_TB/DUV/Memory/ram[23]}
add wave -noupdate -radix decimal {/MIPS_Processor_TB/DUV/Memory/ram[22]}
add wave -noupdate -radix decimal {/MIPS_Processor_TB/DUV/Memory/ram[21]}
add wave -noupdate -radix decimal {/MIPS_Processor_TB/DUV/Memory/ram[20]}
add wave -noupdate -radix decimal {/MIPS_Processor_TB/DUV/Memory/ram[19]}
add wave -noupdate -radix decimal {/MIPS_Processor_TB/DUV/Memory/ram[18]}
add wave -noupdate -radix decimal {/MIPS_Processor_TB/DUV/Memory/ram[17]}
add wave -noupdate -radix decimal {/MIPS_Processor_TB/DUV/Memory/ram[16]}
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {10 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 150
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 1
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ps
update
WaveRestoreZoom {0 ps} {40 ps}
