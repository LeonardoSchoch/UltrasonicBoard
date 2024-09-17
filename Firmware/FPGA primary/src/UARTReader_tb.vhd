library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity UARTReader_tb is
end entity UARTReader_tb;

architecture Behavioral of UARTReader_tb is

	-- Constant declarations
	constant G_CLKS_PER_BIT : integer := 1;
	
	-- Signal declarations
	signal I_CLK			: std_logic := '0';
	signal I_RX_SERIAL	: std_logic := '1';
	signal O_RX_DV			: std_logic := '0';
	signal O_RX_BYTE		: std_logic_vector(7 downto 0) := (others => '0');

	-- UART stimulus procedure
	-- sends 1 start bit, 1 data byte and 1 stop bit
	procedure UartStimulus (
		 constant DATA_BYTE : in  std_logic_vector(7 downto 0);
		 signal UART_PIN : out std_logic
	) is
	begin
		UART_PIN <= '0'; -- start
		wait for 100 ns;
			
		for i in 7 downto 0 loop
			UART_PIN <= DATA_BYTE(i);
			wait for 100 ns;
		end loop;

		UART_PIN <= '1'; -- stop
		wait for 100 ns;
	end procedure;

	-- Component declaration for the Unit Under Test (UUT)
	component UARTReader
		generic (
			G_CLKS_PER_BIT : integer
		);
		port (
			I_CLK       : in  std_logic;
			I_RX_SERIAL : in  std_logic;
			O_RX_DV     : out std_logic;
			O_RX_BYTE   : out std_logic_vector(7 downto 0)
		);
	end component;

begin

	-- Instantiate the Unit Under Test (UUT)
	uut : UARTReader
		generic map(
			G_CLKS_PER_BIT => G_CLKS_PER_BIT
		)
		port map(
			I_CLK			=> I_CLK,
			I_RX_SERIAL => I_RX_SERIAL,
			O_RX_DV		=> O_RX_DV,
			O_RX_BYTE	=> O_RX_BYTE
		);

	-- Clock process
	clk_process : process
	begin
		while true loop
			I_CLK <= '0';
			wait for 50 ns;
			I_CLK <= '1';
			wait for 50 ns;
		end loop;
	end process;
	

	-- Stimulus process
	stim_process : process
	begin
	
		wait for 100 ns;
		
		-- send start bit + data byte + stop bit
		I_RX_SERIAL <= '0'; -- start
		wait for 100 ns;
		
		-- swap buffers command
		I_RX_SERIAL <= '1';
		wait for 100 ns;
		I_RX_SERIAL <= '1';
		wait for 100 ns;
		I_RX_SERIAL <= '1';
		wait for 100 ns;
		I_RX_SERIAL <= '1';
		wait for 100 ns;
		I_RX_SERIAL <= '1';
		wait for 100 ns;
		I_RX_SERIAL <= '1';
		wait for 100 ns;
		I_RX_SERIAL <= '0';
		wait for 100 ns;
		I_RX_SERIAL <= '1';
		wait for 100 ns;
		
		I_RX_SERIAL <= '1'; -- stop
		wait for 100 ns;
		
		-- wait between data bytes
		wait for 100 ns;
		
		-- send start sequence
		UartStimulus("11111110", I_RX_SERIAL);
		
		-- wait to observe outputs
		wait for 500 ns;

		-- end simulation
		wait;
	end process;

end architecture Behavioral;
