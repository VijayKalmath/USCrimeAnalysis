#! usr/env/bin/python3
import glob

import numpy as np
import pandas as pd
from tqdm import tqdm


def main():
    # Fetch File Paths
    file_paths = glob.glob(r'./data/raw/hc_count_by_state/*.xls')
    # Sort them according to year
    file_paths.sort(key = lambda x: int(x[-8:-4]))
    # Create a dataframe to store the result and initialize it with the values for the first year
    df_res = get_state_crime_count(file_paths[0])
    # Iterate over the rest of the files
    for p in tqdm(file_paths[2:]):
        df_temp = get_state_crime_count(p)
        df_res = pd.merge(df_res,df_temp,how="left",on=["States"])
    # Save the result to disk
    df_res.to_csv("./data/processed/annual_hc_by_state.csv")




def get_state_crime_count(path: str) -> pd.DataFrame:
    """
    Function to return the number of hatecrimes commited in each state as a dataframe
    """
    # Extracting the table name from and year from the given file path
    t_name = " ".join(path[path.index("Table"): path.index("_Offenses")].split("_"))
    t_year = path[path.index(".xls") - 4: path.index(".xls")]
    # Read the dataframe
    df_state_count = pd.read_excel(path, sheet_name=t_name)
    # Get the start and end indices of the interested datapoints
    start = df_state_count.index[df_state_count[t_name] == "Total"][0] + 1
    end = df_state_count.index[df_state_count[t_name] == "Wyoming"][0] + 1
    # Slice the dataset
    df_state_count = df_state_count.iloc[start: end, 0:2]
    # Reset the index
    df_state_count.reset_index(drop=True, inplace=True)
    # Rename the columns
    df_state_count.rename(columns={t_name: "States", "Unnamed: 1": t_year}, inplace=True)
    # Return the result
    return df_state_count

if __name__ == "__main__":
    main()
