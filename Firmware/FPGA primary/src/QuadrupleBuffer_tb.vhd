library ieee;
use ieee.std_logic_1164.all;

entity QuadrupleBuffer_tb is
end entity QuadrupleBuffer_tb;

architecture Behavior of QuadrupleBuffer_tb is
	
	-- Signal declarations
	signal CLK				: std_logic;
	signal MISC_B			: std_logic;
	signal MISC_D			: std_logic;
	signal MISC_E			: std_logic;
	signal DATA				: std_logic_vector(31 downto 0);
	signal LED				: std_logic_vector(3 downto 0);
	signal SHIFT_CLOCK_1	: std_logic;
	signal SHIFT_CLOCK_2	: std_logic;
	signal LATCH_CLOCK_1	: std_logic;
	signal LATCH_CLOCK_2	: std_logic;

	-- Component declaration for the Unit Under Test (UUT)
	component QuadrupleBuffer
		port (
			CLK            : in  std_logic;
			MISC_B         : in  std_logic;
			MISC_D         : out std_logic;
			MISC_E         : out std_logic;
			DATA           : out std_logic_vector(31 downto 0);
			LED            : out std_logic_vector(3 downto 0);
			SHIFT_CLOCK_1  : out std_logic;
			SHIFT_CLOCK_2  : out std_logic;
			LATCH_CLOCK_1  : out std_logic;
			LATCH_CLOCK_2  : out std_logic
        );
    end component;

begin

	-- Instantiate the Unit Under Test (UUT)
	uut: QuadrupleBuffer
		port map (
			CLK				=> CLK,
			MISC_B			=> MISC_B,
			MISC_D			=> MISC_D,
			MISC_E			=> MISC_E,
			DATA				=> DATA,
			LED				=> LED,
			SHIFT_CLOCK_1	=> SHIFT_CLOCK_1,
			SHIFT_CLOCK_2	=> SHIFT_CLOCK_2,
			LATCH_CLOCK_1	=> LATCH_CLOCK_1,
			LATCH_CLOCK_2	=> LATCH_CLOCK_2
        );

	-- Clock process
	clk_process : process
	begin
		while true loop
			CLK <= '0';
			wait for 10 ns;
			CLK <= '1';
			wait for 10 ns;
		end loop;
	end process;

	-- Stimulus process
	stim_process : process
	begin

		-- End simulation
		wait;
	end process;

end architecture Behavior;
