# Getting-and-Cleaning-Data
run_analysis.R 
  * Will check for need files
    * Downloads files if needed
  * Load needed libraries 
    * data.table
    * plyr
    * dplyr
  * Reads downloaded data sets into memory
  * Merges Data Sets in Single Large Data Set
  * Assigns labels to variables 
  * Extracts Mean and Std Dev values from data set (DataSet1)
  * Creates second data set with averagew of each variable for each activity and subject (DataSet2)
  * Returns the value of output
    * output is a list of DataSet1 and DataSet2
