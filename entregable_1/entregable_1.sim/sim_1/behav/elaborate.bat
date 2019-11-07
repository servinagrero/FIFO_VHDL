@echo off
set xv_path=C:\\AP\\Xilinx\\Vivado\\2016.4\\bin
call %xv_path%/xelab  -wto c2f952a773954a7f8b845273f1597542 -m64 --debug typical --relax --mt 2 -L fifo_generator_v13_1_3 -L xil_defaultlib -L unisims_ver -L unimacro_ver -L secureip -L xpm --snapshot fifo_tb_behav xil_defaultlib.fifo_tb xil_defaultlib.glbl -log elaborate.log
if "%errorlevel%"=="0" goto SUCCESS
if "%errorlevel%"=="1" goto END
:END
exit 1
:SUCCESS
exit 0
