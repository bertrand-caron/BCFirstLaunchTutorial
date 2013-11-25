//
//  BCAppDelegate.m
//  BCFirstLaunchTutorial
//
//  Created by Bertrand Caron on 04/11/2013.
//  Copyright (c) 2013 Bertrand Caron. All rights reserved.
//

#import "BCAppDelegate.h"

@implementation BCAppDelegate

@synthesize textField,tableView,searchField,button,popoverController,guidedTourWindowController;

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    
    guidedTourWindowController = [[BCGuidedTourWindowController alloc]initWithWindowNibName:@"GuidedTourWindow"];
    [[guidedTourWindowController window] setTitle:@"Welcome to my App !"];
    //[[[guidedTourWindowController window] contentView]setWantsLayer:YES];
    
    /*NSImage* my = [NSImage imageNamed:@"Slice1"];
    [[[guidedTourWindowController window]  contentView] layer].contents= my;*/
    
    [guidedTourWindowController addButtonWithTitle:@"Tutorial" andAction:@"launchTutorial"];
    [guidedTourWindowController addButtonWithTitle:@"Get Started" andAction:@"getStarted"];
    [guidedTourWindowController addButtonWithTitle:@"Web Site" andAction:@"launchWebSite"];
    [guidedTourWindowController addButtonWithTitle:@"Help" andAction:@"openHelp"];
    
    [guidedTourWindowController setDelegate:self];
    //[guidedTourWindowController displayButtons];
    [[guidedTourWindowController window] makeKeyAndOrderFront:self];
    
    
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

-(void)getStarted
{
    [[[guidedTourWindowController window] animator ] close];
    [_window makeKeyAndOrderFront:self];
    [self launchTutorial];
}

-(void)launchWebSite
{
    [[NSWorkspace sharedWorkspace] openURL:[NSURL URLWithString:@"http://lmgtfy.com/?q=website"]];
}

-(void)openHelp
{
    [[NSWorkspace sharedWorkspace] openURL:[NSURL URLWithString:@"http://lmgtfy.com/?q=help"]];
}

@end
