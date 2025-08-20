#!/bin/sh


vboxmanage startvm "nexus" --type headless
vboxmanage startvm "control1" --type headless
vboxmanage startvm "worker1" --type headless
vboxmanage startvm "worker2" --type headless

