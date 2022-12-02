library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
entity shift2 is
	port(i_A : in std_logic_vector(31 downto 0);
		o_Y : out std_logic_vector(31 downto 0));
end shift2;

architecture dataflow of shift2 is 
begin
	o_Y <= i_A(29 downto 0)& "00";
end dataflow;
