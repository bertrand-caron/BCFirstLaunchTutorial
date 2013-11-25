//
//  BCRoundedLine.m
//  BCFirstLaunchTutorial
//
//  Created by Bertrand Caron on 23/11/2013.
//  Copyright (c) 2013 Bertrand Caron. All rights reserved.
//

#import "BCRoundedLine.h"

@implementation BCRoundedLine

@synthesize color;

- (id)initWithFrame:(NSRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code here.
        [self setAlphaValue:0.0];
    }
    return self;
}

- (void)drawRect:(NSRect)dirtyRect
{
    [super drawRect:dirtyRect];
	
    // Drawing code here.
    NSBezierPath* path = [NSBezierPath bezierPathWithRoundedRect:dirtyRect xRadius:3.0 yRadius:3.0];
    [color set];
    [path fill];

}

@end
