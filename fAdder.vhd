--Sam Burrell
--This is my implementation of a full adder based off the schematic in the lab report

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_textio.all;  -- For logic types I/O
library std;
use std.env.all;                -- For hierarchical/external signals
use std.textio.all;             -- For basic I/O

entity fAdder is 

port(i_X, i_Y, i_CN : in std_logic;
o_Cout, o_Sum : out std_logic);
end fAdder;

architecture structure of fAdder is

component andg1
  port(i_A, i_B : in std_logic;
  o_F : out std_logic);
end component;

component andg2
  port(i_A, i_B : in std_logic;
  o_F : out std_logic);
end component;

component xorg1
  port(i_A, i_B : in std_logic;
  o_F : out std_logic);
end component;

component xorg2
  port(i_A, i_B : in std_logic;
  o_F : out std_logic);
end component;

component org2
  port(i_A, i_B : in std_logic;
  o_F : out std_logic);
end component;

signal o_xor1 : std_logic;
signal o_xor2 : std_logic;
signal o_and1 : std_logic;
signal o_and2 : std_logic;


begin

g_andg1: andg2
port MAP(i_B => i_CN,
	i_A => o_xor1,
	o_F => o_and1);

g_andg2: andg2
port MAP(i_B => i_Y,
	i_A => i_X,
	o_F => o_and2);

g_org1: xorg2
port MAP(i_B => i_X,
	i_A => i_Y,
	o_F => o_xor1);


g_org: org2
port MAP(i_B => o_and2,
	i_A => o_and1,
	o_F => o_Cout);


g_xorg2: xorg2
port MAP(i_B => i_CN,
	i_A => o_xor1,
	o_F => o_sum);

end structure;
