# ParseQL-Swift
Easy way to manage your own MySQL Databases directly from Swift.

## Installation
1- Add "ParseQL.swift" to your project<br>
2- Add "parseql" folder (inside PHP folder), to your hosting.<br>
3- Edit BASE_URL in "ParseQL.swift" file, to point to "parseql" folder in your hosting<br>
4- Edit "parseql/config/database.php" file with your database info.<br>
5- Ready!<br>

###1. Create Row
![Alt text](Images/CodeCreate.png?raw=true "Create")
######And we get our first row, on our own database.
![Alt text](Images/TestTable1.png?raw=true "Create")


###2. Update Row
![Alt text](Images/CodeUpdate.png?raw=true "Create")
######Here's the change.
![Alt text](Images/TestTable2.png?raw=true "Update")


###3. Delete Row
![Alt text](Images/CodeDelete.png?raw=true "Delete")
######We'll talk about "where key" later...


###Use completions to manage the results
######Maybe you want to wait the result of the tasks below. The completions return some useful data too.

###4. Create with block
######It returns a message by now...
![Alt text](Images/CodeSaveBlock.png?raw=true "Create")


###5. Update with block
######It returns affected rows as Array of Dictionaries
![Alt text](Images/CodeUpdateBlock.png?raw=true "Create")


###6. Delete with block
######It returns affected rows amount
![Alt text](Images/CodeDeleteBlock.png?raw=true "Create")


###7. Conditions (We'll use some of these to get data from our database)
######WhereKey (equal, greater, less and notEqual)
![Alt text](Images/CodeWhereKey1.png?raw=true "Create")
![Alt text](Images/CodeWhereKey2.png?raw=true "Create")

######OrderByAsc and OrderByDesc
![Alt text](Images/CodeOrderBy.png?raw=true "Create")

######Limit
![Alt text](Images/CodeLimit.png?raw=true "Create")

######Skip
![Alt text](Images/CodeSkip.png?raw=true "Create")



###8. Get
######It returns an Array od Dictionaries
![Alt text](Images/CodeGet2.png?raw=true "Create")


##9. Cancel
######You can cancel any PQL object task you started
![Alt text](Images/CodeCancel.png?raw=true "Create")
