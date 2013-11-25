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

- (id)initWithFrame:(NSRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code here.
        
        defautAlphaValue=0.5;
        highlightedAlphaValue=1.0;
        isShown=NO;
        
        [self setBezelStyle:NSRegularSquareBezelStyle];
        
        
        [self addTrackingArea:[[NSTrackingArea alloc] initWithRect:[self frame] options:NSTrackingInVisibleRect| NSTrackingMouseEnteredAndExited | NSTrackingActiveAlways owner:self userInfo:nil]];
        [self setAlphaValue:defautAlphaValue];
    }
    return self;
}


-(void)awakeFromNib
{
    defautAlphaValue=0.5;
    highlightedAlphaValue=1.0;
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
@end
