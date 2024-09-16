library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity AllChannels_tb is
end entity AllChannels_tb;

architecture Behavioral of AllChannels_tb is
	
	-- Constant declarations
	constant NBLOCKS 	: integer := 256;
	
	-- Signal declarations
	signal CLK8			: std_logic := '0';
	signal COUNTER		: std_logic_vector(7 downto 0) := (others => '0');
	signal SWAP			: std_logic := '0';
	signal PHASE		: std_logic_vector(7 downto 0) := (others => '0');
	signal SET			: std_logic := '0';
	signal ADDRESS		: std_logic_vector(7 downto 0) := (others => '0');
	signal DATA_OUT	: std_logic_vector(31 downto 0) := (others => '0');

	-- Component declaration for the Unit Under Test (UUT)
	component AllChannels
		generic (
			NBLOCKS 	: integer
		);
		port (
			CLK8		: in std_logic;
			CLK		: in std_logic;
			COUNTER	: in std_logic_vector(7 downto 0);
			SWAP		: in std_logic;
			PHASE		: in std_logic_vector(7 downto 0);
			SET		: in std_logic;
			ADDRESS	: in std_logic_vector(7 downto 0);
			DATA_OUT	: out std_logic_vector(31 downto 0)
		);
	end component;

begin

	-- Instantiate the Unit Under Test (UUT)
	uut : AllChannels
		generic map (
			NBLOCKS 	=> NBLOCKS
		)
		port map (
			CLK8		=> CLK8,
			CLK		=> COUNTER(2),
			COUNTER	=> COUNTER,
			SWAP		=> SWAP,
			PHASE		=> PHASE,
			SET		=> SET,
			ADDRESS	=> ADDRESS,
			DATA_OUT	=> DATA_OUT
		);

	-- Clock process
	clk_process : process
	begin
		while true loop
			CLK8 <= '0';
			wait for 50 ns;
			CLK8 <= '1';
			wait for 50 ns;
		end loop;
	end process;
	
	-- Counter process
	counter_process : process
		variable count : integer := 0;
	begin
		if count = 255 then
			count := 0;
		else
			count := count + 1;
		end if;

		-- convert integer count, first to unsigned of length 8, second to std_logic_vector
		COUNTER <= std_logic_vector(to_unsigned(count, 8));
		
		wait for 100 ns;
	end process;

	-- Stimulus process
	stim_process : process
	begin
		wait for 100 ns;
		
		-- set set signal
		SET <= '1';
		wait for 100 ns;
		
		-- for loop iterates through 256 blocks
		for i in 0 to 255 loop
			-- convert integer i, first to unsigned of length 8, second to std_logic_vector
			ADDRESS <= std_logic_vector(to_unsigned(i, 8));
			
			-- convert integer i, first to unsigned of length 7, second to std_logic_vector
			-- concat 0 to front of to fit phase command
			PHASE <= "000" & std_logic_vector(to_unsigned(i, 5));
			
			wait for 100 ns;
		end loop;
		
		-- reset set signal
		-- set swap signal
		SET <= '0';
		SWAP <= '1';
		wait for 100 ns;

		-- wait to observe outputs
		wait for 500 ns;

		-- end simulation
		wait;
	end process;

end architecture Behavioral;
