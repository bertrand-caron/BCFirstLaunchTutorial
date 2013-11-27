//
//  NSImage+BCAddReflection.h
//  BCFirstLaunchTutorial
//
//  Courtesy of : Agile Developer, Berlin, Germany
//  Source : MKAddReflection http://pegolon.wordpress.com/2011/01/20/adding-a-reflection-to-an-nsimage/
//  Category name have been changed for convenience, no ownership claimed
//

#import <Cocoa/Cocoa.h>

@interface NSImage (BCAddReflection)

/**
Returns an NSImage with the reflection
 */
- (NSImage*) addReflection:(CGFloat)percentage;


/**
Returns just the reflection without the NSImage that generated it.
 */
- (NSImage*) getReflection:(CGFloat)percentage;
@end
