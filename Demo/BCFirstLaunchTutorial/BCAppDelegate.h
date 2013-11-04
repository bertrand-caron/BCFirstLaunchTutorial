//
//  BCAppDelegate.h
//  BCFirstLaunchTutorial
//
//  Created by Bertrand Caron on 04/11/2013.
//  Copyright (c) 2013 Bertrand Caron. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "BCFirstLaunchTutorial.h"

@interface BCAppDelegate : NSObject <NSApplicationDelegate>

@property  IBOutlet NSWindow *window;

@property IBOutlet NSTableView* tableView;
@property IBOutlet NSSearchField* searchField;
@property IBOutlet NSTextField* textField;
@property IBOutlet NSButton* button;

@property (assign) BCFirstLaunchTutorial* popoverController;


@end
