# This runs sanity checks on the test data
from pathlib import Path
import os
import subprocess
import json
import numpy as np
import xarray as xr
import matplotlib.pyplot as plt
import pwd

datadir = Path('/data/s3/vesseldata/SOUNDER/2025/')

#cruises = ['PRETOBISTEST_PFRIDA_10319', 'S2025301010_PFRIGG_10318',
cruises = ['S_2025302001_PFRIDA_10319', # 'S2025302002_PFRIDA_10319',
           'S2025301002_PFRIGG_10318', 'S2025302001_PFRIDA_10319',
           'S2025302010_PFRIDA_10319']

for cruise in cruises:
    subdir = Path('ACOUSTIC/EK80/EK80_DECIMATED_DATA/dataQuality')
    _datapath = datadir / cruise / subdir
    if _datapath.exists():
        print(cruise)
        print(_datapath)
    
        ds = xr.open_mfdataset(str(_datapath / "*.nc"), combine="by_coords")
        fig, axes = plt.subplots(nrows=len(ds.data_vars), figsize=(6, 4 * len(ds.data_vars)))
        for ax, var in zip(axes, ds.data_vars):
            ds[var].plot(ax=ax)
            ax.set_title(var)
            plt.tight_layout()
            plt.savefig('./'+str(cruise)+'_dataQulity.png', dpi=300, bbox_inches="tight")
    else:
        print('No data for :'+cruise)
