transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vcom -93 -work work {/home/andressa/Programas/altera/13.1/Projetos/multicicloMIPSFPGA/ulaMIPS.vhd}
vcom -93 -work work {/home/andressa/Programas/altera/13.1/Projetos/multicicloMIPSFPGA/operativaMIPSpkg.vhd}
vcom -93 -work work {/home/andressa/Programas/altera/13.1/Projetos/multicicloMIPSFPGA/multicicloMIPSpkg.vhd}
vcom -93 -work work {/home/andressa/Programas/altera/13.1/Projetos/multicicloMIPSFPGA/memoriaMIPS.vhd}
vcom -93 -work work {/home/andressa/Programas/altera/13.1/Projetos/multicicloMIPSFPGA/controleMIPS.vhd}
vcom -93 -work work {/home/andressa/Programas/altera/13.1/Projetos/multicicloMIPSFPGA/bregMIPS.vhd}
vcom -93 -work work {/home/andressa/Programas/altera/13.1/Projetos/multicicloMIPSFPGA/multicicloMIPSFPGA.vhd}
vcom -93 -work work {/home/andressa/Programas/altera/13.1/Projetos/multicicloMIPSFPGA/seteSegm.vhd}
vcom -93 -work work {/home/andressa/Programas/altera/13.1/Projetos/multicicloMIPSFPGA/operativaMIPS.vhd}
vcom -93 -work work {/home/andressa/Programas/altera/13.1/Projetos/multicicloMIPSFPGA/multicicloMIPS.vhd}

vcom -93 -work work {/home/andressa/Programas/altera/13.1/Projetos/multicicloMIPSFPGA/testbench_multiciclo.vhd}

vsim -t 1ps -L altera -L lpm -L sgate -L altera_mf -L altera_lnsim -L cycloneii -L rtl_work -L work -voptargs="+acc"  testbench_multiciclo

add wave *
view structure
view signals
run -all
