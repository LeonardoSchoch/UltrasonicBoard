library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;

entity DutyRef is
	 generic(OUTPUT_V: integer := 100;
				SIZE: integer := 8
	 );
    port (
		  	 const_out : out STD_LOGIC_VECTOR (SIZE-1 downto 0)
	 );
end DutyRef;

architecture Behavioral of DutyRef is
begin

	 const_out <= std_logic_vector(to_unsigned(OUTPUT_V, SIZE));
	 
    
end Behavioral;