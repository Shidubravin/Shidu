library ieee;
use ieee.std_logic_1164.all;

 entity Testbench_Flankendetektor is   -- Test Bench for Flankendetektor 
 end Testbench_Flankendetektor;

architecture flanken_stimulus of Testbench_Flankendetektor is 
  signal T_clk    : std_ulogic  := '0';  -- Eingang
  signal T_SW0    : std_ulogic  := '0';  -- Eingang
  signal T_SW1    : std_ulogic  := '0';  -- Eingang
  signal T_start  : std_ulogic  := '1'; -- Ausgang
  signal T_stop   : std_ulogic  := '0';  -- Ausgang
  --signal T_x      : std_ulogic  := '0';
--  signal T_y      : std_ulogic  := '0';
 
component imp_det 
  port ( 
         clk, SW0, SW1       : in  std_ulogic;
         start, stop         : out  std_ulogic   );
  
end component;

begin 
  imp_det_inst: imp_det port map(T_clk, T_SW0, T_SW1, T_start, T_stop);
  clock_generator : process 

begin 
   T_clk <= '1'; -- clock cycle 40ns
    wait for 20ns;
    T_clk <= '0';
    wait for 20ns;
	
end process clock_generator;
   -------Stimulus Process---------------
  T_SW0 <=  '1',
            '0' after 20 ns;
   T_SW1 <= '1',
            '0' after 40 ns;
  
end flanken_stimulus;

configuration Flankendetektor of Testbench_Flankendetektor is
  for flanken_stimulus  -- test_bench architecture 
     for imp_det_inst: imp_det   -- DUT instance 
         use entity work.imp_det(Flankendetektor);
    end for;
 end for;
end Flankendetektor; 



