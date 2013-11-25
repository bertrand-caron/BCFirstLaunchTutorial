//
//  NSBezierPath+Bounce.h
//  BCFirstLaunchTutorial
//
//  Created by Bertrand Caron on 24/11/2013.
//  Copyright (c) 2013 Bertrand Caron. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface NSBezierPath (Bounce)

+(NSDictionary*)bounceToPoint:(NSPoint)aPoint;
- (CGPathRef)quartzPath;


@end
