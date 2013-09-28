//
//  InventoryController.m
//  LazyQuest
//
//  Created by u0565496 on 4/19/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "InventoryController.h"

@interface InventoryController()
@end

@implementation InventoryController
-(id) initWithCharacter:(Character*)character;
{
	self = [super init];
	if (self == nil)
		return nil;
	
	[self setCharacter:character];
	
	return self;
	
}
@synthesize character = _character;

-(void) dealloc
{
	[_character release];
	[super dealloc];
}

-(InventoryView*) contentView
{
	return (InventoryView*)[self view];
}
-(void) loadView
{
	InventoryView* inventoryView = [[InventoryView alloc] initWithFrame:CGRectMake(10, 30, 300, 430)];
	//inventoryView.text = @"lol";
	[self setView:inventoryView];
	[self updateUI];
}
-(void) viewDidLoad
{	
	[[self contentView] setDelegate:self];
}
-(void) updateUI
{	
	[[self contentView] inventoryTextView].text = [_character inventoryDescription];
	[[self contentView] spellsTextView].text = [_character spellsDescription];
	[[self contentView] gearTextView].text = [_character gearDescription];
}

-(void) backButtonPressed
{
	[self.navigationController popViewControllerAnimated:TRUE];
}
-(void) combatLogString:(NSString*) string
{
	//[[self contentView] addTextToCombatLog:string];
}

@end
