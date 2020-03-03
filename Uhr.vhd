--************//// Arunasalam Shidubravin*****************************
--**************** UHR_Steuerung**********************************************
library ieee;
use ieee.std_logic_1164.all;

 -----******---Uhr_Steuerung Entity---*******-------- 
     entity Main_Ctl is
	    port( 
		
	      clk, start, stop          : in std_ulogic;
	      reset, show_int,cnt_en    : out std_ulogic 
                );		 
      end Main_Ctl;

architecture Uhr_Steuerung of Main_Ctl is

  -- Z0 = IDLE, Z1 = RUN, Z2 = Inttime ,Z3 = Hold		
             type state_type is (Z0,Z1,Z2,Z3);
             signal next_state, current_state : state_type;
             signal  warten  : std_ulogic:='0';
	     signal  delay   : natural := 0;
	     signal  i       : std_ulogic;
--******************************************************************
--***********************************************************************
begin
  process(clk,warten)
begin 
i<='0';
if(rising_edge(clk)) then 
      delay <= delay+1;
     if (delay = 50000000) then  --    50Mhz/(0.5Hz*2)   ; 0.5 Hz for 2 sec
     i <= not i;
     delay<= 1;
end if;
end if;
 warten<=i;

end process;	
--***********************************************************************
--**************************************************************			
process_1 : process(clk)
begin 
 if(rising_edge(clk)) then 
     current_state <= next_state;
end if;
end process process_1;
--***********************************************************************
		

 next_state_process: process(current_state,start,stop)
  
begin 
	    case current_state is -- case Anweisung fuer den Zustand
--------------*************------------------
	when Z0 =>   -------IDLE
         if(start='0') then  -- IF Anweisung fuer die Abfrage der Eingangsbelegung 
		 next_state <= Z0;  --IDLE
		 else  next_state <= Z1;    ------RUN 
		 end if; 
-----------------*************----------------	
    when Z1 => -----RUN-----------
        if(stop='0' and start='0') then 
         next_state <= Z1;  -- RUN
		 elsif(stop='0' and start='1') then 
		 next_state <= Z2;  ------Inttime
		 else
		 next_state <= Z3; -------Hold
		 end if; 
---------**********************---------------------
	when Z2 =>   ----------Inttime
         if(warten='0') then 		  --- waiting_time for couple of seconds 
         next_state <= Z1; --RUN		
	end if;
--------***********************-------------------		
     when Z3 =>  --Hold
	     if(stop = '0' and start = '1') then 
         next_state <= Z1; ----RUN-----------
		 elsif(stop='0' and start='0') then 
		  next_state <= Z3; --Hold
		 else
		 next_state <= Z0; --IDLE
		 end if; 
--------************************------------------------------
end case;
end process next_state_process;
-------------------*************--------------------------
output_process : process(current_state,start,stop)
 begin 
    if(current_state = Z0 and start='0') then --- IDLE to IDLE
      reset<='0';show_int<='0';cnt_en<='0';
       elsif(current_state= Z0 and start='1') then  -- IDLE to RUN  
	reset<='0';show_int<='0';cnt_en<='1';
	 elsif(current_state=Z1 and (stop='0' and start='0'))then  -----RUN to RUN
	   reset<='0';show_int<='0';cnt_en<='1';
	     elsif(current_state=Z1 and (stop='0' and start='1')) then -----RUN to Inttime	
	      reset<='0';show_int<='1';cnt_en<='1';
		 elsif(current_state=Z1 and stop='1') then -- RUN to Hold
  	          reset<='0';show_int<='0';cnt_en<='0';
                   elsif(current_state=Z2 and warten='0') then  -- Inttime to RUN  
	             reset<='0';show_int<='0';cnt_en<='1';
		       elsif(current_state=Z3 and (stop='0' and start='1')) then --Hold to RUN
		         reset<='0';show_int<='0';cnt_en<='1';
	                  elsif(current_state=Z3 and (stop='0' and start='0')) then  -- Hold to Hold
	                   reset<='0';show_int<='0';cnt_en<='0';
                            elsif(current_state=Z3 and stop='1') then  -- Hold to IDLE
                             reset<='0';show_int<='0';cnt_en<='1';
       end if;
end process output_process;

--***********************************************************************************
end Uhr_Steuerung;  
			  
                
             		
