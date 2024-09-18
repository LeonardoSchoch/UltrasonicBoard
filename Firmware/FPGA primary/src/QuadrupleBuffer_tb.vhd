library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity QuadrupleBuffer_tb is
end entity QuadrupleBuffer_tb;

architecture Behavior of QuadrupleBuffer_tb is
	
	-- Signal declarations
	signal CLK				: std_logic := '0';
	signal MISC_B			: std_logic := '0';
	signal MISC_D			: std_logic := '0';
	signal MISC_E			: std_logic := '0';
	signal DATA				: std_logic_vector(31 downto 0) := (others => '0');
	signal LED				: std_logic_vector(3 downto 0) := (others => '0');
	signal SHIFT_CLOCK_1	: std_logic := '0';
	signal SHIFT_CLOCK_2	: std_logic := '0';
	signal LATCH_CLOCK_1	: std_logic := '0';
	signal LATCH_CLOCK_2	: std_logic := '0';
	
	-- UART stimulus procedure
	-- sends 1 start bit, 1 data byte and 1 stop bit
	procedure UartStimulus (
		 constant DATA_BYTE : in  std_logic_vector(7 downto 0);
		 signal UART_PIN : out std_logic
	) is
	begin
		UART_PIN <= '0'; -- start
		wait for 4400 ns;
			
		for i in 0 to 7 loop
			UART_PIN <= DATA_BYTE(i);
			wait for 4400 ns;
		end loop;

		UART_PIN <= '1'; -- stop
		wait for 4400 ns;
	end procedure;

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
		variable PHASE : std_logic_vector(7 downto 0) := (others => '0');
	begin
	
		wait for 100 ns;
		
		-- send start receiving phases command
		UartStimulus("11111110", MISC_B);
		
		-- for loop iterates through 256 phases
		for i in 0 to 255 loop
		
			PHASE := "000" & std_logic_vector(to_unsigned(i, 5));
			
			-- send set phase command
			UartStimulus(PHASE, MISC_B);
			wait for 100 ns;
		end loop;
		
		-- send swap buffers command
		UartStimulus("11111101", MISC_B);
		
		-- wait to observe outputs
		wait for 5000 ns;

		-- end simulation
		wait;
	end process;

end architecture Behavior;
