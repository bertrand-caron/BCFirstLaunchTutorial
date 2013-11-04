BCFirstLaunchTutorial
=====================

![Snapshot3](https://raw.github.com/bertrand-caron/BCFirstLaunchTutorial/master/Snapshots/Snapshot3.png)
![Snapshot4](https://raw.github.com/bertrand-caron/BCFirstLaunchTutorial/master/Snapshots/Snapshot4.png)

Installation
------------

- Drag the three files (BCFirstLaunchTutorial.h, BCFirstLaunchTutorial.m, PopoverView.xib) to your project


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
			andText:@"Click this text field. CLose this window to display the next one."];
```

Then to launch the Tutorial, call:
```
[myPopoverController launchTutorial];
```
Limitations
-----------

Currently, launching two tutorials at once will result in a painful duplication of all messages.
