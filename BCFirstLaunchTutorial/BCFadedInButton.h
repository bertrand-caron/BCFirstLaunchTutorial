//
//  BCFadedInButton.h
//  BCFirstLaunchTutorial
//
//  Created by Bertrand Caron on 16/11/2013.
//  Copyright (c) 2013 Bertrand Caron. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface BCFadedInButton : NSButton
{
    float defautAlphaValue;
    float highlightedAlphaValue;
}
@property BOOL isShown;

-(void)fadeIn;

@end
