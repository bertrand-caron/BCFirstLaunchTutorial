//
//  BCGuidedTourWindowController.h
//  BCFirstLaunchTutorial
//
//  Created by Bertrand Caron on 19/11/2013.
//  Copyright (c) 2013 Bertrand Caron. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "BCFadedInButton.h"

@interface BCGuidedTourWindowController : NSWindowController <BCFadedInButtonDelegate>
{
    NSMutableArray* titleArray;
    NSMutableArray* selectorArray;
}

@property (strong) id delegate;
@property NSString* logoString;
@property NSDictionary* attributes;

- (id)initWithWindow:(NSWindow *)window;
-(id)initWithWindowNibName:(NSString *)windowNibName andLogo:(NSString*)logo;

-(void)addButtonWithTitle:(NSString*)buttonTitle andAction:(NSString*)aSelectorString;
-(void)displayButtons;

@end
