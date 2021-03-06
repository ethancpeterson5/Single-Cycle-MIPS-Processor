library IEEE;
use IEEE.std_logic_1164.all;

entity mux2t1 is 
	port(i_S	: in std_logic;
	     i_D1	: in std_logic;
	     i_D0       : in std_logic;
	     o_O 	: out std_logic);    	
end mux2t1;
architecture structural of mux2t1 is
	component invg
		port(i_A          : in std_logic;
                     o_F          : out std_logic);
	end component;
	component andg2
		port(i_A          : in std_logic;
       		     i_B          : in std_logic;
       		     o_F          : out std_logic);
	end component;
	component org2
	        port(i_A          : in std_logic;
                     i_B          : in std_logic;
                     o_F          : out std_logic);
	end component;
	signal s_Not : std_logic;
	signal s_AndG1 : std_logic; 
	signal s_AndG2 : std_logic;

begin 
	g_NotGate1: invg
		port Map(i_A		=> i_S,
		         o_F		=> s_Not);
	g_AndGate1: andg2
		port Map(i_A		=> i_D0,
			 i_B		=> s_Not,
			 o_F		=> s_AndG1);
	g_AndGate2: andg2
		port Map(i_A		=> i_D1,
			 i_B		=> i_S,
			 o_F		=> s_AndG2);
	g_OrGate: org2
		port Map(i_A		=> s_AndG1,
			 i_B		=> s_AndG2,
			 o_F		=> o_O);
		         
	
end structural;