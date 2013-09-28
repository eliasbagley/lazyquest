//
//  MainMenuController.m
//  LazyQuest
//
//  Created by u0565496 on 4/19/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "NewCharacterController.h"
#import "GameController.h"

@implementation NewCharacterController

-(id) initWithCharacter:(Character*)character andWorld:(World*)world
{
	
	self = [super init];
	if (self == nil)
		return nil;
	
	_character = [character retain];
	_world = [world retain];
	
	return self;
	
}
@synthesize character = _character;
@synthesize world = _world;
-(void) dealloc
{
	[_character release];
	[_world release];
	[super dealloc];
}

-(NewCharacter*) contentView
{
	return (NewCharacter*)[self view];
}
-(void) loadView
{
	//NSLog(@"loading main menu");
	NewCharacter* mainMenu = [[[NewCharacter alloc] initWithFrame:CGRectMake(10, 30, 300, 430)] autorelease];
	[self setView:mainMenu];
}

-(void) viewWillAppear:(BOOL)animated
{

}
-(void) viewDidLoad
{
	//NSLog(@"viewDidLoad in newCharController");
	[[self contentView] setDelegate:self];
	//UIBarButtonItem *anotherButton = [[UIBarButtonItem alloc] initWithTitle:@"Start Game" style:UIBarButtonItemStylePlain target:self action:@selector(startGame)];          
	//self.navigationItem.rightBarButtonItem = anotherButton;
	//[anotherButton release];
	//NSLog(@"view finished loading");
}
/*
-(void) startGame
{
	//NSLog(@"got to start game");
	[_character setStrengthCoefficient:[[self contentView] strengthSlider].value];
	[_character setAgilityCoefficient:[[self contentView] agilitySlider].value];
	[_character setIntellectCoefficient:[[self contentView] intellectSlider].value];
	[_character setEnduranceCoefficient:[[self contentView] enduranceSlider].value]; 
	[_character setName:[[self contentView] name].text];
	[_character setClassName:[[self contentView] className].text];
	[_character updateStats];
	GameController* gameController = [[GameController alloc] initWithCharacter:_character andWorld:_world];
	[self.navigationController pushViewController:gameController animated:YES];
}
 */

-(void) startGameButtonPressed
{
	[_character setStrengthCoefficient:[[self contentView] strengthSlider].value];
	[_character setAgilityCoefficient:[[self contentView] agilitySlider].value];
	[_character setIntellectCoefficient:[[self contentView] intellectSlider].value];
	[_character setEnduranceCoefficient:[[self contentView] enduranceSlider].value];
	[_character setName:[[self contentView] name].text];
	[_character setClassName:[[self contentView] className].text];
	[_character setLevel:1];
	[_character updateStats];
	GameController* gameController = [[GameController alloc] initWithCharacter:_character andWorld:_world];
	[self.navigationController pushViewController:gameController animated:YES];
	[gameController release];
}
-(void) backButtonPressed
{
	[self.navigationController popViewControllerAnimated:TRUE];
}

-(void)updateUI
{
	//NSLog(@"trying to update ui");
}
-(void) combatLogString:(NSString*) string
{
	//[[self contentView] addTextToCombatLog:string];
}

@end
