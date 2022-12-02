library IEEE;
use IEEE.std_logic_1164.all;

entity mipRegister is 
    port (
        i_Clock : in std_logic;
        i_Reset : in std_logic;
        i_WriteEnable : in std_logic;
        i_Data : in std_logic_vector(31 downto 0);
        write_select : in std_logic_vector(4 downto 0);
        read1_select : in std_logic_vector(4 downto 0);
        read2_select : in std_logic_vector(4 downto 0);
        readPort1 : out std_logic_vector(31 downto 0);
        readPort2 : out std_logic_vector(31 downto 0));

end mipRegister;

architecture structural of mipRegister is
    component dffg_N is 
        generic (N : integer := 32);
        port (
            i_Clock : in std_logic;
            i_Reset : in std_logic;
            i_WriteEnable : in std_logic;
            i_Data : in std_logic_vector;
            o_Data : out std_logic_vector);
    end component;

    component thirtyTwoBitMux is 
        port (
            data_input0 : in std_logic_vector;
            data_input1 : in std_logic_vector;
            data_input2 : in std_logic_vector;
            data_input3 : in std_logic_vector;
            data_input4 : in std_logic_vector;
            data_input5 : in std_logic_vector;
            data_input6 : in std_logic_vector;
            data_input7 : in std_logic_vector;
            data_input8 : in std_logic_vector;
            data_input9 : in std_logic_vector;
            data_input10 : in std_logic_vector;
            data_input11 : in std_logic_vector;
            data_input12 : in std_logic_vector;
            data_input13 : in std_logic_vector;
            data_input14 : in std_logic_vector;
            data_input15 : in std_logic_vector;
            data_input16 : in std_logic_vector;
            data_input17 : in std_logic_vector;
            data_input18 : in std_logic_vector;
            data_input19 : in std_logic_vector;
            data_input20 : in std_logic_vector;
            data_input21 : in std_logic_vector;
            data_input22 : in std_logic_vector;
            data_input23 : in std_logic_vector;
            data_input24 : in std_logic_vector;
            data_input25 : in std_logic_vector;
            data_input26 : in std_logic_vector;
            data_input27 : in std_logic_vector;
            data_input28 : in std_logic_vector;
            data_input29 : in std_logic_vector;
            data_input30 : in std_logic_vector;
            data_input31 : in std_logic_vector;
            EN : in std_logic;
            i_SEL : in std_logic_vector(4 downto 0);
            data_output : out std_logic_vector);
    end component;

    component fiveToThirtyTwoDecoder is 
        port (
            data_input : in std_logic_vector;
            EN : in std_logic;
            data_output : out std_logic_vector);
    end component;

    signal select_vector : std_logic_vector(31 downto 0) := "00000000000000000000000000000000";
    -- Create an array of the vectors to act as signal wires programatically
    type vector32 is array (natural range <>) of std_logic_vector(31 downto 0);
    -- Create an array of size 32 of 32 bit vectors
    signal registerVector : vector32 (0 to 31);

begin
    -- Use the decoder to enable write enable on the right register
    DECODER : fiveToThirtyTwoDecoder
        port map(
            data_input => write_select,
            EN => i_WriteEnable,
            data_output => select_vector);
    
    -- Create a register bank
    REGISTER0 : dffg_N
        generic map(32)
        port map(
            i_Clock => i_Clock,
            i_Reset => '1',
            i_WriteEnable => select_vector(0),
            i_Data => i_Data,
            o_Data => registerVector(0));  
    REGISTER_BANK : for i in 1 to 31 generate
        REGISTERI : dffg_N generic map(32)
            port map(
                i_Clock => i_Clock,
                i_Reset => i_Reset,
                i_WriteEnable => select_vector(i),
                i_Data => i_Data,
                o_Data => registerVector(i));
    end generate REGISTER_BANK;
    -- Create the read ports

    firstReadPort : thirtyTwoBitMux
        port map(
            i_SEL => read1_select,
            EN => '1',
            data_output => readPort1,
            data_input0 => registerVector(0),
            data_input1 => registerVector(1),
            data_input2 => registerVector(2),
            data_input3 => registerVector(3),
            data_input4 => registerVector(4),
            data_input5 => registerVector(5),
            data_input6 => registerVector(6),
            data_input7 => registerVector(7),
            data_input8 => registerVector(8),
            data_input9 => registerVector(9),
            data_input10 => registerVector(10),
            data_input11 => registerVector(11),
            data_input12 => registerVector(12),
            data_input13 => registerVector(13),
            data_input14 => registerVector(14),
            data_input15 => registerVector(15),
            data_input16 => registerVector(16),
            data_input17 => registerVector(17),
            data_input18 => registerVector(18),
            data_input19 => registerVector(19),
            data_input20 => registerVector(20),
            data_input21 => registerVector(21),
            data_input22 => registerVector(22),
            data_input23 => registerVector(23),
            data_input24 => registerVector(24),
            data_input25 => registerVector(25),
            data_input26 => registerVector(26),
            data_input27 => registerVector(27),
            data_input28 => registerVector(28),
            data_input29 => registerVector(29),
            data_input30 => registerVector(30),
            data_input31 => registerVector(31));
    
    secondReadPort : thirtyTwoBitMux
        port map(
            i_SEL => read2_select,
            EN => '1',
            data_output => readPort2,
            data_input0 => registerVector(0),
            data_input1 => registerVector(1),
            data_input2 => registerVector(2),
            data_input3 => registerVector(3),
            data_input4 => registerVector(4),
            data_input5 => registerVector(5),
            data_input6 => registerVector(6),
            data_input7 => registerVector(7),
            data_input8 => registerVector(8),
            data_input9 => registerVector(9),
            data_input10 => registerVector(10),
            data_input11 => registerVector(11),
            data_input12 => registerVector(12),
            data_input13 => registerVector(13),
            data_input14 => registerVector(14),
            data_input15 => registerVector(15),
            data_input16 => registerVector(16),
            data_input17 => registerVector(17),
            data_input18 => registerVector(18),
            data_input19 => registerVector(19),
            data_input20 => registerVector(20),
            data_input21 => registerVector(21),
            data_input22 => registerVector(22),
            data_input23 => registerVector(23),
            data_input24 => registerVector(24),
            data_input25 => registerVector(25),
            data_input26 => registerVector(26),
            data_input27 => registerVector(27),
            data_input28 => registerVector(28),
            data_input29 => registerVector(29),
            data_input30 => registerVector(30),
            data_input31 => registerVector(31));

end structural;