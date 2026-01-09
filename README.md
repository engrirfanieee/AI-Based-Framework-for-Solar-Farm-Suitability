AI-Based Solar Site Suitability Model (Synthetic Dataset, MATLAB)
===============================================================

This repository contains MATLAB code and synthetic data used to demonstrate an AI-based solar site suitability workflow. The pipeline prepares suitability factors, creates a suitability label, trains a Random Forest (bagged ensemble) classifier, and generates figures (workflow, input layers, ground truth, predicted suitability, confusion matrix, and feature importance).

Repository Contents
-------------------
- Main Paper Code.m
  Main MATLAB script for data preparation, model training, prediction, and figure generation.

- synthetic_solar_suitability_dataset.mat
  Synthetic raster layers (100×100) stored as MATLAB variables:
  solarIrradiance, slope, ndvi, distanceToGrid, landUse, label

- synthetic_solar_suitability_data.csv
  Flattened tabular dataset (10,000 rows) with columns:
  Solar_Irradiance, Slope, NDVI, Distance_to_Grid, Land_Use, Suitability_Label

Note: All data are synthetic and intended for methodological demonstration and reproducible experimentation.

Requirements
------------
- MATLAB (recommended R2018b+)
- Statistics and Machine Learning Toolbox (for cvpartition, fitcensemble, confusionchart)

Quick Start (Run the Model)
---------------------------
1) Clone/download this repository.
2) Open MATLAB and set the current folder to the repository directory.
3) Run the main script:
   - Open and run: Main Paper Code.m

The script will:
- Create/prepare synthetic feature layers (or you may load provided data),
- Split the dataset into training/testing,
- Train a bagged ensemble classifier (Random Forest-style),
- Predict suitability and reshape outputs into a 100×100 suitability map,
- Display figures.

Using the Provided Dataset (Optional)
-------------------------------------
The script may generate synthetic layers internally. If you want to run strictly from the provided files, load them at the top of the script and skip the synthetic generation section.

Load .mat raster layers:
  load('synthetic_solar_suitability_dataset.mat');
  rows = size(solarIrradiance, 1);
  cols = size(solarIrradiance, 2);

Load .csv flattened table:
  T = readtable('synthetic_solar_suitability_data.csv');
  X = [T.Solar_Irradiance, T.Slope, T.NDVI, T.Distance_to_Grid, T.Land_Use];
  Y = T.Suitability_Label;

Reproducibility
---------------
If you use the “generate synthetic layers” pathway, results may vary across runs unless a random seed is fixed. For deterministic synthetic generation, set a seed near the top of the script:

  rng(1);

Computer Code Availability
--------------------------
The code and synthetic datasets supporting this study are publicly available in a version-controlled repository and can be downloaded anonymously:

- Repository: [INSERT PUBLIC REPOSITORY LINK HERE (e.g., GitHub/Bitbucket)]

Please cite this repository if you use or adapt the code.

License
-------
Add a LICENSE file to the repository (e.g., MIT, BSD-3-Clause, GPL-3.0) and mention it here.

Contact
-------
For questions or issues, please open an issue in the repository.
