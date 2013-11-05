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
    [self resize];
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

/**
 
*/
-(void)resize
{
    //Spawn the layout and container for convenience
    NSLayoutManager* layout = [popoverTextView layoutManager];
    NSTextContainer* container = [popoverTextView textContainer];
    
    NSScrollView* scroll = (NSScrollView*)[[popoverTextView superview ]superview];
    
    //Set a 0 padding for the container
    [container setLineFragmentPadding:0.0];
    
    //Set the font and size for the container
    [[popoverTextView textStorage] addAttribute:NSFontAttributeName value:[NSFont fontWithName:@"Arial" size:11.0]
                        range:NSMakeRange(0, [[popoverTextView textStorage] length])];
    
    //Get glyph range for boundingRectForGlyphRange:
    NSRange range = [[popoverTextView layoutManager] glyphRangeForTextContainer:container];
    
    //Finally get the height
    float textViewHeight = [[popoverTextView layoutManager] boundingRectForGlyphRange:range
                                           inTextContainer:container].size.height;
    
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"\n" options:NSRegularExpressionCaseInsensitive error:nil];
    NSUInteger numberOfMatches = [regex numberOfMatchesInString:[popoverTextView string] options:0 range:NSMakeRange(0, [[popoverTextView string] length])];
    //textViewHeight=textViewHeight+6*numberOfMatches;
    /*while (range.location != NSNotFound)
    {   //Add extra padding if new line character to prevent clipping, empirically needed
        textViewHeight=textViewHeight+2;
    }*/
    
    //<DEBUG>
    NSLog(@"textViewHeight : %f",textViewHeight);
    NSLog(@"[layout usedRectForTextContainer:container] : %@",NSStringFromRect([[popoverTextView layoutManager]usedRectForTextContainer:[popoverTextView textContainer]]));
    //</DEBUG>
    
    //Fit the scroll View
    [scroll setFrame:(NSRect){
        [scroll frame].origin.x,[scroll frame].origin.y,
        [scroll frame].size.width,textViewHeight+4 		//Magic Number, depends on your font (I guess)
    }];
    
    //And then the popover
    [popover setContentSize:NSMakeSize([popover contentSize].width, scroll.frame.size.height+33)]; //Magic Number, depends on your customView dimensions
}

@end
