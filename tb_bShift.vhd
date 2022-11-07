library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity tb_bShift is
generic (gCLK_HPER  :  time := 50 ns;
	N : integer :=32);
end tb_bShift;

architecture structure of tb_bShift is
constant cCLK_HPER : time := gCLK_HPER * 2;

component BarrellShift
port(i_I	: in std_logic_vector(31 downto 0);
     i_Sh	: in std_logic_vector(4 downto 0);
     i_Sel      : in std_logic_vector(1 downto 0); 
     o_Ot       : out std_logic_vector(31 downto 0));
end component;

signal s_I, s_Ot : std_logic_vector(31 downto 0);
signal s_Sh : std_logic_vector(4 downto 0);
signal s_Sel : std_logic_vector(1 downto 0);

begin

	DUT: BarrellShift
	port map(i_I => s_I,
		 i_Sh => s_Sh,
		 i_Sel => s_Sel,
		 o_Ot => s_Ot);

P_TB: process 
begin
s_i <= "000000000000000000000000000000000";
s_Sh <= "00000";
s_Sel <= "00";
wait for cCLK_HPER;

s_i <= "000000000000000000000000000011110";
s_Sh <= "00001";
s_Sel <= "00";
wait for cCLK_HPER;

s_i <= "000000000000000000000000000011110";
s_Sh <= "00001";
s_Sel <= "01";
wait for cCLK_HPER;

s_i <= "000000000000000000000000000011110";
s_Sh <= "00001";
s_Sel <= "10";
wait for cCLK_HPER;

s_i <= "000000000000000000000000000011110";
s_Sh <= "00010";
s_Sel <= "10";
wait for cCLK_HPER;

s_i <= "010101010101010101010101010101010";
s_Sh <= "00001";
s_Sel <= "00";
wait for cCLK_HPER;

s_i <= "010101010101010101010101010101010";
s_Sh <= "00001";
s_Sel <= "01";
wait for cCLK_HPER;

s_i <= "010101010101010101010101010101010";
s_Sh <= "00001";
s_Sel <= "10";
wait for cCLK_HPER;

s_i <= "000000000000001111100000000000000";
s_Sh <= "00111";
s_Sel <= "01";
wait for cCLK_HPER;

s_i <= "000000000000001111100000000000000";
s_Sh <= "00111";
s_Sel <= "10";
wait for cCLK_HPER;

s_i <= "000000000000001111100000000000000";
s_Sh <= "00011";
s_Sel <= "10";
wait for cCLK_HPER;

end process;
end behavior;


