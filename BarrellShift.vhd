--Sam Burrell and Justin Jaeckel
--Barrell Shifter VHDL Code

library IEEE;
use IEEE.std_logic_1164.all;

entity BarrellShift is 
port(   i_I : in std_logic_vector(31 downto 0);
        i_Sel : in std_logic;
        i_Dir : in std_logic; 
	i_Shft : in std_logic_vector(4 downto 0);
	o_Ot : out std_logic_vector(31 downto 0));
end BarrellShift


architecture structure of BarrellShift is

component mux2t1_N is
port (  i_S : in std_logic;
	i_D0 : in std_logic_vector(31 downto 0);
	i_D1 : in std_logic_vector(31 downto 0);
	o_O : out std_logic_vector(31 downto 0));
end comonent;

component mux2t1 is
port(i_D0 : in std_logic;
     i_D1 : in std_logic;
     i_S : in std_logic;
     i_O : in std_logic);
end component

signal shft : std_logic;
signal s_D, ls_i, ls_o : std_logic_vector(31 downto 0);
signal sh0_i, sh1_i, sh2_i, sh3_i, sh4_i : std_logic_vector(31 downto 0);
signal sh0_o, sh1_o, sh2_o, sh3_o, sh4_o : std_logic_vector(31 downto 0);


begin

	sl_i(0) <= i_I(31);
	sl_i(1) <= i_I(30);
	sl_i(2) <= i_I(29);
	sl_i(3) <= i_I(28);
	sl_i(4) <= i_I(27);
	sl_i(5) <= i_I(26);
	sl_i(6) <= i_I(25);
	sl_i(7) <= i_I(24);
	sl_i(8) <= i_I(23);
	sl_i(9) <= i_I(22);
	sl_i(10) <= i_I(21);
	sl_i(11) <= i_I(20);
	sl_i(12) <= i_I(19);
	sl_i(13) <= i_I(18);
	sl_i(14) <= i_I(17);
	sl_i(15) <= i_I(16);
	sl_i(16) <= i_I(15);
	sl_i(17) <= i_I(14);
	sl_i(18) <= i_I(13);
	sl_i(19) <= i_I(12);
	sl_i(20) <= i_I(11);
	sl_i(21) <= i_I(10);
	sl_i(22) <= i_I(9);
	sl_i(23) <= i_I(8);
	sl_i(24) <= i_I(7);
	sl_i(25) <= i_I(6);
	sl_i(26) <= i_I(5);
	sl_i(27) <= i_I(4);
	sl_i(28) <= i_I(3);
	sl_i(29) <= i_I(2);
	sl_i(30) <= i_I(1);
	sl_i(31) <= i_I(0);


MUX1: mux2t1_N
	port map(i_S => i_Dir,
		 i_D0 => i_I,
		 i_D1 => ls_i,
		 o_O => s_D);
MUX2: mux2t1
	port map(i_S => i_Sel,
		 i_D0 => '0',
		 i_D1 => s_D(31),
		 o_O => shft);

sh0_i(30 downto 0) <= s_D(31 downto 1);
sh0_i(31) <= shft;

MUX3: mux2t1_N
	generic map (N => 32)
	port map(i_S => i_Shft(0),
		 i_D0 => s_D,
		 i_D1 => sh0_i,
		 o_O => sh0_o);

sh1_i(29 downto 0) <= sh0_o(31 downto 2);
sh1_i(31) <= shft;
sh1_i(31) <= shft;

MUX4: mux2t1_N
	generic map (N => 32)
	port map(i_S => i_Shft(1),
		 i_D0 => sh0_o,
		 i_D1 => sh1_i,
		 o_O => sh1_o);
sh2_i(27 downto 0) <= sh1_o(31 downto 4);
sh2_i(31) <= shft;
sh2_i(30) <= shft;
sh2_i(29) <= shft;
sh2_i(28) <= shft;

MUX5: mux2t1_N
	generic map (N => 32)
	port map(i_S => i_Shft(2),
		 i_D0 => sh1_o,
		 i_D1 => sh2_i,
		 o_O => sh2_o);

sh3_i(23 downto 0) <= sh2_o(31 downto 8);
sh3_i(31) <= shft;
sh3_i(30) <= shft;
sh3_i(29) <= shft;
sh3_i(28) <= shft;
sh3_i(27) <= shft;
sh3_i(26) <= shft;
sh3_i(25) <= shft;
sh3_i(24) <= shft;

MUX6: mux2t1_N
	generic map (N => 32)
	port map(i_S => i_Shft(3),
		 i_D0 => sh2_o,
		 i_D1 => sh3_i,
		 o_O => sh3_o);

sh4_i(15 downto 0) <= sh3_o(31 downto 16);
sh4_i(31) <= shft;
sh4_i(30) <= shft;
sh4_i(29) <= shft;
sh4_i(28) <= shft;
sh4_i(27) <= shft;
sh4_i(26) <= shft;
sh4_i(25) <= shft;
sh4_i(24) <= shft;
sh4_i(23) <= shft;
sh4_i(22) <= shft;
sh4_i(21) <= shft;
sh4_i(20) <= shft;
sh4_i(19) <= shft;
sh4_i(18) <= shft;
sh4_i(17) <= shft;
sh4_i(16) <= shft;

MUX6: mux2t1_N
	generic map (N => 32)
	port map(i_S => i_Shft(4),
		 i_D0 => sh3_o,
		 i_D1 => sh4_i,
		 o_O => sh4_o);

ls_o(0) <= sh4_o(31);
ls_o(1) <= sh4_o(30);
ls_o(2) <= sh4_o(29);
ls_o(3) <= sh4_o(28);
ls_o(4) <= sh4_o(27);
ls_o(5) <= sh4_o(26);
ls_o(6) <= sh4_o(25);
ls_o(7) <= sh4_o(24);
ls_o(8) <= sh4_o(23);
ls_o(9) <= sh4_o(22);
ls_o(10) <= sh4_o(21);
ls_o(11) <= sh4_o(20);
ls_o(12) <= sh4_o(19);
ls_o(13) <= sh4_o(18);
ls_o(14) <= sh4_o(17);
ls_o(15) <= sh4_o(16);
ls_o(16) <= sh4_o(15);
ls_o(17) <= sh4_o(14);
ls_o(18) <= sh4_o(13);
ls_o(19) <= sh4_o(12);
ls_o(20) <= sh4_o(11);
ls_o(21) <= sh4_o(10);
ls_o(22) <= sh4_o(9);
ls_o(23) <= sh4_o(8);
ls_o(24) <= sh4_o(7);
ls_o(25) <= sh4_o(6);
ls_o(26) <= sh4_o(5);
ls_o(27) <= sh4_o(4);
ls_o(28) <= sh4_o(3);
ls_o(29) <= sh4_o(2);
ls_o(30) <= sh4_o(1);
ls_o(31) <= sh4_o(0);

MUX7: mux2t1_N
	generic map (N => 32)
	port map(i_S => i_Dir,
		 i_D0 => sh4_o,
		 i_D1 => ls_o,
		 o_O => o_Ot);


end structure;

