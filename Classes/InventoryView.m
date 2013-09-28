//
//  InventoryView.m
//  LazyQuest
//
//  Created by u0565496 on 4/21/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "InventoryView.h"


@implementation InventoryView

-(id) initWithFrame:(CGRect)frame
{
	self = [super initWithFrame:frame];
	if (self == nil)
		return nil;
	
	_backButton = [[UIButton buttonWithType:UIButtonTypeRoundedRect] retain];
	[_backButton setFrame:CGRectMake(10, 10, 100, 30)];
	[_backButton setTitle:@"Back" forState:UIControlStateNormal];
	[_backButton addTarget:self action:@selector(backButtonPressed) forControlEvents:UIControlEventTouchUpInside];
	
	_backgroundImage = [[UIImage imageNamed:@"background-playerinfo"] retain];
	
	UIScrollView* scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(168, 105, 140, 150)];
	[scrollView setContentSize:CGSizeMake(300, 335)];
	[scrollView setScrollEnabled:TRUE];
	scrollView.clipsToBounds = YES;
	
	UIScrollView* inventoryScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, 155, 355)];
	[inventoryScrollView setContentSize:CGSizeMake(300, 355)];
	[inventoryScrollView setScrollEnabled:TRUE];
	[inventoryScrollView setClipsToBounds:YES];
	
	UIScrollView* spellScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(168, 290, 145, 150)];
	[spellScrollView setContentSize:CGSizeMake(300, 355)];
	[spellScrollView setScrollEnabled:TRUE];
	[spellScrollView setClipsToBounds:YES];
	
	_inventoryTextView = [[UITextView alloc] initWithFrame:CGRectMake(5, 105, 800, 335)];
	_inventoryTextView.editable = NO;
	[_inventoryTextView setContentSize:CGSizeMake(800, 335)];
	[_inventoryTextView setScrollEnabled:TRUE];
	_spellsTextView = [[UITextView alloc] initWithFrame:CGRectMake(0, 0, 800, 150)];
	_spellsTextView.editable = NO;
	_gearTextView = [[UITextView alloc] initWithFrame:CGRectMake(0, 0, 800, 150)];
	_gearTextView.editable = NO;
	[_gearTextView setContentSize:CGSizeMake(155, 355)];
	
	//[_gearTextView setContentSize:CGSizeMake(155, 335)];	 


	[_inventoryTextView setBackgroundColor:[UIColor clearColor]];
	[_inventoryTextView setTextColor:[UIColor whiteColor]];
	[_inventoryTextView setFont:[UIFont fontWithName:@"STHeitiSC-Medium" size:10]];
	[inventoryScrollView addSubview:_inventoryTextView];
	[self addSubview: inventoryScrollView];
	

	[_spellsTextView setBackgroundColor:[UIColor clearColor]];
	[_spellsTextView setTextColor:[UIColor whiteColor]];
	[_spellsTextView setFont:[UIFont fontWithName:@"STHeitiSC-Medium" size:10]];
	[spellScrollView addSubview:_spellsTextView];
	[self addSubview: spellScrollView];
	
	[_gearTextView setBackgroundColor:[UIColor clearColor]];
	[_gearTextView setTextColor:[UIColor whiteColor]];
	[_gearTextView setFont:[UIFont fontWithName:@"STHeitiSC-Medium" size:10]];
	[scrollView addSubview:_gearTextView];
	[self addSubview: scrollView];
	
	[self addSubview: _backButton];
	
	return self;
}

@synthesize delegate = _delegate;
@synthesize backgroundImage = _backgroundImage;
@synthesize backButton = _backButton;
@synthesize inventoryTextView = _inventoryTextView;
@synthesize gearTextView = _gearTextView;
@synthesize spellsTextView = _spellsTextView;

-(void) dealloc
{
	[_backgroundImage release];
	[_backButton release];
	[_inventoryTextView release];
	[_gearTextView release];
	[_spellsTextView release];
	[super dealloc];
}

-(void) drawRect:(CGRect)rect
{
	[_backgroundImage drawInRect:rect];
}

-(void) backButtonPressed
{
	[_delegate backButtonPressed];
}

@end
