library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity UARTReader_tb is
end entity UARTReader_tb;

architecture Behavioral of UARTReader_tb is

	-- Variable declarations
	constant G_CLKS_PER_BIT : integer := 1;
	
	-- Signal declarations
	signal I_CLK : std_logic := '0';
	signal I_RX_SERIAL : std_logic := '1';
	signal O_RX_DV : std_logic := '0';
	signal O_RX_BYTE : std_logic_vector(7 downto 0) := (others => '0');

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
		
		-- wait to observe outputs
		wait for 500 ns;

		-- end simulation
		wait;
	end process;

end architecture Behavioral;
