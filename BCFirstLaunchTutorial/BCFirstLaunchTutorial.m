//
//  BCFirstLaunchTutorial.m
//  BCFirstLaunchTutorial
//
//  Created by Bertrand Caron on 04/11/2013.
//  Copyright (c) 2013 Bertrand Caron. All rights reserved.
//

#import "BCFirstLaunchTutorial.h"

@implementation BCFirstLaunchTutorial

@synthesize currentEvent,popoverObjects,popoverTexts,popoverTextView,popover,popoverView,button;


#pragma mark - Init
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
    
    //if this is the last event
    if (currentEvent ==[popoverObjects count])
    {
        //Add extra padding at the bottom of the popover's view
        [popover setContentSize:NSMakeSize([popover contentSize].width, [popover contentSize].height+20)];
        //Translate up the NSScrollView
        [[ [popoverTextView superview]superview] setFrameOrigin:
         NSMakePoint([[popoverTextView superview]superview].frame.origin.x,
                     [[popoverTextView superview]superview].frame.origin.y+20)];
        
        //Add a "do not show again" check box
        NSButton* but =[[NSButton alloc] initWithFrame:NSMakeRect(5, 5, 80, 15)] ;
        //[but setTitle:@"Do Not Show Again"];
        button=but;
        [but setButtonType:NSMomentaryLightButton];
        [but setBezelStyle:0];
        [but setBordered:NO];
        [but setAction:@selector(writeToUserDefaults)];
        //[but setFont:[NSFont fontWithName:@"Arial" size:9.0]];
        [but.cell setControlSize:NSMiniControlSize];
        [but setAttributedTitle:
         [[NSAttributedString alloc] initWithString:@"Do not show again"
                attributes:[NSDictionary dictionaryWithObjectsAndKeys:
             [NSFont fontWithName:@"Arial" size:9.0], NSFontAttributeName,
                    [NSColor headerColor], NSForegroundColorAttributeName,
                nil
                ]
          ]];
        
        //Add the button tot the view"s subviews
        [self.view addSubview:but];
        
        NSTrackingArea* trackingArea = [[NSTrackingArea alloc] initWithRect:[but frame]
                                                            options:(
                                                                     NSTrackingInVisibleRect
                                                            //      | NSTrackingEnabledDuringMouseDrag
                                                                     | NSTrackingMouseEnteredAndExited
                                                                     | NSTrackingActiveAlways
                                                                     )
                                                                      owner:self userInfo:nil];
        
        [but addTrackingArea:trackingArea];
    }
    
}

/**
Gets called everytime we close a Popover 
Close it, and calls the next Popover Event
*/
-(IBAction)closePopover:(id)sender
{
    [[self popover] close];
    
    //Undo the extra padding at the bottom of the popover's view
    //if the was the last event
    if (currentEvent ==[popoverObjects count])
    {
        [popover setContentSize:NSMakeSize([popover contentSize].width, [popover contentSize].height-20)];
        //Translate up the NSScrollView
        [[ [popoverTextView superview]superview] setFrameOrigin:
         NSMakePoint([[popoverTextView superview]superview].frame.origin.x,
                     [[popoverTextView superview]superview].frame.origin.y-20)];
    }
    
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
    
    //Fit the scroll View
    [scroll setFrame:(NSRect){
        [scroll frame].origin.x,[scroll frame].origin.y,
        [scroll frame].size.width,textViewHeight+4 		//Magic Number, depends on your font (I guess)
    }];
    
    //And then the popover
    [popover setContentSize:NSMakeSize([popover contentSize].width, scroll.frame.size.height+33)]; //Magic Number, depends on your customView dimensions
}

#pragma mark - "Do not Show Again " Label Customization via NSTrackingArea
- (void) mouseEntered:(NSEvent*)theEvent {
    //Set text color
    NSMutableAttributedString * attString =[[NSMutableAttributedString alloc] initWithAttributedString:[button attributedTitle]];
    [attString removeAttribute:NSForegroundColorAttributeName range:NSMakeRange(0,[attString string].length)];
    [attString addAttribute:NSForegroundColorAttributeName value:[NSColor darkGrayColor] range:NSMakeRange(0,[attString string].length)];
    [button setAttributedTitle:attString];
}

- (void) mouseExited:(NSEvent*)theEvent {
    //Set text color
    NSMutableAttributedString * attString =[[NSMutableAttributedString alloc] initWithAttributedString:[button attributedTitle]];
    [attString removeAttribute:NSForegroundColorAttributeName range:NSMakeRange(0,[attString string].length)];
    [attString addAttribute:NSForegroundColorAttributeName value:[NSColor headerColor] range:NSMakeRange(0,[attString string].length)];
    [button setAttributedTitle:attString];
}

#pragma mark - User Default Interactions
/**
Method called when the user clicks on the "Do not show again" dialog at the end of the tutorial
 */
-(void)writeToUserDefaults
{
    NSMutableAttributedString * attString =[[NSMutableAttributedString alloc] initWithAttributedString:[button attributedTitle]];
    [attString removeAttribute:NSForegroundColorAttributeName range:NSMakeRange(0,[attString string].length)];
    [attString addAttribute:NSForegroundColorAttributeName value:[NSColor blackColor] range:NSMakeRange(0,[attString string].length)];
    [button setAttributedTitle:attString];
    
    [self performSelector:@selector(closePopover:) withObject:self afterDelay:0.05];
    [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"dontShowTutorial"];
}

@end
