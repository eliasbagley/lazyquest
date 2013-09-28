//
//  MapScrollController.m
//  LazyQuest
//
//  Created by u0565496 on 4/20/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "MapScrollController.h"


@implementation MapScrollController

-(id) init
{
	self = [super init];
	if (self == nil)
		return nil;
	
	_mapScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, 1650, 1275)];
	//_mapScrollView.pagingEnabled = YES;
	ScrollableMap* map = [[ScrollableMap alloc] initWithFrame:CGRectMake(0, 0, 1650, 1275)];
	[_mapScrollView addSubview:map];
	_mapScrollView.contentSize = CGSizeMake(1650, 1275);
	[map release];
	//[_mapScrollView 
	
	return self;
	
}

-(void) dealloc
{
	[_mapScrollView release];
	[super dealloc];
}

-(ScrollableMap*) contentView
{
	return (ScrollableMap*)[self view];
}
-(void) loadView
{
	[self setView:_mapScrollView];
}
-(void) viewDidLoad
{
	[[self contentView] setDelegate:self];
}
-(void) updateUI
{
	//NSLog(@"updating UI in mapScrollController");
}
-(void)backButtonPressed
{
	[self.navigationController popViewControllerAnimated:TRUE];
}
-(void) combatLogString:(NSString*) string
{
//	[[self contentView] addTextToCombatLog:string];
}

@end
