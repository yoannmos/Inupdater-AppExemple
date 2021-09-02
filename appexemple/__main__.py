import sys
from pathlib import Path

from appexemple import __version__

print(
    f"""
Hello you are in App Exemple version {__version__}\n
sys.argv[-1] : {sys.argv[-1]}\n
Path().cwd() : {Path().cwd()}\n
Path(__file__) : {Path(__file__)},\n
"""
)

input("Press [Enter] to quit.")
