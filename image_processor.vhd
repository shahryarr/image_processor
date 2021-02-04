----------------------------------------------------------------------------------

-- Create Date:    11:08:21 01/28/2021 
-- Design Name: 
-- Module Name:    image_processor - arch
-- Project Name: filter image
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity image_processor is
	generic ( N : integer := 3);
    Port ( clk : in  STD_LOGIC;
			  reset : in STD_LOGIC;
           start : in  STD_LOGIC;
           input : in  STD_LOGIC_VECTOR (7 downto 0);
           row : in  STD_LOGIC_VECTOR (N-1 downto 0);
           column : in  STD_LOGIC_VECTOR (N-1 downto 0);
			  done_tick : out STD_LOGIC;
           output : out  STD_LOGIC_VECTOR (7 downto 0));
end image_processor;
----------------------------------------------------------------------------------
architecture arch of image_processor is

type pixel_type is array (0 to 2**N-1 , 0 to 2**N-1) of unsigned(7 downto 0);

signal pixel : pixel_type := (others => (others => (others => '0' )));

type filtered_type is array (1 to 2**N-2 , 1 to 2**N-2) of unsigned(7 downto 0);

signal filtered : pixel_type := (others => (others => (others => '0' )));

type mask_type  is array (0 to 2 , 0 to 2) of unsigned(7 downto 0);

constant mask : mask_type := (
	(to_unsigned( 0, 8),to_unsigned( 1, 8),to_unsigned( 0, 8)),
	(to_unsigned( 1, 8),to_unsigned( 4, 8),to_unsigned( 1, 8)),
	(to_unsigned( 0, 8),to_unsigned( 1, 8),to_unsigned( 0, 8)));

type state_type is (idle , waite , op , done);

signal state_reg , state_next : state_type;

signal row_reg , row_next : unsigned(N-1 downto 0);
signal column_reg , column_next : unsigned(N-1 downto 0);
signal pos , neg : unsigned(N-1 downto 0);
signal i , j : integer := 1;
----------------------------------------------------------------------------------
begin
	process(clk, reset)
	begin
		if reset = '1' then
			state_reg <= idle;
			row_reg <= (others => '0');
			column_reg <= (others => '0');
		elsif (clk'event and clk = '1') then
			state_reg <= state_next;
			row_reg <= row_next;
			column_reg <= column_next;
			pos <= pixel(i,j)*mask(1,1);
			neg <= pixel(i-1,j)*mask(0,1) + pixel(i,j-1)*mask(1,0) + pixel(i+1,j)*mask(2,1) + pixel(i,j+1)*mask(1,2);
		end if;
	end process;
--------------------------------------------------------------
	process(state_reg , row_reg , column_reg , start , input , pos , neg)
	begin
		done_tick <= '0';
		state_next <= state_reg;
		row_next <= row_reg;
		column_next <= column_reg;
		
		case state_reg is
		---------------------------------------
			when idle =>
				if start = '1' then
					state_next <= waite;
					row_next <= (others => '0');
					column_next <= (others => '0');
					
				end if;
		---------------------------------------
			when waite =>
				pixel(to_integer(row_reg) , to_integer(column_reg)) <= unsigned(input);
				if (column_reg = 2 and row_reg = 2) then
					state_next <= op;
					row_next <= row_reg + 1;
				elsif (row_reg = unsigned(row)-1) then
					row_next <= (others => '0');
					column_next <= column_reg + 1;
				else
					row_next <= row_reg + 1;
				end if;
		---------------------------------------
			when op =>
				pixel(to_integer(row_reg) , to_integer(column_reg)) <= unsigned(input);
				
------------filtered(i,j) <= pixel(i,j)*mask(1,1) - pixel(i-1,j)*mask(0,1) - pixel(i,j-1)*mask(1,0) - pixel(i+1,j)*mask(2,1) - pixel(i,j+1)*mask(1,2);
			
				if (pos < neg) then
					filtered(i,j) <= to_unsigned(0,8);
				elsif ((pos - neg) > 255) then
					filtered(i,j) <= to_unsigned(255,8);
				else
					filtered(i,j) <= pos - neg;
				end if;
				
				if (j = to_integer(unsigned(column)-2) and i = to_integer(unsigned(row)-2)) then
					state_next <= done;
				elsif (i = to_integer(unsigned(row)-2)) then
					i <= 1;
					j <= j+1;
				else
					i <= i+1;
				end if;

				if (column_reg = unsigned(column)-1 and row_reg = unsigned(row)-1) then
					column_next <= (others => '0');
				elsif (row_reg = unsigned(row)-1) then
					row_next <= (others => '0');
					column_next <= column_reg + 1;
				else
					row_next <= row_reg + 1;
				end if;
			
		---------------------------------------		
			when done =>
				done_tick <=  '1';
				state_next <= idle;
				
		end case;
	end process;
--------------------------------------------------------------

output <= std_logic_vector(filtered(i , j));
	
end arch;

