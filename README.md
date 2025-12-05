# Numerical Setup for Double Dam-Break Experiment

## Overview
This repository contains the numerical simulation setup and input files for the manuscript titled "Double dam-break generated swash flows on a rough planar beach: OpenFOAM
numerical simulations".
The provided cases are configured to reproduce the double dam-break mechanism using the **OpenFOAM** framework.
The solver used is **overInterDyMFoam** to handle the dynamic overset mesh for the moving gate mechanism.
These setups correspond to the validation cases presented in the manuscript.

> **Note:** This repository is anonymized for the peer-review process.

## System Requirements
* Software: OpenFOAM v1712
* OS: Linux (Ubuntu/CentOS) or WSL
* Solver: overInterDyMFoam
 
## Folder Structure
The repository is organized by simulation cases. Each case directory contains the overset mesh setup for the moving object and the background domain.

* **DDam_OverInterDyMFoam/**
    * `CASE00/`: Simultaneous opening of both gates (Lag: 0.0s)
        * `movingObjectMesh/`: Component mesh setup (Overset mesh)
        * `backgroundAndMovingObject/`: Main simulation domain (Merged mesh)
    * `CASE10/`: Asynchronous opening: 1.0s delay between gates
    * `CASE20/`: Asynchronous opening: 2.0s delay between gates
    * ...

## How to Run
To reproduce the validation results, please follow the steps below.

### 1. Unzip Gate Motion Files
The input files required to reproduce the water gate opening (moving object) are compressed due to GitHub file size limits.
These files must be extracted to run the simulation.

* Target Directory: `./CASE**/backgroundAndMovingObject/constant/`
* Target File: `C**_wdisp.zip` (e.g., `C00_wdisp.zip`)

### 2. Execute Simulation
The Allrun script will automatically handle the merging of the overset mesh components and start the simulation.

* Target Directory: `./CASE**/`
* Target File: `Allrun`


