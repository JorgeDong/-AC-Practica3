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


// Practice 3

//IF
wire [63:0] IF_ID_out_wire;


wire [31:0] Instruction_wire_ID;
wire [31:0] PC_4_wire_ID;
wire [150:0] ID_IE_out_wire;


// EX
wire EX_RegDst_wire;
wire [2:0] EX_ALUOp_wire;
wire EX_ALUSrc_wire;
wire EX_RegWrite_wire;
wire EX_MemRead_wire;
wire EX_MemtoReg_wire;
wire EX_MemWrite_wire;
wire EX_ControlJump_wire;
wire EX_ControlJr_wire; // 9
wire [31:0] EX_PC_4_wire; //32
wire [31:0] EX_ReadData1_wire;//32
wire [31:0] EX_ReadData2_wire;//32
wire [31:0] EX_InmmediateExtend_wire; // 32
wire [9:0] EX_Instruction_wire; //5 + 5 = 10



wire EX_BranchNE_wire;
wire EX_BranchEQ_wire; 


wire [140:0] EX_MEM_out_wire;


// MEM
wire MEM_BranchNE_wire;
wire MEM_BranchEQ_wire;
wire MEM_MemWrite_wire;
wire MEM_MemtoReg_wire;
wire MEM_MemRead_wire;
wire MEM_RegWrite_wire;
wire MEM_Zero_wire;
wire [31:0]MEM_ALUResult_wire;
wire [31:0]MEM_AdderBranchResult_wire;
wire [31:0]MEM_ReadData2_wire;
wire [4:0] MEM_WriteRegister_wire;
wire [31:0] MEM_PC_4_wire;
wire MEM_ControlJump_wire;

wire [103:0] MEM_WB_out_wire;

// WB

wire WB_ControlJump_wire;
wire WB_RegWrite_wire;
wire WB_MemtoReg_wire;
					
wire [31:0] WB_DataMemorytoMUX;
wire [31:0] WB_PC_4_wire;
wire [31:0] WB_ALUResult_wire;
wire [4:0] WB_WriteRegister_wire;





integer ALUStatus;


//******************************************************************/
//******************************************************************/
//******************************************************************/
//******************************************************************/
//******************************************************************/
Control
ControlUnit
(

	.funct(Instruction_wire_ID[5:0]),
	
	
	.OP(Instruction_wire_ID[31:26]),
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

//Braches and Jump 
Adder32bits
AdderBranches
(
	//.Data0(PC_4_wire_ID),
	.Data0(PC_4_wire_ID),
	.Data1(EX_InmmediateExtend_wire << 2),
	.Result(AdderBranchResult_wire)
);


Multiplexer2to1
#(
	.NBits(32)
)
MUX_For_Brances
(
	//.Selector((MEM_Zero_wire && MEM_BranchEQ_wire)|| (MEM_BranchNE_wire && ~ MEM_Zero_wire)), 
	.Selector((MEM_Zero_wire && BranchEQ_wire)|| (BranchNE_wire && ~ MEM_Zero_wire)),
	.MUX_Data0(MEM_PC_4_wire),
	.MUX_Data1(MEM_AdderBranchResult_wire),
	.MUX_Output(PC_Branch_wire)

);

// Loginc for J instructions
ShiftLeft2
jumpShifter
(
	.DataInput({6'b0,Instruction_wire_ID[25:0]}),
   .DataOutput(JumpAddrSh2_wire)
);

Adder32bits
JumpAddr_4
(
	.Data0(32'hFFC00000), 
	//.Data1({PC_4_wire[31:28], JumpAddrSh2_wire[27:0]}),
	.Data1({PC_4_wire_ID[31:28], JumpAddrSh2_wire[27:0]}),
	.Result(JumpAddr)
);



/// MUX for the J instruction
Multiplexer2to1
#(
	.NBits(32)
)
MUX_For_J
(
	.Selector(WB_ControlJump_wire), 
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
	.Selector(WB_ControlJump_wire), 
	.MUX_Data0(WB_WriteRegister_wire),
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
	.Selector(EX_RegDst_wire),
	.MUX_Data0(EX_Instruction_wire[9:5]), 				
	.MUX_Data1(EX_Instruction_wire[4:0]),
	.MUX_Output(WriteRegister_wire)

);



RegisterFile
Register_File
(
	.clk(clk),
	.reset(reset),
	.RegWrite(WB_RegWrite_wire),
	.WriteRegister(JalWriteRegister_wire),
	.ReadRegister1(Instruction_wire_ID[25:21]),
	.ReadRegister2(Instruction_wire_ID[20:16]),
	.WriteData(MUXJalWriteData_wire),
	.ReadData1(ReadData1_wire),
	.ReadData2(ReadData2_wire)

);

SignExtend
SignExtendForConstants
(   
	.DataInput(Instruction_wire_ID[15:0]),
   .SignExtendOutput(InmmediateExtend_wire)
);


Multiplexer2to1
#(
	.NBits(32)
)
MUX_ForReadDataAndInmediate
(
	.Selector(EX_ALUSrc_wire),
	.MUX_Data0(EX_ReadData2_wire),
	.MUX_Data1(EX_InmmediateExtend_wire),
	
	.MUX_Output(ReadData2OrInmmediate_wire)

);


ALUControl
ArithmeticLogicUnitControl
(
	.ALUOp(EX_ALUOp_wire),
	.ALUFunction(Instruction_wire_ID[5:0]),
	.ALUOperation(ALUOperation_wire)

);



ALU
Arithmetic_Logic_Unit 
(
	.ALUOperation(ALUOperation_wire),
	.A(EX_ReadData1_wire),
	.B(ReadData2OrInmmediate_wire),
	.shamt(Instruction_wire_ID[10:6]),
	.Zero(Zero_wire),
	.ALUResult(ALUResult_wire)
);






Multiplexer2to1
#(
	.NBits(32)
)
MUX_ForReadDataFromDataMemory
(
	.Selector(WB_MemtoReg_wire),
	.MUX_Data0(WB_ALUResult_wire),
	.MUX_Data1(WB_DataMemorytoMUX),
	.MUX_Output(DataMemoryMUXtoRegisterFile)

);


Multiplexer2to1
#(
	.NBits(32)
)
MUX_JALORDataFromDataMemory
(
	.Selector(WB_ControlJump_wire),
	.MUX_Data0(DataMemoryMUXtoRegisterFile),
	.MUX_Data1(WB_PC_4_wire),
	.MUX_Output(MUXJalWriteData_wire)

);




assign ALUResultOut = WB_ALUResult_wire;

DataMemory
#(
	.DATA_WIDTH(32),
	.MEMORY_DEPTH(256)
)
Memory(
	.WriteData(MEM_ReadData2_wire),
	.Address((MEM_ALUResult_wire[7:0] == 0)?0:{24'b 0,MEM_ALUResult_wire[7:0]} /4),
	.MemWrite(MEM_MemWrite_wire),
	.MemRead(MEM_MemRead_wire),
	.clk(clk),
	.ReadData(DataMemorytoMUX)
);

// Pipes
Pipe
#(
.N(64)
)											
IF_ID
(
	.clk(clk),
	.reset(reset),
	.enable(1),
	.DataInput({Instruction_wire,PC_4_wire}),
	.DataOutput(IF_ID_out_wire)
);

assign Instruction_wire_ID = IF_ID_out_wire[63:32];
assign PC_4_wire_ID = IF_ID_out_wire[31:0];



Pipe
#(
.N(151)
)											
ID_EX
(
	.clk(clk),
	.reset(reset),
	.enable(1),
	.DataInput({
					BranchNE_wire,
					BranchEQ_wire,
					RegDst_wire,
					ALUOp_wire, // 3
					ALUSrc_wire,
					RegWrite_wire,
					MemRead_wire,
					MemtoReg_wire,
					MemWrite_wire,
					ControlJump_wire,
					ControlJr_wire, // 1 suma = 10
					PC_4_wire_ID, //32
					ReadData1_wire,//32
					ReadData2_wire,//32
					InmmediateExtend_wire, // 32
					Instruction_wire_ID[20:16], //5
					Instruction_wire_ID[15:11] // 5 
					}),
	.DataOutput(ID_IE_out_wire)
);

assign EX_BranchNE_wire = ID_IE_out_wire[150]; //pasa al siguiente pipe
assign EX_BranchEQ_wire = ID_IE_out_wire[149]; // pasa al siguiente pipe
assign EX_RegDst_wire = ID_IE_out_wire[148];
assign EX_ALUOp_wire = ID_IE_out_wire[147:145];
assign EX_ALUSrc_wire = ID_IE_out_wire[144];

assign EX_RegWrite_wire = ID_IE_out_wire[143];
assign EX_MemRead_wire = ID_IE_out_wire[142]; // Sale del pipe EX/MEM
assign EX_MemtoReg_wire = ID_IE_out_wire[141]; // Sale del pipe EX/MEM
assign EX_MemWrite_wire = ID_IE_out_wire[140]; // Sale del MEM/WB
assign EX_ControlJump_wire = ID_IE_out_wire[139]; // pasa al siguiente pipe
assign EX_ControlJr_wire = ID_IE_out_wire[138]; //Este no se esta usando
assign EX_PC_4_wire = ID_IE_out_wire[137:106];
assign EX_ReadData1_wire = ID_IE_out_wire[105:74];
assign EX_ReadData2_wire = ID_IE_out_wire[73:42];
assign EX_InmmediateExtend_wire = ID_IE_out_wire[41:10];
assign EX_Instruction_wire = ID_IE_out_wire[9:0];



Pipe
#(
.N(141)
)											
EX_MEM
(
	.clk(clk),
	.reset(reset),
	.enable(1),
	.DataInput({
					EX_ControlJump_wire,
					EX_BranchNE_wire,
					EX_BranchEQ_wire,
					
					EX_MemWrite_wire,
					EX_MemtoReg_wire,
					EX_MemRead_wire,
					EX_RegWrite_wire,
					
					Zero_wire, //1
					ALUResult_wire, //32
					
					AdderBranchResult_wire, //32
					
					EX_ReadData2_wire, //32
					WriteRegister_wire,//5
					EX_PC_4_wire //32
					}),
	.DataOutput(EX_MEM_out_wire)
);


assign MEM_ControlJump_wire = EX_MEM_out_wire[140];
assign MEM_BranchNE_wire = EX_MEM_out_wire[139];
assign MEM_BranchEQ_wire = EX_MEM_out_wire[138];
assign MEM_MemWrite_wire = EX_MEM_out_wire[137];
assign MEM_MemtoReg_wire = EX_MEM_out_wire[136]; // Se pasa al siguiente pipe
assign MEM_MemRead_wire = EX_MEM_out_wire[135];

assign MEM_RegWrite_wire = EX_MEM_out_wire[134]; // Se pasa al siguiente pipe

assign MEM_Zero_wire = EX_MEM_out_wire[133]; // va al mux
assign MEM_ALUResult_wire = EX_MEM_out_wire[132:101]; // se pasa y va al data memory
assign MEM_AdderBranchResult_wire = EX_MEM_out_wire[100:69]; // Van al MUX

assign MEM_ReadData2_wire = EX_MEM_out_wire[68:37]; // va al data memory

assign MEM_WriteRegister_wire = EX_MEM_out_wire[36:32]; // Se pasa al siguient pipe

assign MEM_PC_4_wire = EX_MEM_out_wire[31:0]; // Van al MUX





// Ultimo pipe 


Pipe
#(
.N(104)
)											
MEM_WB
(
	.clk(clk),
	.reset(reset),
	.enable(1),
	.DataInput({
					MEM_ControlJump_wire,
					MEM_RegWrite_wire,
					MEM_MemtoReg_wire,
					
					DataMemorytoMUX, // ReadData 32
					MEM_PC_4_wire, //32
					MEM_ALUResult_wire, //32
					MEM_WriteRegister_wire //5
					}),
	.DataOutput(MEM_WB_out_wire)
);


assign WB_ControlJump_wire = MEM_WB_out_wire[103]; // MUX de Jump previo
assign WB_RegWrite_wire = MEM_WB_out_wire[102]; // Register File
assign WB_MemtoReg_wire = MEM_WB_out_wire[101]; // MUX
					
assign WB_DataMemorytoMUX = MEM_WB_out_wire[100:69]; // MUX
assign WB_PC_4_wire = MEM_WB_out_wire[68:37];// Ultimo MUX
assign WB_ALUResult_wire = MEM_WB_out_wire[36:5]; //32
assign WB_WriteRegister_wire = MEM_WB_out_wire[4:0];//5


endmodule
