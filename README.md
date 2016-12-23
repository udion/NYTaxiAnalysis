# NYTaxiDataset

In this project I have tried to analyse the New York Taxi dataset publicly available at [this link](http://www.nyc.gov/html/tlc/html/about/trip_record_data.shtml).

Analysis has been done only on the data from Aug'13 to Dec'15 using ***JULIA*** as it has some supreme features which improves the performances.

The original datasets and few **.jld** files have been removed from the repository as it was too big to upload, however the structure
of the directories have been retained, so that any one interested can download the dataset and place it in the appropriate
directories to obtain the results.

# Why Julia

The dataset being analysed has size ~2.5GB for each yellow taxi per month and ~250MB for Green taxi per month in CSV format. Julia is a lot of fun for me—learning it is **easy**,codes are **clean** and it approaches and often matches the **performance** of C. CSV parsing is fast and CSV package handles most of the issues itself. Working with 29 months of data require something more than just a sequential approach to datasets and that is where Julia nails it. Parallel programming constructs in Julia are easy to understand and they work flawlessly. Just  introducing @everywhere macros allows to load functions on every independent process and pmap could be used to map a function on different processors of the system and collect output from these parallel process. Hence it helps us to avoid following the sequential order and do it one by one hence we were able to load all the data in about as much time as it takes to load one dataset with maximum loading time. This increased the performance by upto 30X. Gadfly is a system for plotting and visualization written in Julia which i have used extensively throughout the project.   


# Graphs

***Instructions to use the code***

* Download and place the datasets (yellow/green) in the directory *(Yellow/Green)_Taxi_Data_2013-15* after cloning this repository

* If u have downloaded the datasets directly from the link provide above then you need to clean the datasets before running any scripts.Instructions for cleaning the files are given along with required bash functions.

* Once datasets are cleaned you can run script files from *src* folder which will create required **.jld** in *Graphs/Saved_Data*. All **.jl's** inside Graph folder load these jld's and produce required graphs.


# HeatMaps

These are plotted using Google api and can be recreated using the following steps

***Instructions to use the code***

* Gif's of heatmaps have been attached in *Graphs.ipynb*.

* To recreate heatmaps code has been provided in *Heatmaps* folder. Running these scripts will produce **.jld** in *Graphs/Saved_Data*.

* Then go to Heatmaps.ipynb and run the code in specified order.


A notebook having all the compilation analysis can be seen [here](http://nbviewer.jupyter.org/github/udion/NYTaxiDataset/blob/master/Graphs.ipynb)
