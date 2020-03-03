LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
ENTITY Tb_clock_divider IS
END Tb_clock_divider;
 
ARCHITECTURE behavior OF Tb_clock_divider IS
 
-- Component Declaration for the Unit Under Test (UUT)
 
COMPONENT Clock_Divider PORT( gclk : IN std_logic; reset : IN std_logic; clk : OUT std_logic); 
END COMPONENT;
 
--Inputs
signal gclk   : std_logic := '0';
signal reset  : std_logic := '0';
 
--Outputs
signal clk : std_logic;
 
-- Clock period definitions
constant clk_period : time := 20 ns;
 
BEGIN
 
-- Instantiate the Unit Under Test (UUT)
u1: Clock_Divider PORT MAP (
gclk => gclk,
reset => reset,
clk => clk
);
 
-- Clock process definitions
clk_process :process
begin
gclk <= '0';
wait for clk_period/2;
gclk <= '1';
wait for clk_period/2;
end process;
 
-- Stimulus process
stim_proc: process
begin
wait for 100 ns;
reset <= '1';
wait for 100 ns;
reset <= '0';
wait;
end process;
 
END;
