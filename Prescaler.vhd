library ieee;
 use ieee.std_logic_1164.all;
 use ieee.std_logic_unsigned.all;
 
 entity prescal is
   port(
    gclk: in std_logic;
    clk: out std_logic
   );
 end prescal;
 
 architecture A1 of prescal is
 signal tmp_clk: std_logic;
 begin
  prescaler: process (gclk)
  variable prescaler_val: integer range 32 downto 0;
  begin
   if (rising_edge(gclk)) then
    prescaler_val:=prescaler_val+1;
    if (prescaler_val=32) then
     tmp_clk<=not tmp_clk;
     clk<=tmp_clk;
     prescaler_val:=0;
    end if;
   end if;
  end process;
 end A1;