# ParseQL-Swift
Easy way to manage your own MySQL Databases just with Swift.

## Installation
1- Add "ParseQL.swift" (in "/SwiftSource/Xcode 7" to your Xcode project.<br>
2- Write your own "PRIVATE_KEY" and "TOKEN" in "ParseQL.swift".<br>
3- Write the same "PRIVATE_KEY" and "TOKEN" in "PHP/parseql/application/controllers/ParseQLController.php".<br>
4- Edit "PHP/parseql/config/database.php" file with your database info (at the bottom on the file).<br>
5- Upload "parseql" folder, to your hosting.<br>
6- Edit BASE_URL in "ParseQL.swift" file, to point to "parseql" folder in your hosting.<br>
7- Ready!<br>

###1. Create Row
![Alt text](Images/CodeCreate.png?raw=true "Create Row")
######And we get our first row, in our own database.
######Don't worry about create the table and the columns, if they don't exist, ParseQL will create them.
![Alt text](Images/TestTable1.png?raw=true "Create")


###2. Update Row
![Alt text](Images/CodeUpdate.png?raw=true "Update Row")
######Here's the change.
![Alt text](Images/TestTable2.png?raw=true "Update Row")


###3. Delete Row
![Alt text](Images/CodeDelete.png?raw=true "Delete Row")
######We'll talk about "where key" later...


###Use completions to manage the results
######Maybe you want to wait the result of the tasks above. The completions return some useful data too.

###4. Create with block
######It returns a message by now...
![Alt text](Images/CodeSaveBlock.png?raw=true "Create With Block")


###5. Update with block
######It returns affected rows as Array of Dictionaries
![Alt text](Images/CodeUpdateBlock.png?raw=true "Update With Block")


###6. Delete with block
######It returns affected rows amount
![Alt text](Images/CodeDeleteBlock.png?raw=true "Delete With Block")


###7. Conditions (We'll use some of these to get data from our database)
######WhereKey (equal, greater, less and notEqual)
![Alt text](Images/CodeWhereKey1.png?raw=true "Conditions")
![Alt text](Images/CodeWhereKey2.png?raw=true "Conditions")

######OrderByAsc and OrderByDesc
![Alt text](Images/CodeOrderBy.png?raw=true "OrderBy")

######Limit
![Alt text](Images/CodeLimit.png?raw=true "Limit")

######Skip
![Alt text](Images/CodeSkip.png?raw=true "Skip")



###8. Get
######It returns an Array or Dictionaries
![Alt text](Images/CodeGet2.png?raw=true "Get")


##9. Cancel
######You can cancel any PQL object task you started
![Alt text](Images/CodeCancel.png?raw=true "Cancel")
