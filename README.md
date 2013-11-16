BCFirstLaunchTutorial
=====================

![Snapshot5](https://raw.github.com/bertrand-caron/BCFirstLaunchTutorial/master/Snapshots/Snapshot5.png)

Installation
------------

- Drag the five files from the BCFirstTimeLaunch directory (BCFirstLaunchTutorial.\*, PopoverView.xib, BCFadedInButton.\*) to your project.

Usage
-----

###Init the controller
```
myPopoverController = [[BCFirstLaunchTutorial alloc] initFromXIB];
```

###Create Tutorial Trajectory
The tutorial will be made of a succession of `NSPopover`s appearing, pointing to objects and displaying a text of your choosing.
The object needs to be able to respond to the selector `bounds`to be usable.

To add an event to the trajectory, use :
```
[myPopoverController 	addEventWithObject: myTextField
			andText:@"Click this text field. Close this window to display the next one."];
```

Then to launch the Tutorial, simply call:
```
[myPopoverController proceedToNextPopoverEvent];
```

To go to a given event in the trajectory, use the property `@property int currentEvent` (NB : Numbered From 0 !)
For instance : 
```
[myPopoverController setCurrentEvent:0]; 		//Reset the inner loop to the first event 
[myPopoverController proceedToNextPopoverEvent];	//Then relaunch it
```

To abort the tutorial : Wait For It !

Limitations
-----------

Currently, launching two tutorials at once will result in a painful duplication of all messages.
