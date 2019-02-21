  # Merging (using base R)
  # The purpose of this script is to demonstrate examples of the four different types of joins (inner, outer, left, and right) to aid in the comprehension of merging.
  
  # merge documentation
  ?merge
  
  # load data (fictional data)
  df1 <- read.csv("https://raw.githubusercontent.com/nmbrodnax/ppol-565/master/misc_resources/merging/df1.csv", header = TRUE)
  df2 <- read.csv("https://raw.githubusercontent.com/nmbrodnax/ppol-565/master/misc_resources/merging/df2.csv", header = TRUE)
  
  # inner join (only adds the data from variables in both datasets for the Names that are in common between df1 and df2)
  inner <- merge(df1, df2, all = FALSE, by = "Name")
  
  # outer join (joins all of the Names, notice the missing data)
  outer <- merge(df1, df2, all = TRUE, by = "Name")
  
  # left join (joins data from df2 to df1, but only for the Names that are in df1, again take note of the missing data)
  # note: left and left2 are identical objects. Take note of the order in which the dataframes are specified and whether all.x or all.y is used.
  left <- merge(df1, df2, all.x = TRUE, by = "Name")
  left2 <- merge(df2, df1, all.y = TRUE, by = "Name")
  
  # right join (join data from df1 to df2, but only for the Names that are in df2, again take note of the missing data)
  # note: right and right2 are identical objects. Take note of the order in which the dataframes are specified and whether all.x or all.y is used.
  right <- merge(df1, df2, all.y = TRUE, by = "Name")
  right2 <- merge(df2, df1, all.x = TRUE, by = "Name")
  
  # note: if the variable you are joining on is named differently in the two datasets, you will need to specify both by.x = "name1" and by.y = "name2".
  
