# This runs sanity checks on the test data
from pathlib import Path
import os
import subprocess

crimac_scratch = os.getenv('CRIMACSCRATCH')

# List of test data
test_data = [d for d in Path(crimac_scratch,'test_data').iterdir() if d.is_dir()]

for _test_data in test_data[0:1]:
    print(_test_data)
    rawdir60 = Path(_test_data, 'ACOUSTIC/EK60/EK60_RAWDATA')
    rawdir80 = Path(_test_data, 'ACOUSTIC/EK80/EK80_RAWDATA')
    if rawdir60.exists():
        datain = rawdir60
    elif rawdir80.exists():
        datain = rawdir80
    else:
        datain = None

    dataout = Path(str(_test_data).replace("test_data", "test_data_out"), 'ACOUSTIC/COMPRESSED')

    # List the test data files and run file by file
    files = [item for item in datain.rglob('*.raw') if item.is_file()]

    for _file in files:
    
        command = [
            "docker", "run", "-it", "--rm",
            "-v", str(datain)+':/datain',
            "-v", str(dataout)+':/dataout',
            "--security-opt", "label=disable",
            "--env", "FILE_NAME="+_file.name,
            "crimac-datacompression"]

        subprocess.run(command, check=True)
