//
//  BCAppDelegate.m
//  BCFirstLaunchTutorial
//
//  Created by Bertrand Caron on 04/11/2013.
//  Copyright (c) 2013 Bertrand Caron. All rights reserved.
//

#import "BCAppDelegate.h"
#import "NSImage+BCAddReflection.h"

@implementation BCAppDelegate

@synthesize textField,tableView,searchField,button,popoverController,guidedTourWindowController;

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    
    guidedTourWindowController = [[BCGuidedTourWindowController alloc]initWithWindowNibName:@"GuidedTourWindow" andLogo:@"Slice3"];
    [[guidedTourWindowController window] setTitle:@"Welcome to my App !"];
    
    [guidedTourWindowController addButtonWithTitle:@"Tutorial" andAction:@"launchTutorial"];
    [guidedTourWindowController addButtonWithTitle:@"Get Started" andAction:@"getStarted"];
    /*[guidedTourWindowController addButtonWithTitle:@"Web Site" andAction:@"launchWebSite"];
    [guidedTourWindowController addButtonWithTitle:@"Help" andAction:@"openHelp"];
    [guidedTourWindowController addButtonWithTitle:@"Extra" andAction:@""];
    [guidedTourWindowController addButtonWithTitle:@"Again" andAction:@""];
    [guidedTourWindowController addButtonWithTitle:@"Again2" andAction:@""];*/
    
    [guidedTourWindowController setDelegate:self];
    [[guidedTourWindowController window] makeKeyAndOrderFront:self];
    
    [self test];
    
}

-(void)setUpTutorial
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
}

-(void)launchTutorial
{
    [self setUpTutorial];
    [[[guidedTourWindowController window] animator ] close];
    [_window makeKeyAndOrderFront:self];
    [popoverController proceedToNextPopoverEvent];
}

-(void)getStarted
{
    [[[guidedTourWindowController window] animator ] close];
    [_window makeKeyAndOrderFront:self];
}

-(void)launchWebSite
{
    [[NSWorkspace sharedWorkspace] openURL:[NSURL URLWithString:@"http://lmgtfy.com/?q=website"]];
}

-(void)openHelp
{
    [[NSWorkspace sharedWorkspace] openURL:[NSURL URLWithString:@"http://lmgtfy.com/?q=help"]];
}

-(void)test
{
    /*NSImage* img = [NSImage imageNamed:@"Slice2"];
    NSImage* reflection = [img getReflection:0.4];
    NSImageView* imgView = [[NSImageView alloc] initWithFrame:NSMakeRect(0, 0, 100, 100)];
    [[[self window] contentView ] addSubview:imgView];*/
    
}

@end
