#!/usr/bin/bash 
echo "This is a shell script activating biobb"  
conda activate biobb
echo "Activated biobb generate jupyter config" 
jupyter notebook --generate-config
