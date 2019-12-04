# Redbrain

Project designed by Andrea Cristini, Emilie Sauvage, Tiziano Suran, and Carlos Vergel Infante for RedBrain Ltd. as part of the S2DS 2019 program.

### For more detailed information, please see: `TechnicalReport_RedBrain_Sept2019.docx`.

Two main processes are performed in this repository:

1. A classification model
1. Exploration of the raw data

![github-small](https://github.com/S2DSLondon/Redbrain/blob/master/Draft_scripts/NotebookWorkflow.png)

As explained in the graph above, the classification model starts from the ouput of the Google BigQuery by using `SQL_aggregated_data.csv`, reshaped to the final formed in `Reshaping.ipynb`, and then classified using Random Forest with `ClassificationModel.ipynb` which creates the model, the confussion matrix, and the calculation of the recall and precision of the model.

The exploration part has the same starting point as in the classification model, but two different scripts. `Profile_Retailer.ipynb` prints basic information about a particular retailer, while `Clustering.ipynb` groups the raw data into k-clusters.

All the notebooks run out-of-the-box with the datasets `SQL_aggregated_data.csv` and `Reshaped_dataset.csv`.

## SQL scripts

Two SQL scripts were used by Mitch to extract the information from the BigQuery. 

- The first one, called `SQL_script.sql` is the one used in all the scripts. It first removes duplicates from the raw data requiring grouping of all the columns used in the analysis. 
- Then, the data is divided between two periods: the trial period and the future period. This can be changed by updating the cutting date in line 46. At the moment, this is set at `2019-05-20`. 
- Then, the columns are selected from the subQueries. Revenue, defined as `1.3*ConversionValue`, is the KPI used in the analysis.
- Finally, all the entries are grouped by retailer and period; therefore, each retailer should contain two entries: once in the trial period, and one in the future period.

A second script, called `SQL_perweek_script.sql`, has the same format, except it is group by retailer AND week, but no by period. Even though it was not used in any of the scripts, this script is more flexible to see the performace of retailers as a function of time (week).
