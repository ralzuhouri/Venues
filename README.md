# Venues App: Assignment Documentation

## Implementation choices

* The main screen shows the 20 most popular location in Amsterdam
* Clicking on the location icon next to 'Amsterdam' in the top bar causes the location to be updated, after which a new search is performed
* In case of any network error, the error is displayed in red
* The refresh button (top bar, right) causes a new search to be triggered
* typing anything in the search bar causes a new search query to be triggered with the given keyword
* Clicking the 'info' icon of any location in that list, causes the detail view to be shown
    * In the detail view, the 10 most popular pictures are shown
    * Information such as categories, address and distance are also shown

## Warnings
A warning is displayed when running the app:

> A navigationDestination for “Venues.Venue” was declared earlier on the stack. Only the destination declared closest to the root view of the stack will be used.

This is causes by many navigation links being shown inside a for each loop. It's believed to be a bug from Apple's side: https://developer.apple.com/forums/thread/707592
The warning doesn't cause any crash or any undesired behavior. For the purpose of the assignment, I will not investigate this bug any further.

