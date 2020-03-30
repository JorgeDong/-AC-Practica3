/******************************************************************
* Description
*	This is the top-level of a MIPS processor
* This processor is written Verilog-HDL. Also, it is synthesizable into hardware.
* Parameter MEMORY_DEPTH configures the program memory to allocate the program to
* be execute. If the size of the program changes, thus, MEMORY_DEPTH must change.
* This processor was made for computer organization class at ITESO.
******************************************************************/


module MIPS_Processor
#(
	parameter MEMORY_DEPTH = 64
)

(
	// Inputs
	input clk,
	input reset,
	input [7:0] PortIn,
	// Output
	output [31:0] ALUResultOut,
	output [31:0] PortOut
);
//******************************************************************/
//******************************************************************/
assign  PortOut = 0;

//******************************************************************/
//******************************************************************/
// Data types to connect modules
wire BranchNE_wire;
wire BranchEQ_wire;
wire RegDst_wire;
wire NotZeroANDBrachNE;
wire ZeroANDBrachEQ;
wire ORForBranch;
wire ALUSrc_wire;
wire RegWrite_wire;
wire Zero_wire;


wire [2:0] ALUOp_wire;
wire [3:0] ALUOperation_wire;
wire [4:0] WriteRegister_wire;
wire [31:0] MUX_PC_wire;
wire [31:0] PC_wire;
wire [31:0] Instruction_wire;
wire [31:0] ReadData1_wire;
wire [31:0] ReadData2_wire;
wire [31:0] InmmediateExtend_wire;
wire [31:0] ReadData2OrInmmediate_wire;
wire [31:0] ALUResult_wire;
wire [31:0] PC_4_wire;
wire [31:0] InmmediateExtendAnded_wire;
wire [31:0] PCtoBranch_wire;

// Practice 2
wire MemRead_wire;
wire MemtoReg_wire;
wire MemWrite_wire;

wire ControlJump_wire;
wire ControlJr_wire;

wire [31:0] DataMemorytoMUX;
wire [31:0] DataMemoryMUXtoRegisterFile;

wire [31:0] AdderBranchResult_wire;
wire [31:0] PC_Branch_wire;


wire [31:0] Shift_to_MUX_J_wire;
wire [31:0] PC_Jump_wire;


wire [4:0] JalWriteRegister_wire;

wire [31:0] MUXJalWriteData_wire;



// J, jal, jr

wire [31:0] JumpAddrSh2_wire;
wire [31:0] JumpAddr;
wire [31:0] JOrPC4OrBranchOrJR_wire;


integer ALUStatus;


//******************************************************************/
//******************************************************************/
//******************************************************************/
//******************************************************************/
//******************************************************************/
Control
ControlUnit
(

	.funct(Instruction_wire[5:0]),
	
	
	.OP(Instruction_wire[31:26]),
	.RegDst(RegDst_wire),
	.BranchNE(BranchNE_wire),
	.BranchEQ(BranchEQ_wire),
	.ALUOp(ALUOp_wire),
	.ALUSrc(ALUSrc_wire),
	.RegWrite(RegWrite_wire),
	
	.MemRead(MemRead_wire),
	.MemtoReg(MemtoReg_wire),
	.MemWrite(MemWrite_wire),
	
	// New Outputs for J
	.Jump(ControlJump_wire),
	.jr(ControlJr_wire)
);

PC_Register											
ProgramCounter
(
	.clk(clk),
	.reset(reset),
	.NewPC(JOrPC4OrBranchOrJR_wire),
	.PCValue(PC_wire)
);


ProgramMemory
#(
	.MEMORY_DEPTH(MEMORY_DEPTH)
)
ROMProgramMemory
(
	.Address(PC_wire),
	.Instruction(Instruction_wire)
);


Adder32bits
PC_Puls_4
(
	.Data0(PC_wire),
	.Data1(4),
	.Result(PC_4_wire)
);


Adder32bits
AdderBranches
(
	.Data0(PC_4_wire),
	.Data1(InmmediateExtend_wire << 2),
	.Result(AdderBranchResult_wire)
);


Multiplexer2to1
#(
	.NBits(32)
)
MUX_For_Brances
(
	.Selector((Zero_wire && BranchEQ_wire)|| (BranchNE_wire && ~Zero_wire)), 
	.MUX_Data0(PC_4_wire),
	.MUX_Data1(AdderBranchResult_wire),
	.MUX_Output(PC_Branch_wire)

);

// Loginc for J instructions
ShiftLeft2
jumpShifter
(
	.DataInput({6'b0,Instruction_wire[25:0]}),
   .DataOutput(JumpAddrSh2_wire)
);

Adder32bits
JumpAddr_4
(
	.Data0(32'hFFC00000), 
	.Data1({PC_4_wire[31:28], JumpAddrSh2_wire[27:0]}),

	.Result(JumpAddr)
);



/// MUX for the J instruction
Multiplexer2to1
#(
	.NBits(32)
)
MUX_For_J
(
	.Selector(ControlJump_wire), 
	.MUX_Data0(PC_Branch_wire),
	.MUX_Data1(JumpAddr),
	.MUX_Output(PC_Jump_wire)

);



// MUx for Jal instruction: save pc+4 in ra
Multiplexer2to1
#(
	.NBits(5)
)
MUX_For_Jal
(
	.Selector(ControlJump_wire), 
	.MUX_Data0(WriteRegister_wire),
	.MUX_Data1(5'b11111),
	.MUX_Output(JalWriteRegister_wire)
);

// JR
Multiplexer2to1
#(
	.NBits(32)
)
MUX_ForJR
(
	.Selector(ControlJr_wire),
	.MUX_Data0(PC_Jump_wire),
	.MUX_Data1(ReadData1_wire),
	.MUX_Output(JOrPC4OrBranchOrJR_wire)

);





//******************************************************************/
//******************************************************************/
//******************************************************************/
//******************************************************************/
//******************************************************************/
Multiplexer2to1
#(
	.NBits(5)
)
MUX_ForRTypeAndIType
(
	.Selector(RegDst_wire),
	.MUX_Data0(Instruction_wire[20:16]),
	.MUX_Data1(Instruction_wire[15:11]),
	.MUX_Output(WriteRegister_wire)

);



RegisterFile
Register_File
(
	.clk(clk),
	.reset(reset),
	.RegWrite(RegWrite_wire),
	.WriteRegister(JalWriteRegister_wire),
	.ReadRegister1(Instruction_wire[25:21]),
	.ReadRegister2(Instruction_wire[20:16]),
	.WriteData(MUXJalWriteData_wire),
	.ReadData1(ReadData1_wire),
	.ReadData2(ReadData2_wire)

);

SignExtend
SignExtendForConstants
(   
	.DataInput(Instruction_wire[15:0]),
   .SignExtendOutput(InmmediateExtend_wire)
);


Multiplexer2to1
#(
	.NBits(32)
)
MUX_ForReadDataAndInmediate
(
	.Selector(ALUSrc_wire),
	.MUX_Data0(ReadData2_wire),
	.MUX_Data1(InmmediateExtend_wire),
	
	.MUX_Output(ReadData2OrInmmediate_wire)

);


ALUControl
ArithmeticLogicUnitControl
(
	.ALUOp(ALUOp_wire),
	.ALUFunction(Instruction_wire[5:0]),
	.ALUOperation(ALUOperation_wire)

);



ALU
Arithmetic_Logic_Unit 
(
	.ALUOperation(ALUOperation_wire),
	.A(ReadData1_wire),
	.B(ReadData2OrInmmediate_wire),
	.shamt(Instruction_wire[10:6]),
	.Zero(Zero_wire),
	.ALUResult(ALUResult_wire)
);






Multiplexer2to1
#(
	.NBits(32)
)
MUX_ForReadDataFromDataMemory
(
	.Selector(MemtoReg_wire),
	.MUX_Data0(ALUResult_wire),
	.MUX_Data1(DataMemorytoMUX),
	.MUX_Output(DataMemoryMUXtoRegisterFile)

);


Multiplexer2to1
#(
	.NBits(32)
)
MUX_JALORDataFromDataMemory
(
	.Selector(ControlJump_wire),
	.MUX_Data0(DataMemoryMUXtoRegisterFile),
	.MUX_Data1(PC_4_wire),
	.MUX_Output(MUXJalWriteData_wire)

);




assign ALUResultOut = ALUResult_wire;

DataMemory
#(
	.DATA_WIDTH(32),
	.MEMORY_DEPTH(256)
)
Memory(
	.WriteData(ReadData2_wire),
	.Address((ALUResult_wire[7:0] == 0)?0:{24'b 0,ALUResult_wire[7:0]} /4),
	.MemWrite(MemWrite_wire),
	.MemRead(MemRead_wire),
	.clk(clk),
	.ReadData(DataMemorytoMUX)
);

endmodule
