library iEEE;
use iEEE.std_logic_1164.all;

entity mux4t1 is
generic(N: integer := 32);
port(i_D0 : in std_logic_vector(N-1 downto 0);
     i_D1 : in std_logic_vector(N-1 downto 0);
     i_D2 : in std_logic_vector(N-1 downto 0);
     i_D3 : in std_logic_vector(N-1 downto 0);
     i_I0 : in std_logic;
     i_I1 : in std_logic;
     o_O : out std_logic_vector(N-1 downto 0));
end mux4t1;

architecture structure of mux4t1 is
component mux2t1_N
generic(N : integer := 32);
port(i_D0         : in std_logic_vector(N-1 downto 0);
     i_D1         : in std_logic_vector(N-1 downto 0);
     i_S          : in std_logic;
     o_O          : out std_logic_vector(N-1 downto 0));
end component;

signal s_S1, s_S2 : std_logic_vector(N-1 downto 0);

begin
MUX1: mux2t1_N port map(i_D0, i_D1, i_I0, s_S1);
MUX2: mux2t1_N port map(i_D2, i_D3, i_I0, s_S2);
MUX3: mux2t1_N port map(s_S1, s_S2, i_I1, o_O);
end structure;
