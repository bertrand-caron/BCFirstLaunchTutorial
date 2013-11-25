//
//  BCGuidedTourWindowController.m
//  BCFirstLaunchTutorial
//
//  Created by Bertrand Caron on 19/11/2013.
//  Copyright (c) 2013 Bertrand Caron. All rights reserved.
//

#import "BCGuidedTourWindowController.h"
#import "BCFadedInButton.h"
#import "BCRoundedLine.h"

#import "NSBezierPath+Bounce.h"
#import <QuartzCore/QuartzCore.h>

@implementation BCGuidedTourWindowController
@synthesize delegate;

- (id)initWithWindow:(NSWindow *)window
{
    self = [super initWithWindow:window];
    if (self) {
        // Initialization code here.
        titleArray = [NSMutableArray arrayWithCapacity:1];
        selectorArray = [NSMutableArray arrayWithCapacity:1];
    }
    return self;
}

- (id)initWithWindowNibName:(NSString *)windowNibName
{
    self = [super initWithWindowNibName:windowNibName];
    /*logo = [[NSImageView alloc]initWithFrame:NSMakeRect(800, 150, 400, 300)];
    [logo setImage:[NSImage imageNamed:@"Slice2"]];
    [[[self window] contentView] addSubview:logo];
    
    [NSAnimationContext beginGrouping];
    [[NSAnimationContext currentContext] setDuration:2.0f];
    [[logo animator] setFrameOrigin:NSMakePoint(0, 150)];
    [NSAnimationContext endGrouping];*/
    
    return self;
}

- (void)windowDidLoad
{
    [super windowDidLoad];
    
    // Implement this method to handle any initialization after your window controller's window has been loaded from its nib file.
}

-(void)awakeFromNib
{
    //[[[self window]contentView ] setWantsLayer:YES];
    //[ [[[self window]contentView ] layer] setBackgroundColor: [[NSColor whiteColor]CGColor] ];
    
    
    //Create a view for hosting the bouncing Layer and register it as a subview of the window's content
    NSView* bouncingView = [[NSView alloc]initWithFrame:NSMakeRect(90, 0, 240, 600)];
    [[[self window]contentView]addSubview:bouncingView];
    
    //Make the view layer-hosting
    CALayer* bounceLayer= [CALayer layer];
    //[bounceLayer setBackgroundColor:[[NSColor redColor]CGColor]];
    [bouncingView setLayer:bounceLayer];
    [bouncingView setWantsLayer:YES];
    
    
    //Create a sublayer that contains the image and is animated
    CALayer* testLayer = [CALayer layer];
    testLayer.frame=CGRectMake(0, 200, 206, 233);
    testLayer.contents = (id)([[NSImage imageNamed:@"Slice2"] CGImageForProposedRect:NULL context:nil hints:nil]);
    
    //Add the sublayer
    [bounceLayer addSublayer:testLayer];
    
    //Get the Animation Path
    
    NSDictionary* pathDict = [NSBezierPath bounceToPoint:NSMakePoint(0, 0)];
    
    NSBezierPath* path = [pathDict objectForKey:@"path"];
    
    //Then, Animate it
    [CATransaction begin];
    [CATransaction setCompletionBlock:^{
        //testLayer.position=CGPointMake(0, 200);
        [self performSelector:@selector(displayButtons) withObject:nil afterDelay:1.0];
    }];
    
        CAKeyframeAnimation *anim = [CAKeyframeAnimation animationWithKeyPath:@"position"];
        anim.path = [path quartzPath];
        anim.repeatCount = 0;
        anim.duration = [[pathDict objectForKey:@"duration"] floatValue];
        [bounceLayer addAnimation:anim forKey:@"bounce"];
    
    [CATransaction commit];
    
}

-(void)addButtonWithTitle:(NSString*)buttonTitle andAction:(NSString*)aSelectorString
{
    [titleArray addObject: buttonTitle];
    [selectorArray addObject:aSelectorString];
}

-(void)displayButtons
{
    int buttonHeight=75 ;
    
    //First, display a solid vertical bar spanning the buttons
    BCRoundedLine* roundedLine = [[BCRoundedLine alloc]initWithFrame:NSMakeRect(
        760,
        ([[self window] frame].size.height-titleArray.count*(buttonHeight))/2,
        2,
        [ [self window] frame].size.height-titleArray.count*(buttonHeight+7))];
    
    [roundedLine setColor:[NSColor darkGrayColor]];
    [[NSAnimationContext currentContext] setDuration:2.0];
    [[[self window] contentView] addSubview:roundedLine];
    [[roundedLine animator ] setAlphaValue:1.0];
    
    //Then, fade the buttons in
    __block BCFadedInButton* but;
    __block int currentHeight=0;
    __block float currentDelay=0;
    [titleArray enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        but = [[BCFadedInButton alloc]initWithFrame:(NSRect){350,400+currentHeight,400,buttonHeight}];
        [but setTitle:obj];
        [but setTarget:delegate];
        [but setAlphaValue:0.0];
        [but setAction:NSSelectorFromString([selectorArray objectAtIndex:idx])  ];
        
        [ [ [self window] contentView] addSubview:but];
        
        [but performSelector:@selector(fadeIn) withObject:nil afterDelay:currentDelay];
        
        currentHeight-=buttonHeight;
        currentDelay+=0.7;
    }];
    
}
//FIXME : Should be outsourced to a fadeIn method of the button
//Associated with a "isShown" to prevent Tracking events of a faded in button
/*-(void)displayButton:(NSButton*)but
{
    [NSAnimationContext beginGrouping];
    [[NSAnimationContext currentContext] setDuration:0.7];
    [[but animator] setAlphaValue:0.5];
    [NSAnimationContext endGrouping];
}*/

@end
