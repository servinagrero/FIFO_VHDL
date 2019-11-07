----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04.11.2019 11:38:58
-- Design Name: 
-- Module Name: fifo_tb - Behavioral
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
use IEEE.STD_LOGIC_1164.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity fifo_tb is
--  Port ( );
end fifo_tb;

architecture Behavioral of fifo_tb is
  component CONV_DEC_BIN
    port (clk       : in  std_logic;
          reset     : in  std_logic;
          din       : in  std_logic_vector(3 downto 0);
          valid_in  : in  std_logic;
          get       : in  std_logic;
          dout      : out std_logic_vector(31 downto 0);
          valid_out : out std_logic
          );
  end component;

  signal clk   : std_logic := '0';
  signal reset : std_logic := '1';

  signal din       : std_logic_vector(3 downto 0);
  signal valid_in  : std_logic;
  signal get       : std_logic := '0';
  signal dout      : std_logic_vector(31 downto 0);
  signal valid_out : std_logic;
begin

  uut : CONV_DEC_BIN port map (clk   => clk,
                               reset => reset,
                               din   => din,
                               valid_in => valid_in,
                               get   => get,
                               dout  => dout,
                               valid_out => valid_out
                               );

  clk   <= not clk after 10 ns;
  reset <= '0'     after 30 ns;

  -- Test inserting numbers
  process
  begin
    wait for 50 ns;
    din      <= x"1";
    valid_in <= '1', '0' after 20 ns;
    wait for 40 ns;

    din      <= x"9";
    valid_in <= '1', '0' after 20 ns;
    wait for 40 ns;

    din      <= x"4";
    valid_in <= '1', '0' after 20 ns;
    wait for 40 ns;

    din      <= x"F";
    valid_in <= '1', '0' after 20 ns;
    
    wait for 45 ns;
    get <= '1', '0' after 30 ns;
    wait;
  end process;
  
end Behavioral;
