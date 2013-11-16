//
//  BCFadedInButton.m
//  BCFirstLaunchTutorial
//
//  Created by Bertrand Caron on 16/11/2013.
//  Copyright (c) 2013 Bertrand Caron. All rights reserved.
//

#import "BCFadedInButton.h"

@implementation BCFadedInButton

- (id)initWithFrame:(NSRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code here.
        [self addTrackingArea:[[NSTrackingArea alloc] initWithRect:[self frame] options:NSTrackingInVisibleRect| NSTrackingMouseEnteredAndExited | NSTrackingActiveAlways owner:self userInfo:nil]];
        [self setAlphaValue:0.5];
    }
    return self;
}


-(void)awakeFromNib
{
    [self addTrackingArea:[[NSTrackingArea alloc] initWithRect:[self frame] options:NSTrackingInVisibleRect| NSTrackingMouseEnteredAndExited | NSTrackingActiveAlways owner:self userInfo:nil]];
    [self setAlphaValue:0.5];
}

- (void)drawRect:(NSRect)dirtyRect
{
	[super drawRect:dirtyRect];
	
    // Drawing code here.
}

- (void)mouseEntered:(NSEvent *)theEvent
{
    [self setAlphaValue:1.0];
}
- (void)mouseExited:(NSEvent *)theEvent
{
    [self setAlphaValue:0.5];
}

@end