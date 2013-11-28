//
//  BCFadedInButton.h
//  BCFirstLaunchTutorial
//
//  Created by Bertrand Caron on 16/11/2013.
//  Copyright (c) 2013 Bertrand Caron. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@protocol BCFadedInButtonDelegate

-(NSDictionary*)attributes;

@end

@interface BCFadedInButton : NSButton
{
    float defautAlphaValue;
    float highlightedAlphaValue;
}
@property BOOL isShown;
@property id <BCFadedInButtonDelegate> delegate;

-(void)fadeIn;


+(CGFloat)heightWithAttributes:(NSDictionary*)attributes;
@end
