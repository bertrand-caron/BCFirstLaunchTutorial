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
    /*guidedTourWindowController = [[BCGuidedTourWindowController alloc]initWithWindowNibName:@"GuidedTourWindow"];
    [[[guidedTourWindowController window] contentView]setWantsLayer:YES];*/
    
}


-(void)launchTutorial
{
    popoverController = [[BCFirstLaunchTutorial alloc] initFromXib];
    [popoverController  addNewEventWithObject:tableView
                                      andText:@"This is my TableView. Close this Popover to open the next one."];
    [popoverController  addNewEventWithObject:button
                                      andText:@"This is my Button. It does amazing things."];
    [popoverController  addNewEventWithObject:searchField
                                      andText:@"This is my Search Field. I'd like the Popover to have a dynamic height. It now does."];
    [popoverController  addNewEventWithObject:textField
                                      andText:@"This is the last help bubble. The tutorial will be done when you close it.You can always launch it again."];
    
    [popoverController proceedToNextPopoverEvent];
}

@end
