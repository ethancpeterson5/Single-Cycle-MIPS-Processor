-------------------------------------------------------------------------
-- Eduardo Contreras
-- CPR E 381
-- Lab 1 N-bit Adder Subtractor testbench
-------------------------------------------------------------------------
-- tb_addsubc_N.vhd
-------------------------------------------------------------------------
-- DESCRIPTION: This is the test bench for my adder subtractor using n-bit
-------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_textio.all;  -- For logic types I/O
library std;
use std.env.all;                -- For hierarchical/external signals
use std.textio.all;             -- For basic I/O-------------------------------------------------------------------------


entity tb_if_id is

  generic(gCLK_HPER   : time := 10 ns);   -- Generic for half of the clock cycle period

end tb_if_id;

architecture mixed of tb_if_id is

-- Define the total clock period time
constant cCLK_PER  : time := gCLK_HPER * 2;

-- We will be instantiating our design under test (DUT), so we need to specify its
-- component interface.
component if_id is 

 port(
      iUpdatedPCInstr	: in std_logic_vector(31 downto 0);
      iPCAddSrc		: in std_logic_vector(31 downto 0);
      iSignExtend	: in std_logic_vector(31 downto 0);
      iBranchControl	: in std_logic;
      iJumpControl      : in std_logic;
      iJALControl	: in std_logic;

      iJALAddr		: out std_logic_vector(31 downto 0);
      overflowPCAdd	: out std_logic;
      overflowBranchAdd : out std_logic;
      oUpdatedPCAdd     : out std_logic_vector(31 downto 0)
	
      );

end component;

signal CLK, reset : std_logic := '0';


signal s_iUpdatedPCInstr	: std_logic_vector(31 downto 0);
signal s_iPCAddSrc		: std_logic_vector(31 downto 0);
signal s_iSignExtend		: std_logic_vector(31 downto 0);
signal s_iBranchControl		: std_logic;
signal s_iJumpControl		: std_logic;
signal s_iJALControl		: std_logic;
signal s_iJALAddr		: std_logic_vector(31 downto 0);
signal s_overflowPCAdd		: std_logic;
signal s_overflowBranchAdd	: std_logic;
signal s_oUpdatedPCAdd     	: std_logic_vector(31 downto 0);


begin

  DUT0: if_id
  port map(

      iUpdatedPCInstr	=> s_iUpdatedPCInstr,
      iPCAddSrc		=> s_iPCAddSrc,
      iSignExtend	=> s_iSignExtend,
      iBranchControl	=> s_iBranchControl,
      iJumpControl      => s_iJumpControl,
      iJALControl 	=> s_iJALControl,
      iJALAddr 		=> s_iJALAddr,
      overflowPCAdd	=> s_overflowPCAdd,
      overflowBranchAdd => s_overflowBranchAdd,
      oUpdatedPCAdd     => s_oUpdatedPCAdd);

  --This first process is to setup the clock for the test bench
  P_CLK: process
  begin
    CLK <= '1';         -- clock starts at 1
    wait for gCLK_HPER; -- after half a cycle
    CLK <= '0';         -- clock becomes a 0 (negative edge)
    wait for gCLK_HPER; -- after half a cycle, process begins evaluation again
  end process;

  P_TEST_CASES: process
  begin
	
	s_iUpdatedPCInstr	<= x"11111111";	

	s_iPCAddSrc		<= x"00400004";		
	s_iSignExtend		<= x"00002222";		
	s_iBranchControl	<= '0';	
	s_iJumpControl		<= '0';

	--RESULT: FINAL MUX OUT SHOULD BE ORIGNIANL PC + 4; 0X00400008

    wait for gCLK_HPER*2;

	s_iUpdatedPCInstr	<= x"00000000";	
	--s_iPCAddSrc		<= x"00400008";		
	s_iSignExtend		<= x"00004444";		
	s_iBranchControl	<= '1';	
	s_iJumpControl		<= '0';

	--RESULT: FINAL MUX OUT SHOULD BE = (0X00400004 + 4) + (0X00004444 shifted left 2) = 0x00400008 + 0x00011110 = 0x00411118

    wait for gCLK_HPER*2;

	s_iUpdatedPCInstr	<= x"11111111";	
	--s_iPCAddSrc		<= x"0040000C";		
	s_iSignExtend		<= x"00002222";		
	s_iBranchControl	<= '0';	
	s_iJumpControl		<= '1';

	--RESULT: FINAL MUX OUT SHOULD BE = 0X0 & 0X4444444	= 0X04444444

    wait for gCLK_HPER*2;

	s_iUpdatedPCInstr	<= x"00000000";	
	--s_iPCAddSrc		<= x"00000010";		
	s_iSignExtend		<= x"00000000";		
	s_iBranchControl	<= '0';	
	s_iJumpControl		<= '0';

    wait for gCLK_HPER*2;


  end process;

end mixed;
