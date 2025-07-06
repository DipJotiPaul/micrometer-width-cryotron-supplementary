import sys
import os

sys.path.append('Q:\qnnpy')

import numpy as np
from matplotlib import pyplot as plt
from time import sleep
from qnnpy.instruments.cryocon34 import Cryocon34
from qnnpy.instruments.yokogawa_gs200 import YokogawaGS200
from qnnpy.instruments.keithley_2700 import Keithley2700
from qnnpy.instruments.keithley_2400 import Keithley2400
from qnnpy.instruments.keithley_2450 import Keithley2450
from qnnpy.functions.save_data_vs_param import *
from qnnpy.instruments.keithley_2001 import Keithley2001
from qnnpy.instruments.srs_sim928 import SIM928

#########################################
### Connect to instruments
#########################################
temp = Cryocon34("GPIB0::5")
# srs_keith2 = Keithley2400("GPIB0::14::INSTR");      srs_keith2.reset()      # Drain bias
# srs_keith2 = Keithley2450("USB0::0x05E6::0x2450::04508264::0::INSTR");         srs_keith2.reset()
yoko = YokogawaGS200("GPIB0::20");              yoko.reset()
dmm_keith2 = Keithley2700("GPIB0::18::INSTR");     dmm_keith2.reset()      # Drain dmm
srs_keith1 = Keithley2400("GPIB0::23::INSTR");     srs_keith1.reset()      # Gate bias (F4)
dmm_keith1 = Keithley2700("GPIB0::3::INSTR");      dmm_keith1.reset()      # Gate dmm (F4)



srs_keith1.set_compliance_i(15e-3)
srs_keith1.set_compliance_v(50)
# srs_keith2.set_compliance_i(15e-3)
# srs_keith2.set_compliance_v(50)

#%%
#########################################
### Sample information
#########################################
sample_name = 'wTron-sample2'
device_name = 'wTron-2um-8um'
comments = 'IV-meas-F6-F7'
test_name = sample_name+'_'+device_name+'_'+comments
filedirectry = r'S:\SC\Personal\DJ\wTron_sample2\Fig3b_cooldown2'
meas_interval = 0.1
step1 = 10e-6
step2 = 10e-6

Rg_srs = 10e3
Ig_max = 1500e-6
Ig_source = np.arange(0, Ig_max, step1)
Vg_source = Ig_source*Rg_srs

Rd_srs = 1e3
Id_max = 3000e-6
Id_source = np.arange(0, Id_max, step2)
Vd_source = Id_source*Rd_srs

for k3 in range(3):
    # IV sweep using Keithley2400 and DMM
    Top = temp.read_temp('B')
    srs_keith1.set_voltage(0)
    srs_keith1.set_output(True) 
    # srs_keith2.set_voltage(0)
    # srs_keith2.set_output(True) 
    yoko.set_voltage(0)
    yoko.set_output(True)
    sleep(30)
    
    # Variables
    Ib_gate = Vg_source/Rg_srs       # applied gate bias
    Ib_ch = Vd_source/Rd_srs         # applied channel bias
    Isw_ch = [] 
    Vg_read = np.zeros((len(Ib_gate),len(Ib_ch)))       # Equilibrium state reading
    Rg_read = np.zeros((len(Ib_gate),len(Ib_ch)))
    Vd_read = np.zeros((len(Ib_gate),len(Ib_ch)))
    Rd_read = np.zeros((len(Ib_gate),len(Ib_ch)))
    
    for k1 in range(len(Vg_source)):
        srs_keith1.set_voltage(Vg_source[k1])
        sleep(meas_interval)
        for k2 in range(len(Vd_source)):
            Vg_read[k1][k2] = dmm_keith1.read_voltage()
            ig_read = srs_keith1.read_current()          # Modified gate bias due to RHS, changes with Rbias value
            Rg_read[k1][k2] = Vg_read[k1][k2]/ig_read
            
            # srs_keith2.set_voltage(Vd_source[k2])
            yoko.set_voltage(Vd_source[k2])
            sleep(meas_interval)
            Vd_read[k1][k2] = dmm_keith2.read_voltage()
            # id_read = srs_keith2.read_current()
            id_read = (Vd_source[k2]-Vd_read[k1][k2])/Rd_srs
            Rd_read[k1][k2] = Vd_read[k1][k2]/id_read
            print(Vd_read[k1][k2])
            if(Vd_read[k1][k2] > 0.4):        # Vd_read[k1][k2] > 5e-3                    
            # if(Rd_read[k1][k2] > 1e2):
                Isw_ch.append(Vd_source[k2]/Rd_srs)
                print('Ig=%.4f mA, Isw=%.4f mA, Vch=%.4f V' %(Ib_gate[k1]*1e3, Vd_source[k2]/Rd_srs*1e3,Vd_read[k1][k2]))
                srs_keith1.set_voltage(Vg_source[0])               # To avoid previous heating effect
                # srs_keith2.set_voltage(Vd_source[0])               # To avoid previous heating effect
                yoko.set_voltage(Vd_source[0])
                sleep(60)
                break
                
    srs_keith1.set_output(False)
    yoko.set_output(False)
    # srs_keith2.set_output(False)    
    
    data_dict = {'Ib_gate':Ib_gate, 'Rg_srs':Rg_srs, 'Ib_ch':Ib_ch, 'Rd_srs':Rd_srs, 
                 'Isw_ch':Isw_ch, 'Rg_read':Rg_read, 'Vd_read':Vd_read, 'Rd_read':Rd_read,
                 'step1':step1, 'Top':Top, 'meas_interval':meas_interval}
    file_path, file_name  = save_data_dict(data_dict, test_type = 'Isw_curve', test_name = test_name,
                            filedir = filedirectry, zip_file=True)
    
    plt.plot(np.array(Ib_gate)*1e3, np.array(Isw_ch)*1e3, '-o')
    plt.xlabel('Ibias gate (mA)')
    plt.ylabel('Isw channel (mA)')
    plt.title('I-V '+device_name+', Top = %.1f K' %(Top))
    plt.savefig(file_path + '.png')
    plt.show()