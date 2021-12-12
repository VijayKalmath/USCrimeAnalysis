#! usr/env/bin/python3
import glob

import numpy as np
import pandas as pd
from tqdm import tqdm


def main():
    # Fetch File Paths
    file_paths = glob.glob(r'./data/raw/ucr/offender_count_by_age/*.xls')
    # Sort them according to year
    file_paths.sort(key = lambda x: int(x[-8:-4]))
    # Create a dataframe to store the result and initialize it with the values for the first year
    df_res = get_offender_count_by_age(file_paths[0])
    # Iterate over the rest of the files
    for p in  tqdm(file_paths[1:]):
        df_temp = get_offender_count_by_age(p)
        df_res = pd.merge(df_res,df_temp,how="left",on=["Age Category"])
    # Save the result to disk
    df_res.to_csv("./data/processed/ucr/annual_offenders_by_age.csv",index=False)


def get_offender_count_by_age(path:str)->pd.DataFrame:
    """
    Function to return the number of hatecrimes by adults and minors each year as a dataframe
    """  
    # Extracting the table name from and year from the given file path
    t_name = " ".join(path[path.index("Table"):path.index("_Known")].split("_"))
    t_year = path[path.index(".xls")-4:path.index(".xls")]
    try:
        # Read the Excel spreadsheet
        df_age_crime = pd.read_excel(path,sheet_name=t_name)
        # Get the start and end indices of the interested datapoints
        start = df_age_crime.index[df_age_crime[t_name] == "Total known offenders 18 and over"][0]
        end = start + 2
        # Slice the dataset
        df_age_crime = df_age_crime.iloc[start:end,0:2]
        # Reset the index for the reduced dataframe
        df_age_crime.reset_index(drop = True, inplace = True)
        # Rename the columns
        df_age_crime.rename(columns={t_name: "Age Category", "Unnamed: 1": t_year}, inplace = True)
        # Return the value
        return df_age_crime
    except:
        # If there is no such data return an empty dataframe
        df_default = pd.DataFrame(np.nan, index=[0, 1], columns=['Age Category', t_year])
        df_default["Age Category"][0] = "Total known offenders 18 and over"
        df_default["Age Category"][1] = "Total known offenders under 18"
        return df_default

if __name__ == "__main__":
    main()
