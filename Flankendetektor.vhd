--****************************Flankendetektor********************************------
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_unsigned.all;

-- ******************Entity for Flankendetektor*************************************************** 
 entity imp_det is 
  port (
        clk : in std_ulogic; -- clock
        SW0 : in std_ulogic; -- Switch_0 as Reset
        SW1 : in std_ulogic;  -- Switch_1 as LEVEL

        start : out std_ulogic; -- output from imp_det 
        stop  : out std_ulogic
		 );                     -- output from imp_det

end imp_det;
--*********************************************************************************************

--*********************Architecture for Flankendetektor***************************************
architecture Flankendetektor of imp_det is
 type state is (ONE,ZERO);
 signal y,x : state;

 begin 

 Process_1 : process(clk,SW0)-- clock , SW0 has Reset

  begin
      if(SW0 ='1') then
       x <= ZERO;
       elsif(rising_edge(clk)) then
       x <= y ;
      end if;
 	   
end process Process_1;

Process_2 : process(x,SW1)  -- signal x , SW1 has LEVEL
 begin
        y <= x;
	stop <= '0';
case (x) is 
     when ZERO =>
                if(SW1 ='1') then -- LEVEL is ONE
                 y <= ONE;
                 start<='1';
                 else 
                 y <= ZERO;
                 end if;
			  
	 when ONE =>
	        if(SW1 ='0') then -- LEVEL is ZERO
         	 y <= ZERO;
	         else
	         y<= ONE;
	        end if;

end case;
end process Process_2;
end Flankendetektor;
	
	





