//
//  BCFirstLaunchTutorial.h
//  BCFirstLaunchTutorial
//
//  Created by Bertrand Caron on 04/11/2013.
//  Copyright (c) 2013 Bertrand Caron. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BCFirstLaunchTutorial : NSViewController

@property int currentEvent;
@property  NSMutableArray* popoverObjects;
@property  NSMutableArray* popoverTexts;

@property  IBOutlet NSPopover* popover;
@property  IBOutlet NSTextView* popoverTextView;
@property  IBOutlet NSView* popoverView;
@property IBOutlet NSButton* button;

-(id)initFromXib;
-(void)addNewEventWithObject:(id)anObject andText:(NSString*)aText;
-(void)proceedToNextPopoverEvent;
-(IBAction)closePopover:(id)sender;

@end
