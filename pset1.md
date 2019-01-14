## PPOL 565 Spring 2019
### Problem Set 1 - Due by 11:59 on Sunday, January 20

#### Submission Instructions 
For this assignment, you will create scripts called *pset2_part1_netid.py* (or *pset2_part1_netid.R*) and *pset2_part2_netid.py* (or *pset2_part2_netid.R*), and a CSV file called *pset2_part2_netid.csv*. In all cases, replace "netid" with your Georgetown netid. Submit all three files on Canvas.

Code must run without warnings or errors. Scripts that produce errors will receive zero points. For full credit, code must be free of semantic errors, be written with liberal comments, include meaningful variable names, and use control structures to minimize repetition (three or more instances of nearly identical statements). 

#### Part 1 - Web Scraping (25 points)

Include all code for this section in a script called *pset2_part1_netid.py* (or *pset2_part1_netid.R*). You may wish to review the documentation for [Beautiful Soup 4.4.0](https://www.crummy.com/software/BeautifulSoup/bs4/doc/#quick-start) or [rvest](https://cran.r-project.org/web/packages/rvest/index.html). 

 1. Request the contents of the following webpage: [http://www.gutenberg.org/](http://www.gutenberg.org/). 

 2. Display the HTTP response code for the request.

 3. Display a list of instances containing "h2" tags.

 4. Display a list of links on the page.


#### Part 2 - APIs (25 points)

Include all code for this section in a script called *pset2_part2_netid.py* (or *pset2_part2_netid.R*).  This script should produce a CSV file called *pset2_part2_netid.py*.  You may wish to review the [API documentation](https://github.com/DataUSA/datausa-api/wiki/Data-API) available from [DataUSA](https://datausa.io).

Write a script to query two variables from any DataUSA API dataset other than IPEDS (e.g., Bureau of Labor Statistics, County Health Records, etc.).  Your script should produce a CSV file with the results of your query.  NOTE: Do not use the "Download as CSV" query option available through the API.

#### BONUS (5 points)

Some of the links from the JSE Data Archive lead to missing webpages (e.g., 4cdata.txt).  Modify the script *scraper.py* or *scraper.R* so that the output file (*data_links.csv*) indicates missing files in some way.





