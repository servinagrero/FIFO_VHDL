@echo off
set xv_path=C:\\AP\\Xilinx\\Vivado\\2016.4\\bin
call %xv_path%/xsim fifo_tb_behav -key {Behavioral:sim_1:Functional:fifo_tb} -tclbatch fifo_tb.tcl -view C:/Users/l0331119/Downloads/fifo_biblioteca/entregable_1/fifo_tb_behav.wcfg -log simulate.log
if "%errorlevel%"=="0" goto SUCCESS
if "%errorlevel%"=="1" goto END
:END
exit 1
:SUCCESS
exit 0
