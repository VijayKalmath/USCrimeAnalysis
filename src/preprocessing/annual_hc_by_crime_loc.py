#! usr/env/bin python
import glob

import numpy as np
import pandas as pd
from tqdm import tqdm


def main():
    # Fetch File Paths
    file_paths = glob.glob(r'./data/raw/hc_count_by_place/*.xls')
    # Sort them according to year
    file_paths.sort(key = lambda x: int(x[-8:-4]))
    # Create a result dataframe to store the data
    df_res = get_place_crime_count(file_paths[0])
    # Iterate over the rest of the files
    for p in tqdm(file_paths[1:]):
        df_temp = get_place_crime_count(p)
        df_res = pd.merge(df_res, df_temp, on = "Place", how = "left")
    # Save the result to disk
    df_res.to_csv('./data/processed/annual_hc_count_by_place.csv',index=False)



def get_place_crime_count(path:str)->pd.DataFrame:
    """
    Function to return 
    """
    # Extracting the table name from and year from the given file path
    t_name = " ".join(path[path.index("Table"):path.index("_Incidents")].split("_"))
    t_year = path[path.index(".xls")-4:path.index(".xls")]

    try:
        # Read the Excel spreadsheet
        df = pd.read_excel(path,sheet_name=t_name)
        # Get the start and end indices of the interested datapoints
        start = df.index[df[t_name] == "Total"][0] + 1
        end = df.index[df[t_name] == "Multiple locations"][0] 
        # Slice the dataset
        df = df.iloc[start:end,0:2]
        # Reset the index for the reduced dataframe
        df.reset_index(drop = True, inplace = True)
        # Rename the columns
        df.rename(columns={t_name: "Place", "Unnamed: 1": t_year}, inplace = True)
        # Return the value
        return df
    except:
        # If there is no such data return an empty dataframe
        i_list = list(range(0,47))
        return pd.DataFrame(np.nan, index= i_list, columns=['Place', t_year])


if __name__ == '__main__':
    main()
