library iEEE;
use iEEE.std_logic_1164.all;

entity or32 is
	generic(N : integer := 32);
	port(i_A : in std_logic_vector(N-1 downto 0);
	     i_B : in std_logic_vector(N-1 downto 0);
	     o_F : out std_logic_vector(N-1 downto 0));
end or32;

architecture structure of or32 is
component org2
port(i_A : in std_logic;
	i_B : in std_logic;
	o_F : out std_logic);
end component;

begin
F1: for i in 0 to N-1 generate
	or_i: org2 port map(i_A(i), i_B(i), o_F(i));
end generate;
end structure;