//
//  SaveGame.m
//  LazyQuest
//
//  Created by u0565496 on 4/25/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "LoadGame.h"


@implementation LoadGame

-(id) initWithFrame:(CGRect)frame
{
	self = [super initWithFrame:frame];
	if (self == nil)
		return nil;
	
	_backgroundImage = [[UIImage imageNamed:@"menu-titlescreen"] retain];
	
	_backButton = [[UIButton buttonWithType:UIButtonTypeRoundedRect] retain];
	[_backButton setFrame:CGRectMake(30, 413, 130, 35)];
	[_backButton setTitle:@"Back" forState:UIControlStateNormal];
	[_backButton addTarget:self action:@selector(backButtonPressed) forControlEvents:UIControlEventTouchUpInside];
	
	_saveSlot1 = [[UIButton buttonWithType:UIButtonTypeRoundedRect] retain];
	_saveSlot2 = [[UIButton buttonWithType:UIButtonTypeRoundedRect] retain];
	
	[_saveSlot1 setFrame:CGRectMake(45, 280, 230, 55)];
	[_saveSlot2 setFrame:CGRectMake(45, 340, 230, 55)];
	
	[_saveSlot1 setTitle:@"Slot 1" forState:UIControlStateNormal];
	[_saveSlot2 setTitle:@"Slot 2" forState:UIControlStateNormal];
	
	[_saveSlot1 addTarget:self action:@selector(saveSlot1Pressed) forControlEvents:UIControlEventTouchUpInside];
	[_saveSlot2 addTarget:self action:@selector(saveSlot2Pressed) forControlEvents:UIControlEventTouchUpInside];
	
	_saveSlot1.titleLabel.textAlignment = UITextAlignmentCenter;
	_saveSlot2.titleLabel.textAlignment = UITextAlignmentCenter;
	
	_saveSlot1.titleLabel.lineBreakMode = UILineBreakModeWordWrap;
	_saveSlot2.titleLabel.lineBreakMode = UILineBreakModeWordWrap;
	
	[self addSubview:_backButton];
	[self addSubview:_saveSlot1];
	[self addSubview:_saveSlot2];
	
	return self;
	
}

@synthesize delegate = _delegate;
@synthesize saveSlot1 = _saveSlot1;
@synthesize saveSlot2 = _saveSlot2;
@synthesize backButton = _backButton;

-(void) dealloc
{
	[_saveSlot1 release];
	[_saveSlot2 release];
	[_backButton release];
	[_backgroundImage release];
	[super dealloc];
	
}

-(void) drawRect:(CGRect)rect
{
	[_backgroundImage drawInRect:rect];
}

-(void) saveSlot1Pressed
{
	[_delegate slotUsed:1];
}
-(void) saveSlot2Pressed
{
	[_delegate slotUsed:2];	
}
-(void) backButtonPressed
{
	[_delegate backButtonPressed];
}

@end
