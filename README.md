# Save Data in Sqlite DB and solution of following task:

TASK 1
Create a left navigation drawer like Gmail:
Reference Link: https://developer.android.com/training/implementing-navigation/nav-drawer.html

TASK 2
Navigation Drawer will have 2 options:
All Matches 
Saved Matches
Note: "All Matches" and "Saved Matches" will be fragments

"All Matches" fragment will show the list of all matches as in the following API:
https://api.foursquare.com/v2/venues/search?ll=40.7484,-73.9857&oauth_token=Auth_Token"

You can use the following tool to format the JSON:
http://jsonviewer.stack.hu/

TASK 3
Each match will have a star next to it. 
When clicked on the star will save the match in the SQLite database in the app, and make the Star active. You can store ID and the Name of the match.

TASK 4
In the second fragment "Save Matches", you will have to show saved matches from the local database.
Clicking on the star again will delete the match from the Saved Matches and make the Star inactive.

TASK 5
In "All Matches" list, Star will be shown active or inactive, depending on if the data is stored in the database or not.
