#!/bin/bash
growpart /dev/nvme0n1 4 
lvextend -r -L+30G /dev/mapper/RootVG-homeVol
xfs_growfs /home