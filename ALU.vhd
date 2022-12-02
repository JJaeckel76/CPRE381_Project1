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
	add_Sub: addSub port map(i_a_A => i_A, i_b_B => i_B, nAdd_Sub => i_OP(3), o_Ov => sOv, o_Cry => o_Carry, o_O => sAddSub);
	xor_2 : xorg2 port map(i_A => sOv, i_B => sAddSub(31), o_F => sPAD(0));
	and_32 : and32 port map(i_A => i_A, i_B => i_B, o_F => sAnd);
	or_32 : or32 port map(i_A => i_A, i_B => i_B, o_F => sOR);
	xor_32 : xor32 port map(i_A => i_A, i_B => i_B, o_F => sXOr);
	nor_32 : nor32 port map(i_A => i_A, i_B => i_B, o_F => sNor);
	brShift : BarrellShift port map(i_I => i_B,i_Sel => i_Op(3), i_Dir => i_Op(0),i_Shft => i_A(4 downto 0), o_Ot => sBarrell);
	mux : mux8t1 port map(i_D0 => sPAD, i_D1 => sAddSub, i_D2 => sAnd, i_D3 => sOr, i_D4 => sXOr, i_D5 => sNor, i_D6 => sBarrell, i_D7 => sBarrell, i_I0 => i_Op(0), i_I1 => i_Op(1), i_I2 => i_Op(2), o_O => o_Rslt);
	o_Ovf <= sOv;
end structure;
