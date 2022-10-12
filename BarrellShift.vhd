--Sam Burrell and Justin Jaeckel
--Barrell Shifter VHDL Code

library IEEE;
use IEEE.std_logic_1164.all;

entity BarrellShift is 
port(   i_I : in std_logic_vector(31 downto 0);
	i_Sh : in std_logic_vector(4 downto 0);
	i_Sel : in std_logic_vector(1 downto 0); 
	o_Ot : : out std_logic_vector(31 downto 0));
end BarrellShift


architecture structure of BarrellShift is

component mux is
port (  i_S : in std_logic;
	i_D0 : in std_logic_vector(31 downto 0);
	i_D1 : in std_logic_vector(31 downto 0);
	o_O : out std_logic_vector(31 downto 0));
end comonent;

signal mo_1, mo_2, mo_3, mo_4 : std_logic_vector(31 downto 0);
signal t_1, t_2, t_3, t_4, t_5, t_6 : std_logic_vector(31 downto 0);

begin

process(i_I, i_Sh, i_Sel, mo_1, mo_2, mo_3, mo_4, t_1, t_2, t_3, t_4, t_5, t_6)
begin

	case i_Sel is
	  when "00" =>
		t_1 <= i_I(30 downto 0) & '0';
		t_2 <= mo_1(29 downto 0) & "00";
		t_3 <= mo_2(27 downto 0) & "0000";
		t_4 <= mo_3(23 downto 0) & "00000000";
		t_5 <= mo_4(15 downto 0) & "0000000000000000";
	 when "01" =>
		t_1 <= '0' & i_I(31 downto 1);
		t_2 <= "00" & mo_1(31 downto 2);
		t_3 <= "0000" & mo_2(31 downto 4);
		t_4 <= "00000000" & mo_3(31 downto 8);
		t_5 <= "0000000000000000" & mo_4(31 downto 16);
	 when "10" =>
		t_1 <= i_I(31) & i_I(31 downto 1);
		t_2 <= i_I(31) & i_I(31) & mo_1(31 downto 2);
		t_3 <= i_I(31) & i_I(31) & i_I(31) & i_I(31) & mo_2(31 downto 4);
		t_4 <= i_I(31) & i_I(31) & i_I(31) & i_I(31) & i_I(31) & i_I(31) & i_I(31) & i_I(31) & mo_3(31 downto 8);
		t_5 <= i_I(31) & i_I(31) & i_I(31) & i_I(31) & i_I(31) & i_I(31) & i_I(31) & i_I(31) & i_I(31) & i_I(31) & i_I(31) & i_I(31) & i_I(31) & i_I(31) & i_I(31) & i_I(31) & mo_4(31 downto 16);
	 when others => t_1 <= i_I;
	end case;
end process;

GMUX_1: mux
	port map(i_D0 => i_I,
		 i_D1 => t_1,
		 i_S => i_Sh(0),
		 o_O => mo_1);

GMUX_2: mux
	port map(i_D0 => mo_1,
		 i_D1 => t_2,
		 i_S => i_Sh(1),
		 o_O => mo_2);

GMUX_3: mux
	port map(i_D0 => mo_2,
		 i_D1 => t_3,
		 i_S => i_Sh(2),
		 o_O => mo_3);

GMUX_4: mux
	port map(i_D0 => mo_3,
		 i_D1 => t_4,
		 i_S => i_Sh(3),
		 o_O => mo_4);

GMUX_5: mux
	port map(i_D0 => mo_4,
		 i_D1 => t_5,
		 i_S => i_Sh(4),
		 o_O => o_Ot);

end structure;

