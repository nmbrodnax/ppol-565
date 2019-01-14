# scraper.py
# NaLette Brodnax
# PPOL 565, Spring 2019

# ACCESS #
# Import the libraries you need
import requests
import bs4
import csv

webpage = 'http://jse.amstat.org/jse_data_archive.htm'
server_response = requests.get(webpage)
print(server_response)


# PARSE #
soup = bs4.BeautifulSoup(server_response.text, features="html.parser")

# create a list of dictionaries (one dict for each link)
link_info_list = []
for tag in soup.find_all('a'):
    link = tag['href']
    name = tag.text
    # print(name)
    if name[-3:] == 'txt':
        link_info_list.append({'link': link, 'name': name})


# TRANSFORM #
# add a new category to each dictionary to categorize the file as either
# data or documentation
host = 'http://www.amstat.org/publications/jse/'
for dataset in link_info_list[3:6]:
    url = host + dataset['link']
    data_response = requests.get(url)
    if data_response.text[:5] == 'NAME:':
        dataset['type'] = 'doc'
    else:
        dataset['type'] = 'dat'


# STORE #
def download_to_txt(file_name, data):
    with open(file_name, 'w') as txtfile:
        txtfile.writelines(data)


def strip_extension(file_name):
    i = -1  # start at the end of the filename
    while i > -len(file_name):
        if file_name[i] == '.':
            break  # stop when you get to a period
        else:
            i -= 1  # this is the same as i = i - 1
    return file_name[:i]

# store individual data files as text files
for dataset in link_info_list[3:6]:
    url = host + dataset['link']
    data_response = requests.get(url)
    description = strip_extension(dataset['name'])
    filename = description + '_' + dataset['type'] + '.txt'
    download_to_txt(filename, data_response.text)

# store list of links as csv file
with open('data_links.csv', 'w') as csvfile:
    fieldnames = ['link', 'name', 'type']
    writer = csv.DictWriter(csvfile, fieldnames)
    writer.writeheader()
    for link in link_info_list:
        writer.writerow(link)
    print('Links added to file: ' + str(len(link_info_list)))
