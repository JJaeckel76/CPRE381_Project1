--Sam Burrell
--Cyber Security Engineering
--Iowa State University

--This file is my implementation of a 2:1 multiplexer

library IEEE;
use IEEE.std_logic_1164.all;

entity mux2t1 is
port( i_S                  : in std_logic;
      i_D0                 : in std_logic;
      i_D1                 : in std_logic;
      o_O                  : out std_logic);
end mux2t1;

architecture structure of mux2t1 is

component org2 

  port(i_A          : in std_logic;
       i_B          : in std_logic;
       o_F          : out std_logic);
end component;

component invg

  port(i_A          : in std_logic;
       o_F          : out std_logic);

end component;

component andg2 

  port(i_A          : in std_logic;
       i_B          : in std_logic;
       o_F          : out std_logic);

end component;

signal s_I : std_logic;

signal s_a1 : std_logic;

signal s_a2 : std_logic;

begin

g_And1: andg2
port MAP(i_B => i_S,
	i_A => i_D1,
	o_F => s_a2);

g_not: invg
port MAP(i_A    =>i_S,
	o_F    => s_I);

g_And2: andg2
port MAP(i_A  => i_D0,
	i_B   => s_I,
	o_F   => s_a1);

g_Or2: org2
port MAP(i_A   => s_a1,
	i_B   => s_a2,
	o_F   => o_O);

end structure;