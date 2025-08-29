# This runs sanity checks on the test data
from pathlib import Path
import os
import numpy as np
import xarray as xr
import matplotlib.pyplot as plt
import pwd

crimac_scratch = '/crimac-scratch' #'CRIMACSCRATCH')

# List of test data
test_data = [d for d in Path(crimac_scratch,'test_data').iterdir() if d.is_dir()]

testvalues = {}

for _test_data in test_data:
    print(_test_data)
    rawdir60 = Path(_test_data, 'ACOUSTIC/EK60/EK60_RAWDATA')
    rawdir80 = Path(_test_data, 'ACOUSTIC/EK80/EK80_RAWDATA')
    if rawdir60.exists():
        datain = rawdir60
        dataout = Path(str(_test_data).replace("test_data", "test_data_out"), 'ACOUSTIC/EK60/EK60_DECIMATED_DATA')
    elif rawdir80.exists():
        datain = rawdir80
        dataout = Path(str(_test_data).replace("test_data", "test_data_out"), 'ACOUSTIC/EK80/EK80_DECIMATED_DATA')
    else:
        datain = None
        dataout = None

    doq = dataout /"dataQuality"
    ds = xr.open_mfdataset(str(doq / "*.nc"), combine="by_coords")
    fig, axes = plt.subplots(nrows=len(ds.data_vars), figsize=(6, 4 * len(ds.data_vars)))
    for ax, var in zip(axes, ds.data_vars):
        ds[var].plot(ax=ax)
        ax.set_title(var)
        plt.tight_layout()
        plt.savefig(str(doq).split('/')[3]+"dataQuality.png", dpi=300, bbox_inches="tight")

