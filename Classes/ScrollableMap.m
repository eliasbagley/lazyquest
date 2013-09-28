//
//  ScrollableMap.m
//  LazyQuest
//
//  Created by u0565496 on 4/20/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "ScrollableMap.h"

@interface ScrollableMap()
@end

@implementation ScrollableMap

-(id) initWithFrame:(CGRect)frame
{
	self = [super initWithFrame:frame];
	if (self == nil)
		return nil;
	
	_map = [[UIImage imageNamed:@"map"] retain];
	_backButton = [[UIButton buttonWithType:UIButtonTypeRoundedRect] retain];
	[_backButton setFrame:CGRectMake(0, 410, 80, 30)];
	[_backButton setTitle:@"Back" forState:UIControlStateNormal];
	[_backButton addTarget:self action:@selector(buttonPressed) forControlEvents:UIControlEventTouchUpInside];
	//[self addSubview:_backButton];
	
	return self;
}

@synthesize delegate = _delegate;
@synthesize map = _map;

-(void) dealloc
{
	[_map release];
	[_backButton release];
	[super dealloc];
}

-(void) drawRect:(CGRect)rect
{
	[_map drawInRect:rect];
}

-(void) updateUI
{
	// do nothing
}

-(void) buttonPressed
{
	[_delegate backButtonPressed];
}


@end
