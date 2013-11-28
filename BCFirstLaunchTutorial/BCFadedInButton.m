//
//  BCFadedInButton.m
//  BCFirstLaunchTutorial
//
//  Created by Bertrand Caron on 16/11/2013.
//  Copyright (c) 2013 Bertrand Caron. All rights reserved.
//

#import "BCFadedInButton.h"

@implementation BCFadedInButton

@synthesize isShown;
@synthesize delegate;

- (id)initWithFrame:(NSRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code here.
        
        defautAlphaValue=0.5;
        highlightedAlphaValue=1.0;
        isShown=NO;
        [self setBordered:NO];
        [self setAlignment:NSRightTextAlignment];
        [self setButtonType:NSMomentaryChangeButton];
        [self setBezelStyle:NSRegularSquareBezelStyle];
        //[self.cell setFont:[NSFont fontWithName:@"Arial Rounded MT Bold" size:53]];
        
        [self addTrackingArea:[[NSTrackingArea alloc] initWithRect:[self frame] options:NSTrackingInVisibleRect| NSTrackingMouseEnteredAndExited | NSTrackingActiveAlways owner:self userInfo:nil]];
        [self setAlphaValue:defautAlphaValue];
    }
    return self;
}


-(void)awakeFromNib
{
    defautAlphaValue=0.5;
    highlightedAlphaValue=1.0;
    [self setBordered:NO];
    
    [self addTrackingArea:[[NSTrackingArea alloc] initWithRect:[self frame] options:NSTrackingInVisibleRect| NSTrackingMouseEnteredAndExited | NSTrackingActiveAlways owner:self userInfo:nil]];
    [self setAlphaValue:defautAlphaValue];
}

- (void)drawRect:(NSRect)dirtyRect
{
	[super drawRect:dirtyRect];
	
    // Drawing code here.
}

- (void)mouseEntered:(NSEvent *)theEvent
{
    if (isShown)
    {
        [self setAlphaValue:highlightedAlphaValue];
    }
}
- (void)mouseExited:(NSEvent *)theEvent
{
    if(isShown)
    {
        [self setAlphaValue:defautAlphaValue];
    }
}
-(void)mouseDown:(NSEvent *)theEvent
{
    if (isShown)
    {   [self setWantsLayer:YES];
        [self setAlphaValue:defautAlphaValue/2];

        [self performSelector:@selector(fadeInFromClick) withObject:nil afterDelay:0.05];
        //[self setAlphaValue:0.1];
        [super mouseDown:theEvent];
    }
}

-(void)fadeInFromClick
{
    [NSAnimationContext beginGrouping];
    [[NSAnimationContext currentContext] setDuration:0.1];
    [[self animator] setAlphaValue:highlightedAlphaValue];
    [NSAnimationContext endGrouping];
}

-(void)fadeIn
{
    [NSAnimationContext beginGrouping];
    [[NSAnimationContext currentContext] setDuration:0.7];
    [[self animator] setAlphaValue:defautAlphaValue];
    [NSAnimationContext endGrouping];
    isShown=YES;
}

- (void)setTitle:(NSString*)aString
{
    //Get the current frame
    NSRect frame = [self frame];
    
    //Call super
    //[super setTitle:aString];
    
    
    [super setAttributedTitle:
        [[NSAttributedString alloc]initWithString:aString attributes:[delegate attributes]]
    ];
    
    //Get the Size
    NSSize newSize = [aString sizeWithAttributes:[delegate attributes]];
    //set the frame origin
    [self setFrameSize:NSMakeSize(newSize.width+30, frame.size.height)];
    [self setFrameOrigin:NSMakePoint(frame.origin.x+frame.size.width-(newSize.width+30), frame.origin.y)];
}

+(CGFloat)heightWithAttributes:(NSDictionary*)attributes
{
    return [@"Test" sizeWithAttributes:attributes].height;
}
@end

