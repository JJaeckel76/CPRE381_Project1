--Sam Burrell and Justin Jaeckel
--Basic ALU design 

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
entity ALU is 
	generic(N : integer :=32);
	port(i_A	: in std_logic_vector(N-1 downto 0);
	     i_B	: in std_logic_vector(N-1 downto 0);
	     i_Op	: in std_logic_vector(3 downto 0);
	     o_Rslt	: out std_logic_vector(N-1 downto 0);
	     o_Ovf	: out std_logic;
	     o_Carry	: out std_logic;
	     o_Z	: out std_logic);
end ALU;

architecture structure of ALU is
	component addSub is
	generic(N : integer := 32);
	port(i_a_A : in std_logic_vector(N-1 downto 0);
	     i_b_B : in std_logic_vector(N-1 downto 0);
	    nAdd_sub : in std_logic;
	     o_Ov : out std_logic;
	     o_Cry : out std_logic;
	     o_O : out std_logic_vector(N-1 downto 0));
end component;

component xorg2
	port(i_A : in std_logic;
	     i_B : in std_logic;
	     o_F : out std_logic);
end component;

component and32
	generic(N : integer := 32);
	port(i_A : in std_logic_vector(N-1 downto 0);
	     i_B : in std_logic_vector(N-1 downto 0);
	     o_F : out std_logic_vector(N-1 downto 0));
end component;

component xor32
	generic(N : integer := 32);
	port(i_A : in std_logic_vector(N-1 downto 0);
	     i_B : in std_logic_vector(N-1 downto 0);
	     o_F : out std_logic_vector(N-1 downto 0));
end component; 

component or32
	generic(N : integer := 32);
	port(i_A : in std_logic_vector(N-1 downto 0);
	     i_B : in std_logic_vector(N-1 downto 0);
	     o_F : out std_logic_vector(N-1 downto 0));
end component;

component nor32
	generic(N : integer := 32);
	port(i_A : in std_logic_vector(N-1 downto 0);
	     i_B : in std_logic_vector(N-1 downto 0);
	     o_F : out std_logic_vector(N-1 downto 0));
end component;

component BarrellShift
	port(i_I : in std_logic_vector(31 downto 0);
        i_Sel : in std_logic;
        i_Dir : in std_logic; 
	i_Shft : in std_logic_vector(4 downto 0);
	o_Ot : out std_logic_vector(31 downto 0));
end component;

component mux8t1
	generic(N : integer := 32);
	port(i_D0, i_D1, i_D2, i_D3, i_D4, i_D5, i_D6, i_D7  : in std_logic_vector(N-1 downto 0);
	     i_I0, i_I1, i_I2 : in std_logic;
	     o_O : out std_logic_vector(N-1 downto 0));
end component;

signal sAnd, sOr, sXOr, sNor, sBarrell, sAddSub : std_logic_vector(N-1 downto 0);
signal sOv, sXor2 : std_logic;
signal sPAD : std_logic_vector(N-1 downto 0) := x"00000000";

begin
	add_Sub: addSub port map(i_A, i_B, i_OP(3), sOv, o_Carry, sAddSub);
	xor_2 : xorg2 port map(sOv, sAddSub(31), sPAD(0));
	and_32 : and32 port map(i_A, i_B, sAnd);
	or_32 : or32 port map(i_A, i_B, sOR);
	xor_32 : xor32 port map(i_A, i_B, sXOr);
	nor_32 : nor32 port map(i_A, i_B, sNor);
	brShift : BarrellShift port map(i_B, i_Op(3), i_Op(0), i_A(4 downto 0), sBarrell);
	mux : mux8t1 port map(sPAD, sAddSub, sAnd, sOr, sXOr, sNor, sBarrell, sBarrell, i_Op(0), i_Op(1), i_Op(2), o_Rslt);
	o_Ovf <= sOv;
end structure;
