----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04.11.2019 11:09:38
-- Design Name: 
-- Module Name: CONV_DEC_BIN - Behavioral
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
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity CONV_DEC_BIN_own_fifo is
  port(clk       : in  std_logic;
       reset     : in  std_logic;
       din       : in  std_logic_vector(3 downto 0);
       valid_in  : in  std_logic;
       get       : in  std_logic;
       dout      : out std_logic_vector(31 downto 0);
       valid_out : out std_logic
       );
end CONV_DEC_BIN_own_fifo;

architecture Behavioral of CONV_DEC_BIN_own_fifo is
  -- FIFO IP
  component own_fifo
    port (
      clk  : in std_logic;
      srst : in std_logic;

      din   : in std_logic_vector(3 downto 0);
      wr_en : in std_logic;

      rd_en : in  std_logic;
      dout  : out std_logic_vector(3 downto 0);

      full  : out std_logic;
      empty : out std_logic
      );
  end component;

  signal read_en, getactual : std_logic;
  signal full, empty, siguiente,out_ready   : std_logic;
  signal out_byte      : std_logic_vector (3 downto 0);
  signal digito,anterior: natural range 1000000 downto 0;

  type array_salida is array(0 to 1023) of std_logic_vector (3 downto 0);
  signal array_out : array_salida;
  signal bytes_out : unsigned(31 downto 0);
  signal counter   : integer range 0 to 1023;

begin
  fifo : own_fifo
    port map (
      clk   => clk,
      srst  => reset,
      -- Los datos entran automaticamente
      din   => din,
      wr_en => valid_in,
      -- Hay que guardar cada numero para mostrar todos a la vez
      dout  => out_byte,
      rd_en => read_en,
      -- Signals de control
      full  => full,
      empty => empty
      );

  -- Habilitar la signal de lectura de datos cuando get sea 1
  -- y mientras que el byte leido no sea 'F'
  -- read_en <= '1' when get = '1' else;

  -- Detector de flanco de la signal GET
  process(clk, reset)
  begin
    if reset = '1' then
      read_en <= '0';
      getactual    <= '0';
    elsif rising_edge(clk) then
      getactual <= get;
      if get = '1' and getactual = '0' then
        read_en <= '1';
      elsif out_byte = x"F" then
        read_en <= '0';
      end if;
    end if;
  end process;


  process(reset,clk)
  begin
    if reset = '1' then
        bytes_out <= (others =>'0');
    elsif rising_edge(clk) then
      if read_en = '1' then
        counter            <= counter + 1;
        array_out(counter) <= out_byte;
      end if;
    end if;
  end process;

    process(reset,clk)
    begin
        if reset='1' then
            digito<= 0;
            anterior<= 0;
            siguiente<='0';
            out_ready<='0';            
        elsif rising_edge(clk)then
            if get = '0' and read_en ='1' and siguiente = '0' then
                digito<=to_integer(unsigned(out_byte));
                siguiente<='1';
                out_ready<='0';
            elsif siguiente='1' then
                if out_byte /= x"f" then 
                    digito<=digito*10+to_integer(unsigned(out_byte));
                else 
                siguiente<='0';
                -- digito<=0;
                out_ready<='1';
                end if;
             else
                out_ready<='0';
            end if;
        end if;
    end process;
end Behavioral;
