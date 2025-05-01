# This runs sanity checks on the test data
from pathlib import Path
import os
import subprocess
import json
import numpy as np

crimac_scratch = os.getenv('CRIMACSCRATCH')

# List of test data
test_data = [d for d in Path(crimac_scratch,'test_data').iterdir() if d.is_dir()]

testvalues = {}

# docker run -it --rm -v /mnt/c/DATAscratch/crimac-scratch/test_data/S2025302001_PFRIDA_10319/ACOUSTIC/EK80/EK80_RAWDATA:/datain -v /mnt/c/DATAscratch/crimac-scratch/test_data_out/S2025302001_PFRIDA_10319/ACOUSTIC/EK80/EK80_DECIMATED_DATA:/dataout crimac-datacompression --filename 2025302005-D20250429-T142408.raw

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

    # List the test data files and run file by file
    files = [item for item in datain.rglob('*.raw') if item.is_file()]

    for _file in files:
        
        command = [
            "docker", "run", "-it", "--rm",
            "-v", str(datain)+':/datain',
            "-v", str(dataout)+':/dataout',
            "crimac-datacompression", "--filename", _file.name]

        subprocess.run(command, check=True)

        koronafilesize = (dataout / (_file.name.split('.raw')[0]+'-korona.raw')).stat().st_size
        rawfilesize = _file.stat().st_size
        survey = str(_test_data).split('/')[-1]
        _testvalues = {'OriginalFileSize': rawfilesize,
                       'CompresseFileSize':koronafilesize,
                       'CompressRatio': koronafilesize/rawfilesize}
        print(_testvalues)
        testvalues[survey] = {}
        testvalues[survey][_file.name] = _testvalues

with open('results.json', 'w') as json_file:
    json.dump(testvalues, json_file)

with open('results.json', 'r') as json_file:
    loaded_data = json.load(json_file)

cr = []
for key in loaded_data.keys():
    for _key in loaded_data[key].keys():
        cr.append(loaded_data[key][_key]['CompressRatio'])

print(np.array(cr))
print(np.array(cr).mean())
