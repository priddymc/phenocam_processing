# ------------------------------------------------------------------

# NOTE: This version edited by Mindy Priddy (Last update: August 12, 2024)

# PhenoCam Processing 
# Analyzing PhenoCam Images for Vegetation Indices 
#   * Need to ensure the accompanying 'phenocam_fxn.R' is included

# Pre-Processing Data Management (Ensure the images follow this path):
#   Site > Year > Month > Unaltered Loose Image Files

# Created: May 30, 2023 (Last Update: Aug. 15, 2023)
# Kelsey McGuire 
# ------------------------------------------------------------------

# Set-up Libraries 
library('phenopix')
library('raster')
library('ggplot2')
library('dplyr')
source('D:/Phenocam/phenocam_fxn.R')
# devtools::install_github("collectivemedia/tictoc")
library('tictoc')
library('epitools')
library('stringr')

wd <- 'D:/Phenocam/RRC'
PhenoProcessing(wd, "D:/Phenocam/RRC/2024/January/REF/", NumofPix = 3, datecode = 'yyyy-mm-dd-HH-MM-SS', NROI = 1)
