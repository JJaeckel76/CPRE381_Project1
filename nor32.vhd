library iEEE;
use iEEE.std_logic_1164.all;

entity nor32 is
	generic(N : integer := 32);
	port(i_A : in std_logic_vector(N-1 downto 0);
	     i_B : in std_logic_vector(N-1 downto 0);
	     o_F : out std_logic_vector(N-1 downto 0));
end nor32;

architecture structure of nor32 is
component org2
port(i_A : in std_logic;
	i_B : in std_logic;
	o_F : out std_logic);
end component;

signal orO : std_logic_vector(N-1 downto 0);

begin
F1: for i in 0 to N-1 generate
	or_i: org2 port map(i_A(i), i_B(i), orO(i));
	o_F(i) <= NOT orO(i);
end generate;
end structure;