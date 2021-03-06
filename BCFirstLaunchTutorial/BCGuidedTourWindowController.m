//
//  BCGuidedTourWindowController.m
//  BCFirstLaunchTutorial
//
//  Created by Bertrand Caron on 19/11/2013.
//  Copyright (c) 2013 Bertrand Caron. All rights reserved.
//

#import "BCGuidedTourWindowController.h"
#import "BCRoundedLine.h"

#import "NSBezierPath+Bounce.h"
#import <QuartzCore/QuartzCore.h>
#import "NSImage+BCAddReflection.h"

@implementation BCGuidedTourWindowController
@synthesize delegate;
@synthesize logoString;
@synthesize attributes;

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

-(id)initWithWindowNibName:(NSString *)windowNibName andLogo:(NSString*)logo
{
    self = [super initWithWindowNibName:windowNibName];
    logoString = logo;
    return self;
}

- (void)windowDidLoad
{
    [super windowDidLoad];
    
    // Implement this method to handle any initialization after your window controller's window has been loaded from its nib file.
}

-(void)awakeFromNib
{
    //White a white background layer by getting the windos's content view to be layer hosting
    CALayer* backgroundLayer = [CALayer layer];
    [[[self window]contentView ] setLayer:backgroundLayer];
    [[[self window]contentView ] setWantsLayer:YES];
    [ [[[self window]contentView ] layer] setBackgroundColor: [[NSColor whiteColor]CGColor] ];
    
    
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
    NSImage* img = [NSImage imageNamed: logoString];
    testLayer.frame=CGRectMake(0, 200, img.size.width, img.size.height);
    testLayer.contents = (id)([ img CGImageForProposedRect:NULL context:nil hints:nil]);
    
    //Now, deal with the shadow
    CALayer* shadowLayer = [CALayer layer];
    NSImage* reflection = [img getReflection:0.4];
    shadowLayer.frame=CGRectMake(0, 100, reflection.size.width, reflection.size.height);
    shadowLayer.contents = (id)([ reflection CGImageForProposedRect:NULL context:nil hints:nil]);
    
    //Add the sublayer
    [bounceLayer addSublayer:testLayer];
    [bounceLayer addSublayer:shadowLayer];
    
    //Get the Animation Path
    
    NSDictionary* pathDict = [NSBezierPath bounceToPoint:NSMakePoint(0, 0)];
    
    //Get the image Path
    NSBezierPath* path = [pathDict objectForKey:@"path"];
    NSAffineTransform* transform = [NSAffineTransform transform];
    [transform translateXBy:103.0 yBy:300];
    [path transformUsingAffineTransform:transform];
    
    //Make the shadow path from it
    NSAffineTransform* shadowTransform1 = [NSAffineTransform transform];
    [shadowTransform1 translateXBy:0 yBy:-240];
    NSAffineTransform* shadowTransform2 = [NSAffineTransform transform];
    [shadowTransform2 scaleXBy:1.0 yBy:-1.0];
    NSAffineTransform* shadowTransform3 = [NSAffineTransform transform];
    [shadowTransform3 translateXBy:0 yBy:200];
    
    NSAffineTransform* shadowTransformTot = [NSAffineTransform transform];
    [shadowTransformTot appendTransform:shadowTransform1];
    [shadowTransformTot appendTransform:shadowTransform2];
    [shadowTransformTot appendTransform:shadowTransform3];
    NSBezierPath* shadowPath = [path copy];
    [shadowPath transformUsingAffineTransform:shadowTransformTot];
    
    //Then, Animate it
    [CATransaction begin];
    [CATransaction setCompletionBlock:^{
        //testLayer.position=CGPointMake(0, 200);
        [self performSelector:@selector(displayButtons) withObject:nil afterDelay:1.0];
    }];
        //Create the image anim
        CAKeyframeAnimation *anim = [CAKeyframeAnimation animationWithKeyPath:@"position"];
        anim.path = [path quartzPath];
        anim.repeatCount = 0;
        anim.duration = [[pathDict objectForKey:@"duration"] floatValue];
    
        //Now, the shadow anim
        CAKeyframeAnimation* shadowAnim = [CAKeyframeAnimation animationWithKeyPath:@"position"];
        shadowAnim.path = [shadowPath quartzPath];
        shadowAnim.repeatCount = 0;
        shadowAnim.duration = [[pathDict objectForKey:@"duration"] floatValue];
    
        //Fire both the anims
        [testLayer addAnimation:anim forKey:@"bounce"];
        [shadowLayer addAnimation:shadowAnim forKey:@"shadowBounce"];
    
    
    [CATransaction commit];
    
}

-(void)addButtonWithTitle:(NSString*)buttonTitle andAction:(NSString*)aSelectorString
{
    [titleArray addObject: buttonTitle];
    [selectorArray addObject:aSelectorString];
}

-(void)displayButtons
{
    int buttonHeight=[BCFadedInButton heightWithAttributes:attributes];
    
    NSAssert([titleArray count]*buttonHeight<=[self window].frame.size.height, @"You have too many buttons, clipping is gonna occur. Either change Font size of button number.");
    
    //First, display a solid vertical bar spanning the buttons
    BCRoundedLine* roundedLine = [[BCRoundedLine alloc]initWithFrame:NSMakeRect(
        760,
        ([[self window] frame].size.height-titleArray.count*(buttonHeight))/2,
        2,
         titleArray.count*(buttonHeight))];
    
    [roundedLine setColor:[NSColor darkGrayColor]];
    [roundedLine setAlphaValue:0.5];
    [[NSAnimationContext currentContext] setDuration:2.0];
    [[[self window] contentView] addSubview:roundedLine];
    [[roundedLine animator ] setAlphaValue:1.0];
    
    //Then, fade the buttons in
    __block BCFadedInButton* but;
    __block int currentHeight=[[self window] frame].size.height-roundedLine.frame.origin.y-buttonHeight;
    __block float currentDelay=0;
    [titleArray enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        but = [[BCFadedInButton alloc]initWithFrame:(NSRect){350,currentHeight,400,buttonHeight}];
        [but setDelegate:self];
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
