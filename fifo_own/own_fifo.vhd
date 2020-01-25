----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11.11.2019 16:24:59
-- Design Name: 
-- Module Name: own_fifo - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity own_fifo is
    Port (clk  : in std_logic;
      srst : in std_logic;

      din   : in std_logic_vector(3 downto 0);
      wr_en : in std_logic;

      rd_en : in  std_logic;
      dout  : out std_logic_vector(3 downto 0);

      full  : out std_logic;
      empty : out std_logic );
end own_fifo;

architecture Behavioral of own_fifo is
signal pointer_global,pointer_local : integer range 0 to 1024;
type memory_array is array(0 to 1024) of std_logic_vector(3 downto 0);
signal memory: memory_array;
signal enable_wr,enable_rd,reset_pointers: std_logic;


begin

full <= '1' when pointer_global = 1024 else '0';
empty <= '1' when pointer_global = 0 else '0';
enable_wr <= wr_en;
enable_rd <= rd_en;

reset_pointers <= '1' when pointer_local = pointer_global else '0';

process(clk, srst)
begin
    if srst = '1' then
        pointer_global <= 0;
        pointer_local  <= 0;
        memory <= (others =>(others => '0'));
    elsif rising_edge(clk) then
        -- TODO: Comprobar si esta llena
        if enable_wr = '1' then
            memory(pointer_global) <= din;
            if pointer_global < 1024 then
                pointer_global <= pointer_global + 1;
            end if;
            
        elsif enable_rd = '1' then
        
            dout <= memory(pointer_local);
            pointer_local <= pointer_local + 1;
            if reset_pointers = '1' then
                pointer_global <= 0;
                pointer_local  <= 0;
            end if;
                 
        end if;
    end if;
end process;




end Behavioral;
