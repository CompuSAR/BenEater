#set_property PACKAGE_PIN N10 [get_ports serial_tx]
#set_property IOSTANDARD LVCMOS33 [get_ports serial_tx]
# Incorrect value 5v0 so we can drive the EEPROM. The CP2102 can handle it, however
#set_property IOSTANDARD LVTTL [get_ports serial_tx]

#set_property PACKAGE_PIN P10 [get_ports serial_rx]
#set_property IOSTANDARD LVCMOS33 [get_ports serial_rx]

#set_property PACKAGE_PIN E11 [get_ports led2]
#set_property IOSTANDARD LVCMOS33 [get_ports led2]
#set_property PACKAGE_PIN M10 [get_ports led3]
#set_property IOSTANDARD LVCMOS33 [get_ports led3]

set_property PACKAGE_PIN F4 [get_ports nReset]
set_property IOSTANDARD LVCMOS15 [get_ports nReset]

set_property PACKAGE_PIN K11 [get_ports port_a[0]]
set_property PACKAGE_PIN L12 [get_ports port_a[1]]
set_property PACKAGE_PIN M13 [get_ports port_a[2]]
#set_property PACKAGE_PIN J13 [get_ports port_a[2]]
set_property PACKAGE_PIN L14 [get_ports port_a[3]]
set_property PACKAGE_PIN L13 [get_ports port_a[4]]
set_property PACKAGE_PIN K12 [get_ports port_a[5]]
set_property PACKAGE_PIN J14 [get_ports port_a[6]]
set_property PACKAGE_PIN F11 [get_ports port_a[7]]

set_property PACKAGE_PIN F14 [get_ports port_b[0]]
set_property PACKAGE_PIN E13 [get_ports port_b[1]]
set_property PACKAGE_PIN E12 [get_ports port_b[2]]
set_property PACKAGE_PIN D13 [get_ports port_b[3]]
set_property PACKAGE_PIN C14 [get_ports port_b[4]]
set_property PACKAGE_PIN B14 [get_ports port_b[5]]
set_property PACKAGE_PIN A13 [get_ports port_b[6]]
set_property PACKAGE_PIN A10 [get_ports port_b[7]]
set_property IOSTANDARD LVTTL [get_ports port_*]



set_property PACKAGE_PIN H13 [get_ports clock50Mhz]
set_property IOSTANDARD LVCMOS33 [get_ports clock50Mhz]
create_clock -period 20.000 -name sysClk -waveform  {0.000 10.000} [get_ports clock50Mhz]

set_property BITSTREAM.CONFIG.SPI_BUSWIDTH 4 [current_design]
set_property CONFIG_VOLTAGE 3.3 [current_design]
set_property CFGBVS VCCO [current_design]