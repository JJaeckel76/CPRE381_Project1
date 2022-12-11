

library IEEE;
use IEEE.std_logic_1164.all;

entity addSub_N is
  generic (N : integer := 16); -- Generic of type integer for input/output data width. Default value is 32.
  port (
    i_SA : in std_logic_vector(N - 1 downto 0);
    i_SB : in std_logic_vector(N - 1 downto 0);
    i_Immediate : in std_logic_vector(N - 1 downto 0); 
    nAdd_Sub : in std_logic;
    ALUSrc : in std_logic;
    o_Sum : out std_logic_vector(N - 1 downto 0)
  );

end addSub_N;

architecture structural of addSub_N is

  component fullAdder_N is
    generic (N : integer := 32);
    port (
      i_SA : in std_logic_vector;
      i_SB : in std_logic_vector;
      i_Carry : in std_logic;
      o_Sum : out std_logic_vector;
      o_Carry : out std_logic);
  end component;

  component invg_N is
    generic (N : integer := 32);
    port (
        i_A : in std_logic_vector;
        o_F : out std_logic_vector);
  end component;

  component mux2t1_N is
    generic (N : integer := 32);
    port (
        i_D0 : in std_logic_vector;
        i_D1 : in std_logic_vector;
        i_S : in std_logic;
        o_O : out std_logic_vector);
    end component;
  
  signal invert_select_switch : std_logic_vector(N - 1 downto 0);
  signal carry_vector : std_logic_vector(N - 1 downto 0);
  signal inverted_vector : std_logic_vector(N - 1 downto 0);
  signal muxed_vector : std_logic_vector(N - 1 downto 0);
begin

    -- Mux the B and the immedatte
    initial_muxing : mux2t1_N
    generic map(N)
    port map(
        i_D0 => i_SB,
        i_D1 => i_Immediate,
        i_S => ALUSrc,
        o_O => invert_select_switch
    );

    -- Mux the values
    muxing : mux2t1_N
    generic map(N)
    port map(
        i_D0 => invert_select_switch,
        i_D1 => inverted_vector,
        i_S => nAdd_Sub,
        o_O => muxed_vector
    );

    -- Invert the muxed value from the previous piece
    inverter : invg_N
    generic map(N)
    port map(
        i_A => invert_select_switch,
        o_F => inverted_vector
    );

    -- Do the addition
    adding : fullAdder_N
    generic map(N)
    port map(
        i_SA => i_SA,
        i_SB => muxed_vector,
        i_Carry => nAdd_Sub,
        o_Sum => o_Sum,
        o_Carry => open
    );

end structural;