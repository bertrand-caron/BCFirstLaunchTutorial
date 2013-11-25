//
//  NSBezierPath+Bounce.m
//  BCFirstLaunchTutorial
//
//  Created by Bertrand Caron on 24/11/2013.
//  Copyright (c) 2013 Bertrand Caron. All rights reserved.
//

#import "NSBezierPath+Bounce.h"

@implementation NSBezierPath (Bounce)

+(NSDictionary*)bounceToPoint:(NSPoint)aPoint
{
    float duration=0.0;
    
    float y0=600;
    float g=2000.0; //m.s-2
    
    float K = 0.2;  //Bouncing coefficient
    float bounceThreshold= 1.0/100;
    int bounceMax = log(bounceThreshold)/log(K)+1;
    
    float t1 = sqrtf((2*y0)/g);
    float deltaT=t1/200;
    duration+=t1;

    NSBezierPath* path = [NSBezierPath bezierPath];
    
    [path moveToPoint:NSMakePoint(0.0, y0)];
    
    for (float t=0.0;t<=t1;t+=deltaT)
    {
        [path lineToPoint:NSMakePoint(0.0,y0-0.5*g*t*t)];
    }
    
    int bounced=1;
    float v0=sqrtf(K*2*g*y0);
    float t0;
    while (bounced<=bounceMax)
    {   t0=(2*v0)/g;
        duration+=t0;
        for (float t=0;t<=t0;t+=deltaT)
        {
            [path lineToPoint:NSMakePoint(0.0,v0*t-0.5*g*t*t)];
        }
        v0=sqrtf(K)*v0;
        bounced+=1;
    }
    
    NSAffineTransform *transform = [NSAffineTransform transform];
    [transform translateXBy: aPoint.x yBy: aPoint.y];
    
    [path transformUsingAffineTransform: transform ];
    //Then :
    return [NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithFloat:duration],@"duration",path,@"path", nil];
}

- (CGPathRef)quartzPath
{
    int i, numElements;
    
    // Need to begin a path here.
    CGPathRef           immutablePath = NULL;
    
    // Then draw the path elements.
    numElements = (int)[self elementCount];
    if (numElements > 0)
    {
        CGMutablePathRef    path = CGPathCreateMutable();
        NSPoint             points[3];
        BOOL                didClosePath = YES;
        
        for (i = 0; i < numElements; i++)
        {
            switch ([self elementAtIndex:i associatedPoints:points])
            {
                case NSMoveToBezierPathElement:
                    CGPathMoveToPoint(path, NULL, points[0].x, points[0].y);
                    break;
                    
                case NSLineToBezierPathElement:
                    CGPathAddLineToPoint(path, NULL, points[0].x, points[0].y);
                    didClosePath = NO;
                    break;
                    
                case NSCurveToBezierPathElement:
                    CGPathAddCurveToPoint(path, NULL, points[0].x, points[0].y,
                                          points[1].x, points[1].y,
                                          points[2].x, points[2].y);
                    didClosePath = NO;
                    break;
                    
                case NSClosePathBezierPathElement:
                    CGPathCloseSubpath(path);
                    didClosePath = YES;
                    break;
            }
        }
        
        // Be sure the path is closed or Quartz may not do valid hit detection.
        if (!didClosePath)
            CGPathCloseSubpath(path);
        
        immutablePath = CGPathCreateCopy(path);
        CGPathRelease(path);
    }
    
    return immutablePath;
}

@end
