# NYTaxiDataset

In this project I have tried to analyse the New York Taxi dataset publicly available at [this link](http://www.nyc.gov/html/tlc/html/about/trip_record_data.shtml).

Analysis has been done only on the data from Aug'13 to Dec'15 using ***JULIA*** as it has some supreme features which improves the performances.

The original datasets and the *.jld* files have been removed from the repository as it was too big to upload, however the structure
of the directories have been retained, so that any one interested can download the dataset and place it in the appropriate
directories to obtain the results.

***Instructions to use the code***

* Download and place the datasets (yellow/green) in the directory *(Yellow/Green)_Taxi_Data_2013-15* after cloning this repository

* If u have downloaded the datasets directly from the link provide above then you need to clean the datasets before running any scripts.Instructions for cleaning the files are given along with required bash functions.

* Once datasets are cleaned you can run script files from *src* folder which will create required **.jld's** in *Graphs/Saved_Data*.All **.jl's** inside Graph folder load these jld's and produce required graphs.

A notebook having all the compilation analysis can be seen [here](http://nbviewer.jupyter.org/github/udion/NYTaxiDataset/blob/master/Graphs.ipynb)
