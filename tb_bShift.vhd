library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_textio.all;
use IEEE.numeric_std.all;
library std;
use std.env.all;
use std.textio.all;

entity tb_bShift is
generic (gCLK_HPER  :  time := 50 ns);
end tb_bShift;

architecture behavior of tb_bShift is
constant cCLK_HPER : time := gCLK_HPER * 2;

component BarrellShift
port(i_I : in std_logic_vector(31 downto 0);
        i_Sel : in std_logic;
        i_Dir : in std_logic; 
	i_Shft : in std_logic_vector(4 downto 0);
	o_Ot : out std_logic_vector(31 downto 0));
end component;

signal s_CLK : std_logic := '0';

signal s_I, s_Ot : std_logic_vector(31 downto 0);
signal s_Sh : std_logic_vector(4 downto 0);
signal s_D : std_logic := '0';
signal s_Sel : std_logic := '0';


begin

	DUT: BarrellShift
	port map(i_I => s_I,
		 i_Shft => s_Sh,
		 i_Sel => s_Sel,
		 i_Dir => s_D,
		 o_Ot => s_Ot);

P_CLK: process
begin
 s_CLK <= '0';
 wait for gCLK_HPER;
 s_CLK <= '1';
 wait for gCLK_HPER;
end process;

P_TB: process 
begin

s_I <= x"EEEEEEEE";
s_Sh <= "00010";
s_Sel <= '0';
s_D <= '1';
wait for cCLK_HPER;

s_I <= x"EEEEEEEE";
s_Sh <= "00010";
s_Sel <= '1';
s_D <= '1';
wait for cCLK_HPER;

s_I <= "00000000001111100000000000000000";
s_Sh <= "00100";
s_Sel <= '0';
s_D <= '1';
wait for cCLK_HPER;

s_I <= "10101010101010101010101010101010";
s_Sh <= "01010";
s_Sel <= '0';
s_D <= '1';
wait for cCLK_HPER;


wait;
end process;
end behavior;


