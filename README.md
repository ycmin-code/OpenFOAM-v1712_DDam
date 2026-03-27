# Numerical Setup for Double Dam-Break Experiment

## Overview
This repository contains the numerical simulation setup and input files for the manuscript titled:

> **"Double dam-break generated swash flows on a rough planar beach: OpenFOAM numerical simulations"**

The provided cases are configured to reproduce the double dam-break mechanism using the **OpenFOAM** framework.
The solver used is **overInterDyMFoam** to handle the dynamic overset mesh for the moving gate mechanism.
These setups correspond to the validation cases presented in the manuscript.

## System Requirements
* Software: OpenFOAM v1712
* OS: Linux (Ubuntu/CentOS) or WSL
* Solver: overInterDyMFoam
* MATLAB (for generating gate motion data)

## Folder Structure

```
.
├── DDam_OverInterDyMFoam/
│   ├── CASE00/    Simultaneous opening of both gates (Lag: 0.0 s)
│   │   ├── movingObjectMesh/                Component mesh (Overset mesh)
│   │   └── backgroundAndMovingObject/       Main simulation domain (Merged mesh)
│   ├── CASE10/    Asynchronous opening: 1.0 s delay between gates
│   ├── CASE20/    Asynchronous opening: 2.0 s delay between gates
│   └── CASE30/    Asynchronous opening: 3.0 s delay between gates
├── gate_motion/
│   └── DoubleDamBreak_MovingWall.m          MATLAB script for gate motion data
├── LICENSE
└── README.md
```

## How to Run

### 1. Generate Gate Motion Files
Run the MATLAB script to generate the gate displacement data (`C**_wdisp.dat`) required by `dynamicMeshDict`.

```bash
cd gate_motion
matlab -batch "DoubleDamBreak_MovingWall"
```

Then copy each output file to the corresponding case directory:
```bash
cp C00_wdisp.dat ../DDam_OverInterDyMFoam/CASE00/backgroundAndMovingObject/constant/
cp C10_wdisp.dat ../DDam_OverInterDyMFoam/CASE10/backgroundAndMovingObject/constant/
cp C20_wdisp.dat ../DDam_OverInterDyMFoam/CASE20/backgroundAndMovingObject/constant/
cp C30_wdisp.dat ../DDam_OverInterDyMFoam/CASE30/backgroundAndMovingObject/constant/
```

### 2. Execute Simulation
The `Allrun` script will automatically handle the merging of the overset mesh components and start the simulation.

```bash
cd DDam_OverInterDyMFoam/CASE00
./Allrun
```

## Citation
If you use this code in your research, please cite:

> Min, Y., Ok, J., Kim, Y., Delisle, M.-P. C., & Choi, S. (2026). "Double dam-break-generated swash flows on a rough planar beach," *Physics of Fluids*, 38. https://doi.org/10.1063/5.0315268

## License
This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.
