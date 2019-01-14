# apiquery.py
# NaLette Brodnax
# PPOL 565, Spring 2019

import csv
import json
import requests

# REVIEW
# ============================
host = 'http://api.datausa.io/api/'
# https://github.com/DataUSA/datausa-api/wiki/DataAPI

# ACCESS
# ============================
# build api GET request
required_params = "?show=cip&sumlevel=2"
optional_params = "&year=2015&university=131496"
columns = "&required=grads_total,grads_men,grads_women"
url = host + required_params + optional_params + columns

print(url)

# check the HTTP response code
response = requests.request('GET', url)
print(response)


# PARSE
# ============================
# parse the JSON data into a python dictionary
degrees = response.json()


# TRANSFORM
# ============================
# display the result in an easy-to-read format
print(json.dumps(degrees, indent=4, sort_keys=True))
data = [dict(zip(degrees["headers"], d)) for d in degrees["data"]]

# STORE
# ============================

fieldnames = degrees["headers"]

# save data to a csv file
with open("ipeds_degrees_cip.csv", "w") as csvfile:
    writer = csv.DictWriter(csvfile, fieldnames)
    writer.writeheader()
    for row in data:
        writer.writerow(row)
