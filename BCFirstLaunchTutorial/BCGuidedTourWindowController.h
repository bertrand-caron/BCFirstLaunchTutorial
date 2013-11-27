//
//  BCGuidedTourWindowController.h
//  BCFirstLaunchTutorial
//
//  Created by Bertrand Caron on 19/11/2013.
//  Copyright (c) 2013 Bertrand Caron. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface BCGuidedTourWindowController : NSWindowController
{
    NSMutableArray* titleArray;
    NSMutableArray* selectorArray;
    NSImageView* logo;
}

@property (strong) id delegate;

- (id)initWithWindow:(NSWindow *)window;

-(void)addButtonWithTitle:(NSString*)buttonTitle andAction:(NSString*)aSelectorString;
-(void)displayButtons;

@end
