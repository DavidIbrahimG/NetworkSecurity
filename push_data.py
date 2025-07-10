import os
import json
import sys

from dotenv import load_dotenv
load_dotenv()

## we use this loadenv to get my mongodb cred from the .env file

MONGO_DB_URI = os.getenv("MONGO_DB_URI")

## checking to make sure we got it right
print(MONGO_DB_URI)


### certifi is a Python package that provides a trusted bundle of root certificates, ensuring secure SSL/TLS connections
import certifi
ca = certifi.where()

import numpy as np
import pandas as pd
import pymongo
from networksecurity.logging.logger import logging
from networksecurity.exception.exception import NetworkSecurityException


class NetworkDataExtract():
    def __init__(self):
        try:
            pass
        except Exception as e:
            raise NetworkSecurityException(e, sys)
        
    def cv_to_json_convertor(self, filepath):
        try:
            data = pd.read_csv(filepath)
            data.reset_index(drop=True, inplace=True)
            records = list(json.loads(data.T.to_json()).values())  ## convert to json and also to stack of arrays using .values()
            return records
        except Exception as e:
            raise NetworkSecurityException(e, sys)

        
    def insert_data_mongodb(self, 
                            records, 
                            database, 
                            collection):
        try:
            self.database=database
            self.collection=collection
            self.records=records

            self.mongo_client=pymongo.MongoClient(MONGO_DB_URI)
            self.database = self.mongo_client[self.database]

            self.collection=self.database[self.collection]
            self.collection.insert_many(self.records)
            return(len(self.records))
        except Exception as e:
            raise NetworkSecurityException(e, sys)


if __name__=='__main__':
    FILE_PATH="Network_Data/phisingData.csv"
    DATABASE="DAVIDGAI"
    Collection="NetworkData"
    networkobj=NetworkDataExtract()
    records=networkobj.cv_to_json_convertor(filepath=FILE_PATH)
    print(records)
    no_of_records=networkobj.insert_data_mongodb(records, DATABASE, Collection)
    print(no_of_records)