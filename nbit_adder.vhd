--Sam Burrell
--This is my implementation of a n-bit adder

library IEEE;
use IEEE.std_logic_1164.all;

entity nbit_adder is
generic(N : integer :=  32);
port(i_A, i_B : in std_logic_vector(N-1 downto 0);
	i_CN : in std_logic;
	o_Carry : out std_logic; 
	o_S : out std_logic_vector(N-1 downto 0));
end nbit_adder;

architecture structure of nbit_adder is

component fAdder
  port(i_X, i_Y, i_CN : in std_logic;
	o_Cout, o_Sum : out std_logic);
end component;

signal s_CN : std_logic_vector(N-2 downto 0);

begin

ADDER0: fAdder port map(

	i_X => i_A(0),
	i_Y => i_B(0),
	i_CN => i_CN,
	o_Sum => o_S(0),
	o_Cout => s_CN(0));

NBITADDERS: for i in 1 to N-2 generate
	nbitloop: fAdder port map(
	i_X => i_A(i),
	i_Y => i_B(i),
	i_CN => s_CN(i-1),
	o_Sum => o_S(i),
	o_Cout => s_CN(i));
end generate NBITADDERS;

ADDERN : fAdder port map(
	i_X => i_A(N-1),
	i_Y => i_B(N-1),
	i_CN => s_CN(N-2),
	o_Sum => o_S(N-1),
	o_Cout => o_Carry);

end structure;
