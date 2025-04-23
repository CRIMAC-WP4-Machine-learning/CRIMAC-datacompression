import shutil
import os
from pathlib import Path
import subprocess

# Copy a single file to scratch disk  within the
# container (to only process a single file)
file_name = os.getenv('FILE_NAME')
filein = Path('/datain', file_name)
filerun = Path('/scratch', file_name)
shutil.copy(filein, filerun)

# Run korona on the single file
cmdstr = ['/lsss-3.0.0/korona/KoronaCli.sh',
          'batch',
          '--cfs', '/app/compression.cfs',
          '--destination', '/dataout',
          '--source', '/scratch']

print(cmdstr)
subprocess.run(cmdstr, check=True)
