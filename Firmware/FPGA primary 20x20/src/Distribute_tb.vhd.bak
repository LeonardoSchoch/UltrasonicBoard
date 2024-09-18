library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity Distribute_tb is
end entity Distribute_tb;

architecture Behavioral of Distribute_tb is
	
	-- Signal declarations
	signal CLK							: std_logic := '0';
	signal BYTE_IN        			: std_logic := '0';
	signal Q_IN							: std_logic_vector(7 downto 0) := (others => '0');
			
	signal SWAP_OUT					: std_logic := '0';
	signal SET_OUT						: std_logic := '0';
	signal MULTIPLEX_OUT				: std_logic := '0';
	signal DATA_OUT					: std_logic_vector (7 downto 0) := (others => '0'); 
	signal ADDRESS						: std_logic_vector(7 downto 0) := (others => '0');
	signal DEBUG_SWAP					: std_logic := '0';
	signal DEBUG_RESET				: std_logic := '0';
	signal DEBUG_ONSHIFTCLOCKS 	: std_logic := '0';

	-- Component declaration for the Unit Under Test (UUT)
	component Distribute
		port (
			CLK            			: in std_logic;
			BYTE_IN        			: in std_logic;
			Q_IN							: in std_logic_vector(7 downto 0);
			
			SWAP_OUT						: out std_logic;
			SET_OUT						: out std_logic;
			MULTIPLEX_OUT				: out std_logic;
			DATA_OUT						: out std_logic_vector (7 downto 0); 
			ADDRESS						: out std_logic_vector(7 downto 0);
			DEBUG_SWAP					: out std_logic;
			DEBUG_RESET					: out std_logic;
		   DEBUG_ONSHIFTCLOCKS 	: out std_logic
		);
	end component;

begin

	-- Instantiate the Unit Under Test (UUT)
	uut : Distribute
		port map (
			CLK							=> CLK,
			BYTE_IN						=> BYTE_IN,
			Q_IN							=> Q_IN,
			SWAP_OUT						=> SWAP_OUT,
			SET_OUT						=> SET_OUT,
			MULTIPLEX_OUT				=> MULTIPLEX_OUT,
			DATA_OUT						=> DATA_OUT,
			ADDRESS						=> ADDRESS,
			DEBUG_SWAP					=> DEBUG_SWAP,
			DEBUG_RESET					=> DEBUG_RESET,
			DEBUG_ONSHIFTCLOCKS	=> DEBUG_ONSHIFTCLOCKS
        );

	-- Clock process
	clk_process : process
	begin
		while true loop
			CLK <= '0';
			wait for 50 ns;
			CLK <= '1';
			wait for 50 ns;
		end loop;
	end process;
	

	-- Stimulus process
	stim_process : process
	begin
	
		wait for 100 ns;
		
		-- send start receiving phases command
		BYTE_IN <= '1';
		Q_IN <= "11111110";
		wait for 100 ns;
		
		-- for loop iterates through
		-- BYTE_IN <= '1';
		for i in 0 to 255 loop
			-- convert integer i, first to unsigned of length 7, second to std_logic_vector
			-- concat 0 to front of to fit phase command
			Q_IN <= '0' & std_logic_vector(to_unsigned(i, 7));
			wait for 100 ns;
		end loop;
	
		-- send swap buffer command
		-- BYTE_IN <= '1';
		Q_IN <= "11111101";

		-- wait to observe outputs
		wait for 500 ns;

		-- end simulation
		wait;
	end process;

end architecture Behavioral;
