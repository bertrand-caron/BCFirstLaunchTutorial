//
//  BCRoundedLine.h
//  BCFirstLaunchTutorial
//
//  Created by Bertrand Caron on 23/11/2013.
//  Copyright (c) 2013 Bertrand Caron. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface BCRoundedLine : NSView

@property NSColor* color;

- (void)drawRect:(NSRect)dirtyRect;

@end
