//
//  BCFirstLaunchTutorial.m
//  BCFirstLaunchTutorial
//
//  Created by Bertrand Caron on 04/11/2013.
//  Copyright (c) 2013 Bertrand Caron. All rights reserved.
//

#import "BCFirstLaunchTutorial.h"

@implementation BCFirstLaunchTutorial

@synthesize currentEvent,popoverObjects,popoverTexts,popoverTextView,popover,popoverView;


/**
Only way to init the PopoverController
*/
-(id)initFromXib
{
    self = [super init];
    if (self)
    {   currentEvent=0;
        popoverObjects = [NSMutableArray arrayWithCapacity:1];
        popoverTexts = [NSMutableArray arrayWithCapacity:1];
        [ NSBundle loadNibNamed:@"PopoverView" owner:self];
        popover = [[NSPopover alloc]init];
        [popover setContentViewController:self];
    }
    return self;
}

/**
Main Method called by the programmer to set up the tutorial
*/
-(void)addNewEventWithObject:(id)anObject andText:(NSString*)aText
{
    [popoverObjects addObject:anObject];
    [popoverTexts addObject:aText];
}

-(void)proceedToNextPopoverEvent
{
    //If there are no more events, return
    if (currentEvent ==[popoverObjects count])
    {
        return;
    }
    
    //Else, retrieve the object and texts and trigger the NSPopover
    id popoverObject = [popoverObjects objectAtIndex:currentEvent];
    if ([ popoverObject respondsToSelector:@selector(bounds)])
    {   [popover showRelativeToRect:[popoverObject bounds] ofView:popoverObject preferredEdge:NSMaxYEdge];
        [popoverTextView setString:[popoverTexts objectAtIndex:currentEvent]];
    }
    currentEvent+=1;
}

/**
Gets called everytime we close a Popover 
Close it, and calls the next Popover Event
*/
-(IBAction)closePopover:(id)sender
{
    [[self popover] close];
    [self proceedToNextPopoverEvent];
}

@end
