//
//  BCAppDelegate.m
//  BCFirstLaunchTutorial
//
//  Created by Bertrand Caron on 04/11/2013.
//  Copyright (c) 2013 Bertrand Caron. All rights reserved.
//

#import "BCAppDelegate.h"

@implementation BCAppDelegate

@synthesize textField,tableView,searchField,button,popoverController;

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    [self launchTutorial];
}


-(void)launchTutorial
{
    popoverController = [[BCFirstLaunchTutorial alloc] initFromXib];
    [popoverController  addNewEventWithObject:tableView
                                      andText:@"This is my TableView. Close this Popover to open the next one."];
    [popoverController  addNewEventWithObject:tableView
                                      andText:@"Enriquiring newline clipping issue.This is my first line. This is my second line. This is my third line. This is my fourth line."];
    [popoverController  addNewEventWithObject:button
                                      andText:@"Enriquiring newline clipping issue.<CR>\nThis is my first line.<CR>\nThis is my second line.<CR>\nThis is my third line.<CR>\nThis is my fourth line.Enriquiring newline clipping issue.<CR>\nThis is my first line.<CR>\nThis is my second line.<CR>\nThis is my third line.<CR>\nThis is my fourth line.<CR>\n\n\nHell\n\n\n\n\n\no"];
    [popoverController  addNewEventWithObject:button
                                      andText:@"This is my Button. It does amazing things."];
    [popoverController  addNewEventWithObject:searchField
                                      andText:@"This is my Search Field. I'd like the Popover to have a dynamic height. It now does."];
    [popoverController  addNewEventWithObject:textField
                                      andText:@"This is the last help bubble. The tutorial will be done when you close it.You can always launch it again."];
    
    [popoverController proceedToNextPopoverEvent];
}

@end
