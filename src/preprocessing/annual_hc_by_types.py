#! usr/env/bin python
import glob

import numpy as np
import pandas as pd
from tqdm import tqdm


def main():
    # Fetch File Paths
    file_paths = glob.glob(r'./data/raw/hc_count_by_offense_type/*.xls')
    # Sort them according to year
    file_paths.sort(key = lambda x: int(x[-8:-4]))
    # Create a dataframe to store the result and initialize it with the values for the first year
    df_res = get_offenses_by_type(file_paths[0])
    # Iterate over the rest of the files
    for p in tqdm(file_paths[1:]):
        df_temp = get_offenses_by_type(p)
        df_res = pd.merge(df_res,df_temp,how="left",on=["Offense"])
    # Save the result to disk
    df_res.to_csv("./data/processed/annual_hc_by_offense_type.csv",index=False)



def get_offenses_by_type(path:str)->pd.DataFrame:
    """
    Function to returnt the number of hatecrimes committed of each type  as a dataframe
    """
    # Extracting the table name from and year from the given file path
    t_name = " ".join(path[path.index("Table"): path.index("_Offenses")].split("_"))
    t_year = path[path.index(".xls") - 4: path.index(".xls")]
    # Read the data from the file
    df = pd.read_excel(path, sheet_name = t_name)
    # Get the start and end indices for the interested datapoints
    start = df.index[df[t_name] == "Crimes against persons:"][0] + 1
    mid = df.index[df[t_name] == "Crimes against property:"][0] - 1
    end = df.index[df[t_name] == "Crimes against society"][0] -1
    # Slice the dataframe
    df_1 = df.iloc[start:mid,0:2]
    df_2 = df.iloc[mid+2:end,0:2]
    # Merge the two dataframes
    df = df_1.append(df_2)
    # Reset the index
    df.reset_index(drop=True, inplace=True)
    # Rename the columns
    df.rename(columns={t_name: "Offense", "Unnamed: 1": t_year}, inplace=True)
    # Return the result
    return df



if __name__ == '__main__':
    main()
