# IUCN parser

### Folder Structure:

IUCNparser (*root*)  
__ -- IUCNparser.R  
__ -- *name of search query* (i.e. 'Pteropodidae')  
_____ -- page1.txt  
_____ -- page2.txt  
_____ -- page3.txt  
_____ -- (*etc.*)

### Instructions for Use:

1. Visit http://www.iucnredlist.org/
2. Enter the search query (i.e. 'Pteropodidae')
3. Copy the table of search results (be sure to omit the pagination buttons at the top and bottom of the page)
![alt text](Assets/p1.png)
4. Paste the text into a text-editor and save the file, as a .txt, in the directory named after the search query (i.e. 'Pteropodidae')
5. If multiple pages of search results exist, repeat steps 3-4 for each page, and use a different name for each .txt file
6. Open the IUCNparser.R script
7. Edit line 1 to the path of the root direcotry
8. Edit line 2 to the name of the directory named after the search query (i.e. 'Pteropodidae')
9. Run the entire script
10. The output will be stored in the root directory as three seperate .csv files   
