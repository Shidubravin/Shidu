-- ****TEST Bench for Stopuhr_Steuerung--------------------
--**********// Shidubravin Arunasalam------------------- 
library ieee;
use ieee.std_logic_1164.all;

 entity test_bench_Uhr_Steuerung is   -- Test Bench for Stopuhr_Steuerung 
 end test_bench_Uhr_Steuerung;

architecture waveforms of test_bench_Uhr_Steuerung is 
  signal T_clk         : std_ulogic  := '1';    --Eingang
  signal T_start       : std_ulogic  := '1';    -- Eingang
  signal T_stop        : std_ulogic  := '0';    -- Eingang
  signal T_reset       : std_ulogic  := '0';    -- Ausgang
  signal T_show_int    : std_ulogic  := '0';    -- Ausgang
  signal T_cnt_en      : std_ulogic  := '0';    --Ausgang
 
component Main_Ctl 
  port ( 
         clk, start, stop             : in  std_ulogic;
         reset, show_int, cnt_en      : out  std_ulogic   );
  
end component;

begin 
  Main_Ctl_inst: Main_Ctl port map(T_clk, T_start, T_stop, T_reset, T_show_int, T_cnt_en);
  process 

begin 
   T_clk <= '1'; -- clock cycle 20ns
    wait for 10ns;
    T_clk <= '0';
    wait for 10ns;
end process;

   T_start <= '0',
              '1' after 100 ns,
              '0' after 120 ns,
              '1' after 140 ns,
              '0' after 180 ns,
              '1' after 200 ns,
              '0' after 220 ns,
              '1' after 260 ns;
              

    T_stop <= '0',
              '1' after 160 ns,
              '0' after 200 ns,
              '1' after 220 ns,
              '0' after 240 ns,
              '1' after 260 ns,
              '0' after 590 ns;

finish_sim_time: process
  begin
    wait for 700 ns;
    assert false
      report "simulation finished"
      severity failure;
  end process finish_sim_time;

end waveforms;


configuration Uhr_Steuerung of test_bench_Uhr_Steuerung is
  for waveforms  -- test_bench architecture 
     for Main_Ctl_inst: Main_Ctl   -- DUT instance 
         use entity work.Main_Ctl(Uhr_Steuerung);
    end for;
 end for;
end Uhr_Steuerung; 


