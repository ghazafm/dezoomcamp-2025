import pandas as pd
import sys

print(sys.argv)

if len(sys.argv) > 1 and sys.argv[1] is not None:
    day = sys.argv[1]
    print(f'job Done day {day}')
else:
    print('Job not done yet')
