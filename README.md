# ToDo:
* animated checkbox on PendingView

# Weekend 1 Assignment
## Create a basic TODO app - 
- the user will be able to create custom TODOs 
- able to see and complete them later.

Requirements:
Create a Tab Bar app with at least two tabs

## First Tab
### First Screen: 
- Contains a TableView containing a list of all the User’s current (and uncompleted) TODOs. 
- Each cell must contain
* * a label for the title, 
* * a label for the description, 
* * a label for the due date, 
* * and a button that will “complete” the TODO. i
* If the TODO is past due, the color of the date text should be red. 
* The user must also be able to swipe to delete any TODOs.

## Second Screen: 
* There must be a another screen that will allow the user to enter in a new TODO. 
* The user must be able to enter in i
* * a title, 
* * a description, 
* * and a due date. 
* This screen therefore must contain 2 text fields and a date picker.
* After creating a TODO, the user should be returned to the first screen and the table view should be reloaded via delegation. 
* Added TODOs should be shown on subsequent launches (see: NSKeyedArchiver, OR Core Data if you happen to be familiar with it already).

## Second Tab
There is only one screen required here, which will contain a list of all the user’s completed TODOs.
*  The cells on this screen will show i
* * the title label 
* * and the completed date. 
For this screen, you can simply check for the latest data whenever the user navigates to this screen (see: ViewController lifecycle functions).
