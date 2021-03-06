library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity controlUnit is 
	port(opcode : in std_logic_vector(5 downto 0);
	functionF : in std_logic_vector(5 downto 0);
	reg_dst : out std_logic;
	jump : out std_logic;
	branch : out std_logic;
	memToReg : out std_logic;
	memWrite : out std_logic;
	ALUsrc : out std_logic; 
	regWrite : out std_logic;
	signExtend : out std_logic;
	jr : out std_logic;
	jal : out std_logic;
	ALUOP	: out std_logic_vector(3 downto 0);
	ImmType : out std_logic; -- 0 if not, 1 if i-type instruction
	luiInst : out std_logic; 
	i_CLK : in std_logic
	);
end controlUnit;

architecture behavior of controlUnit is 
begin
	process(opcode, functionF,i_CLK)
	begin
	if opcode = "000000" and functionF = "001000" then --jr instruction
		reg_dst <= 'X';
		jump <= '1';
		jr <= '1';
		branch <= 'X';
		memToReg <= '0';
		memWrite <= '0';
		ALUsrc <= 'X';
		regWrite <= '0';
		signExtend <= '0';
		ALUOP <= "XXXX";
		ImmType <= '0';
		jal <= '0';
		luiInst <= '0';
	elsif opcode = "000000" then -- R format
		reg_dst <= '1';
		jump <= '0';
		jr <= '0';
		branch <= '0';
		memToReg <= '0';
		memWrite <= '0';
		ALUsrc <= '0';
		regWrite <= '1';
		signExtend <= '0';
		ALUOP <= "0010";
		ImmType <= '0';
		jal <= '0';
		luiInst <= '0';
	elsif opcode = "001000" then --addi
		reg_dst <= '0';
		jump <= '0';
		jr <= '0';
		branch <= '0';
		memToReg <= '0';
		memWrite <= '0';
		ALUsrc <= '1';
		regWrite <= '1';
		signExtend <= '1';
		ALUOP <= "0010";
		ImmType <= '1';
		jal <= '0';
		luiInst <= '0';
	elsif opcode = "001001" then -- addiu
		reg_dst <= '0';
		jump <= '0';
		jr <= '0';
		branch <= '0';
		memToReg <= '0';
		memWrite <= '0';
		ALUsrc <= '1';
		regWrite <= '1';
		signExtend <= '1';
		ALUOP <= "0010";
		ImmType <= '1';
		jal <= '0';
		luiInst <= '0';
	elsif opcode = "001100" then --andi
		reg_dst <= '0';
		jump <= '0';
		jr <= '0';
		branch <= '0';
		memToReg <= '0';
		memWrite <= '0';
		ALUsrc <= '1';
		regWrite <= '1';
		signExtend <= '1';
		ALUOP <= "1000";
		ImmType <= '1';
		jal <= '0';
		luiInst <= '0';
	elsif opcode = "001111" then --lui
		reg_dst <= '0';
		jump <= '0';
		jr <= '0';
		branch <= '0';
		memToReg <= '1';
		memWrite <= '0';
		ALUsrc <= '1';
		regWrite <= '1';
		signExtend <= '1';
		ALUOP <= "0011";
		ImmType <= '1';
		jal <= '0';
		luiInst <= '1';
	elsif opcode = "100011" then -- lw
		reg_dst <= '0';
		jump <= '0';
		jr <= '0';
		branch <= '0';
		memToReg <= '1';
		memWrite <= '0';
		ALUsrc <= '1';
		regWrite <= '1';
		signExtend <= '0';
		ALUOP <= "0100";
		ImmType <= '1';
		jal <= '0';
		luiInst <= '0';
	elsif opcode = "001110" then -- xori
		reg_dst <= '0';
		jump <= '0';
		jr <= '0';
		branch <= '0';
		memToReg <= '0';
		memWrite <= '0';
		ALUsrc <= '1';
		regWrite <= '1';
		signExtend <= '1';
		ALUOP <= "1001";
		ImmType <= '1';
		jal <= '0';
		luiInst <= '0';
	elsif opcode = "001101" then --ori
		reg_dst <= '0';
		jump <= '0';
		jr <= '0';
		branch <= '0';
		memToReg <= '0';
		memWrite <= '0';
		ALUsrc <= '1';
		regWrite <= '1';
		signExtend <= '1';
		ALUOP <= "1010";
		ImmType <= '1';
		jal <= '0';
		luiInst <= '0';
	elsif opcode = "001010" then -- slti
		reg_dst <= '0';
		jump <= '0';
		jr <= '0';
		branch <= '0';
		memToReg <= '0';
		memWrite <= '0';
		ALUsrc <= '1';
		regWrite <= '1';
		signExtend <= '1';
		ALUOP <= "1011";
		ImmType <= '1';
		jal <= '0';
		luiInst <= '0';
	elsif opcode = "101011" then --sw
		reg_dst <= '0';
		jump <= '0';
		jr <= '0';
		branch <= '0';
		memToReg <= '0';
		memWrite <= '1';
		ALUsrc <= '1';
		regWrite <= '0';
		signExtend <= '0';
		ALUOP <= "0010";
		ImmType <= '1';
		jal <= '0';
		luiInst <= '0';
	elsif opcode = "000100" then --beq
		reg_dst <= '0';
		jump <= '0';
		jr <= '0';
		branch <= '1';
		memToReg <= '0';
		memWrite <= '0';
		ALUsrc <= '0';
		regWrite <= '0';
		signExtend <= '0';
		ALUOP <= "1100";
		ImmType <= '1';
		jal <= '0';
		luiInst <= '0';
	elsif opcode = "000101" then --bne
		reg_dst <= '0';
		jump <= '0';
		jr <= '0';
		branch <= '1';
		memToReg <= '0';
		memWrite <= '0';
		ALUsrc <= '0';
		regWrite <= '0';
		signExtend <= '0';
		ALUOP <= "1101";
		ImmType <= '1';
		jal <= '0';
		luiInst <= '0';
	elsif opcode = "000010" then --j
		reg_dst <= 'X';
		jump <= '1';
		jr <= '0';
		branch <= 'X';
		memToReg <= 'X';
		memWrite <= '0';
		ALUsrc <= 'X';
		regWrite <= '0';
		signExtend <= '0';
		ALUOP <= "XXXX";
		ImmType <= '0';
		jal <= '0';
		luiInst <= '0';
	elsif opcode = "000011" then --jal
		reg_dst <= 'X';
		jump <= '1';
		jr <= '0';
		branch <= 'X';
		memToReg <= '0';
		memWrite <= '0';
		ALUsrc <= '1';
		regWrite <= '1';
		signExtend <= '0';
		ALUOP <= "0000";
		ImmType <= '0';
		jal <= '1';
		luiInst <= '0';
	elsif opcode = "000100" then --beq
		reg_dst <= '0';
		jump <= '0';
		branch <= '1';
		memToReg <= '0';
		memWrite <= '0';
		ALUsrc <= '0';
		regWrite <= '0';
		signExtend <= '0';
		ALUOP <= "1100";
		ImmType <= '1';
		jal <= '0';
		luiInst <= '0';
	elsif opcode = "000101" then --bne
		reg_dst <= '0';
		jump <= '0';
		branch <= '1';
		memToReg <= '0';
		memWrite <= '0';
		ALUsrc <= '0';
		regWrite <= '0';
		signExtend <= '0';
		ALUOP <= "1101";
		ImmType <= '1';
		jal <= '0';
		luiInst <= '0';
	elsif opcode = "011111" then 
		reg_dst <= '0';
		jump <= '0';
		branch <= '0';
		memToReg <= '0';
		memWrite <= '0';
		ALUsrc <= '1';
		regWrite <= '1';
		signExtend <= '0';
		ALUOP <= "1110";
		ImmType <= '1';
		jal <= '0';
		luiInst <= '0';
	end if;
	end process;
end behavior;
		

	
