library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity extender is
port(i_A : in std_logic_vector(15 downto 0);
	i_Sel : in std_logic;
	o_O : out std_logic_vector(31 downto 0));
end extender;

architecture dataflow of extender is
begin

G1: for i in 0 to 15 generate
	o_O(i) <= i_A(i);
end generate;

G2: for i in 16 to 31 generate
	o_O(i) <= i_Sel and i_A(15);
end generate;

end dataflow;

