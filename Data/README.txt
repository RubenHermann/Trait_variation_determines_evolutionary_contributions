Data:
Empirical results: Here are all empirical results saved, which are collected into one file and are used for analysis or figures
- all_data_assembled.csv: All data from the different sources (ISX,IXM,rotifer counts) put together into one file
- chlamydomonas_traits.csv: Values of the traits (max growth rate & defence against predation) of each clone used in the experiments
- final_data.csv: Assembled data with the calculated relative contribution of evolution and ecology, ready for analysis.
-------------------------------------------------------------------------------------------------------------------------------------
ISX: Here is all the data saved from the imagestream, used for prediction of clonal frequency with the Keras models
- Feature files: The raw data from the imagestream with one file for all feature values from one well of one plate.
-- Controls: Feature values of all controls
-- Treatments: Feature values of all treatments
- Keras Model training: All data from the single clone controls for training the Keras model
- Predicted frequencies: Predicted frequencies for the clones of the Keras model
- Renamed feature files: The renamed feature files according to the R-code "Renaming ISX files.Rmd", sorted in the same manner as - Feature files
The csv values are the corresponding treatment/control for each well and plate of the ISX, used to rename the raw Feature Files.
-------------------------------------------------------------------------------------------------------------------------------------
IXM: Here all the data saved from the inverted well-plate microscopy for density counts
- raw_data: Raw counts from each plate of the IXM, files named after the ID given automatically for each plate
- raw_data_sum: The summed raw data counts for each well from the IXM, which gives 9 counts per well, with the R-code: "Sum IXM data.Rmd"
- sorted: All the summed raw data, sorted according to its treatment, using the files "Files sorted IXM.xlsx" and "Plate Information on IER trait plates.xlsx". This was done manually
-----------------------------------------------------------------------------------------------------------------------------------
Keras Models: Here are the trained Keras-models
-------------------------------------------------------------------------------------------------------------------------------------
Model Results: The results of the mechanistic model
-------------------------------------------------------------------------------------------------------------------------------------
Rotifer counts: Live counting of the rotifers
