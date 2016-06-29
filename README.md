# ParseQL-Swift
Easy way to manage MySQL Databases

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
#####We'll talk about "where key" later...


###Use completions to manage the results

###4. Create with block
#####It returns a message by now...
![Alt text](Images/CodeSaveBlock.png?raw=true "Create")


###5. Update with block
#####It returns affected rows as Array of Dictionaries
![Alt text](Images/CodeUpdateBlock.png?raw=true "Create")


###6. Delete with block
#####It returns affected rows amount
![Alt text](Images/CodeDeleteBlock.png?raw=true "Create")
