# ParseQL-Swift
Easy way to manage your own MySQL Databases just with Swift.

## Installation
1- Add "ParseQL.swift" (in "/SwiftSource/Xcode 7") to your Xcode project.<br>
2- Write your own "PRIVATE_KEY" and "TOKEN" in "ParseQL.swift".<br>
3- Write the same "PRIVATE_KEY" and "TOKEN" in "PHP/parseql/application/controllers/ParseQLController.php".<br>
4- Edit "PHP/parseql/config/database.php" file with your database info (at the bottom on the file).<br>
5- Upload "parseql" folder, to your hosting.<br>
6- Edit BASE_URL in "ParseQL.swift" file, to point to "parseql" folder in your hosting.<br>
7- Ready!<br>
<h2>1. Create Row</h2>

![Alt text](Images/CodeCreate.png?raw=true "Create Row")

    And we get our first row, in our own database.
    Don't worry about create the table and the columns, if they don't exist, ParseQL will create them.
    
![Alt text](Images/TestTable1.png?raw=true "Create")

<br>

<h2>2. Update Row</h2>


![Alt text](Images/CodeUpdate.png?raw=true "Update Row")

Here's the change.

![Alt text](Images/TestTable2.png?raw=true "Update Row")

<br>

<h2>3. Delete Row</h2>

![Alt text](Images/CodeDelete.png?raw=true "Delete Row")

We'll talk about "where key" later...

Use completions to manage the results.
Maybe you want to wait the result of the tasks above. The completions return some useful data too.

<br>

<h2>4. Create with block</h2>

It returns a message by now...

![Alt text](Images/CodeSaveBlock.png?raw=true "Create With Block")

<br>

<h2>5. Update with block</h2>

It returns affected rows as Array of Dictionaries

![Alt text](Images/CodeUpdateBlock.png?raw=true "Update With Block")

<br>

<h2>6. Delete with block</h2>

It returns affected rows amount

![Alt text](Images/CodeDeleteBlock.png?raw=true "Delete With Block")

<br>

<h2>7. Conditions (We'll use some of these to get data from our database)</h2>

<h4>WhereKey (equal, greater, less and notEqual)</h4>

![Alt text](Images/CodeWhereKey1.png?raw=true "Conditions")
![Alt text](Images/CodeWhereKey2.png?raw=true "Conditions")

<h4>OrderByAsc and OrderByDesc</h4>

![Alt text](Images/CodeOrderBy.png?raw=true "OrderBy")

<h4>Limit</h4>

![Alt text](Images/CodeLimit.png?raw=true "Limit")

<h4>Skip</h4>

![Alt text](Images/CodeSkip.png?raw=true "Skip")

<br>

<h2>8. Get</h2>

It returns an Array or Dictionaries

![Alt text](Images/CodeGet2.png?raw=true "Get")

<br>

<h2>9. Cancel</h2>

You can cancel any PQL object task you started

![Alt text](Images/CodeCancel.png?raw=true "Cancel")
