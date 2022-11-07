--Sam Burrell
--This is my implementation of an N-Bit adder subtractor

library IEEE;
use IEEE.std_logic_1164.all;

entity addSub is
generic(N : integer := 32);
port(i_a_A, i_b_B : in std_logic_vector(N-1 downto 0);
     nAdd_Sub : in std_logic;
     o_Cry : out std_logic;
     o_Z : out std_logic;
     o_O : out std_logic_vector(N-1 downto 0));
end addSub;

architecture behavior of addSub is 

component onesComp
	generic(N : integer := 32);
	port(i_A : in std_logic_vector(N-1 downto 0);
	    o_F : out std_logic_vector(N-1 downto 0));
end component;

component mux2t1_N
	generic (N : integer := 32);
	port(i_S : in std_logic;
	i_D0, i_D1 : in std_logic_vector(N-1 downto 0);
	o_O : out std_logic_vector(N-1 downto 0));
end component;

component nbit_adder
	generic(N : integer := 32);
	port(i_A : in std_logic_vector(N-1 downto 0);
	    i_B : in std_logic_vector(N-1 downto 0);
	    i_CN : in std_logic;
	    o_Carry : out std_logic;
	    o_S : out std_logic_vector(N-1 downto 0));
end component;

signal s_i : std_logic_vector(N-1 downto 0);
signal s_m : std_logic_vector(N-1 downto 0); 
signal s_O : std_logic_vector(N-1 downto 0);

begin

g_onesComp : onesComp
port map(
	i_A => i_b_B,
	o_F => s_i);

gmux2t1 : mux2t1_N
port map(
	i_S => nAdd_Sub,
	i_D0 => i_b_B,
	i_D1 => s_i,
	o_O => s_m);

g_add0 : nbit_adder
port map(
	i_A => i_a_A,
	i_B => s_m,
	i_CN => '0',
	o_Carry => o_Cry,
	o_S => s_O);

g_add1 : nbit_adder
port map(
	i_A => (others => '0'),
	i_B => s_O,
	i_CN => nAdd_Sub,
	o_Carry => o_Cry,
	o_S => s_O);

end behavior;
