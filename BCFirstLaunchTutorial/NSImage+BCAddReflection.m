//
//  NSImage+BCAddReflection.h
//  BCFirstLaunchTutorial
//
//  Courtesy of : Agile Developer, Berlin, Germany
//  Source : MKAddReflection http://pegolon.wordpress.com/2011/01/20/adding-a-reflection-to-an-nsimage/
//  Category name have been changed for convenience, no ownership claimed
//

#import "NSImage+BCAddReflection.h"

@implementation NSImage (BCAddReflection)

- (NSImage*) addReflection:(CGFloat)percentage
{
    NSAssert(percentage > 0 && percentage <= 1.0, @"Please use percentage between 0 and 1");
    CGRect offscreenFrame = CGRectMake(0, 0, self.size.width, self.size.height*(1.0+percentage));
    NSBitmapImageRep * offscreen = [[NSBitmapImageRep alloc] initWithBitmapDataPlanes:NULL
                                                                           pixelsWide:offscreenFrame.size.width
                                                                           pixelsHigh:offscreenFrame.size.height
                                                                        bitsPerSample:8
                                                                      samplesPerPixel:4
                                                                             hasAlpha:YES
                                                                             isPlanar:NO
                                                                       colorSpaceName:NSDeviceRGBColorSpace
                                                                         bitmapFormat:0
                                                                          bytesPerRow:offscreenFrame.size.width * 4
                                                                         bitsPerPixel:32];
    
    [NSGraphicsContext saveGraphicsState];
    [NSGraphicsContext setCurrentContext:[NSGraphicsContext graphicsContextWithBitmapImageRep:offscreen]];
    
    [[NSColor clearColor] set];
    NSRectFill(offscreenFrame);
    
    NSGradient * fade = [[NSGradient alloc] initWithStartingColor:[NSColor colorWithCalibratedWhite:1.0 alpha:0.2] endingColor:[NSColor clearColor]];
    CGRect fadeFrame = CGRectMake(0, 0, self.size.width, offscreen.size.height - self.size.height);
    [fade drawInRect:fadeFrame angle:270.0];
    
    NSAffineTransform* transform = [NSAffineTransform transform];
    [transform translateXBy:0.0 yBy:fadeFrame.size.height];
    [transform scaleXBy:1.0 yBy:-1.0];
    [transform concat];
    
    // Draw the image over the gradient -> becomes reflection
    [self drawAtPoint:NSMakePoint(0, 0) fromRect:CGRectMake(0, 0, self.size.width, self.size.height) operation:NSCompositeSourceIn fraction:1.0];
    
    [transform invert];
    [transform concat];
    
    // Draw the original image
    [self drawAtPoint:CGPointMake(0, offscreenFrame.size.height - self.size.height) fromRect:NSZeroRect operation:NSCompositeSourceOver fraction:1.0];
    
    [NSGraphicsContext restoreGraphicsState];
    
    NSImage * imageWithReflection = [[NSImage alloc] initWithSize:offscreenFrame.size];
    [imageWithReflection addRepresentation:offscreen];
    
    return imageWithReflection;
}

- (NSImage*) getReflection:(CGFloat)percentage
{
    NSAssert(percentage > 0 && percentage <= 1.0, @"Please use percentage between 0 and 1");
    CGRect offscreenFrame = CGRectMake(0, 0, self.size.width, self.size.height*(percentage));
    NSBitmapImageRep * offscreen = [[NSBitmapImageRep alloc] initWithBitmapDataPlanes:NULL
                                                                           pixelsWide:offscreenFrame.size.width
                                                                           pixelsHigh:offscreenFrame.size.height
                                                                        bitsPerSample:8
                                                                      samplesPerPixel:4
                                                                             hasAlpha:YES
                                                                             isPlanar:NO
                                                                       colorSpaceName:NSDeviceRGBColorSpace
                                                                         bitmapFormat:0
                                                                          bytesPerRow:offscreenFrame.size.width * 4
                                                                         bitsPerPixel:32];
    
    [NSGraphicsContext saveGraphicsState];
    [NSGraphicsContext setCurrentContext:[NSGraphicsContext graphicsContextWithBitmapImageRep:offscreen]];
    
    [[NSColor clearColor] set];
    NSRectFill(offscreenFrame);
    
    NSGradient * fade = [[NSGradient alloc] initWithStartingColor:[NSColor colorWithCalibratedWhite:1.0 alpha:0.2] endingColor:[NSColor clearColor]];
    CGRect fadeFrame = CGRectMake(0, 0, self.size.width, offscreen.size.height);
    [fade drawInRect:fadeFrame angle:270.0];
    
    NSAffineTransform* transform = [NSAffineTransform transform];
    [transform translateXBy:0.0 yBy:fadeFrame.size.height];
    [transform scaleXBy:1.0 yBy:-1.0];
    [transform concat];
    
    // Draw the image over the gradient -> becomes reflection
    [self drawAtPoint:NSMakePoint(0, 0) fromRect:CGRectMake(0, 0, self.size.width, self.size.height) operation:NSCompositeSourceIn fraction:1.0];
    
    [transform invert];
    [transform concat];
    
    // Draw the original image
    //[self drawAtPoint:CGPointMake(0, offscreenFrame.size.height - self.size.height) fromRect:NSZeroRect operation:NSCompositeSourceOver fraction:1.0];
    
    [NSGraphicsContext restoreGraphicsState];
    
    NSImage * imageWithReflection = [[NSImage alloc] initWithSize:offscreenFrame.size];
    [imageWithReflection addRepresentation:offscreen];
    
    return imageWithReflection;
}

@end
