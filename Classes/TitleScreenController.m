//
//  TitleScreenController.m
//  LazyQuest
//
//  Created by u0565496 on 4/22/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "TitleScreenController.h"
#import "GameController.h"
#import "SaveGameController.h"
#import "LoadGameController.h"


@implementation TitleScreenController

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
	[_world release];
	[_character release];
	[super dealloc];
}
-(TitleScreen*) contentView
{
	return (TitleScreen*)[self view];
}
-(void) loadView
{
	TitleScreen* titleScreen = [[[TitleScreen alloc] initWithFrame:CGRectMake(10, 30, 300, 430)] autorelease];
	[self setView:titleScreen];
	[self.navigationController setNavigationBarHidden:TRUE animated:NO];
}

-(void) viewDidLoad
{
	[[self contentView] setDelegate:self];
}

-(void) newCharacterButtonPressed
{
	//NSLog(@"new character button pressed");
	//NSLog(@"character: %@", _character);
	SaveGameController* saveGameController = [[SaveGameController alloc] initWithCharacter:_character andWorld:_world];
	//NSLog(@"new character controller character: %@", [newCharacterController character]);
	[self.navigationController pushViewController:saveGameController animated:YES];
	[saveGameController release];
}
-(void) loadCharacterButtonPressed
{
	//NSLog(@"load character button pressed");
	LoadGameController* saveGameController = [[LoadGameController alloc] initWithCharacter:_character andWorld:_world];
	//NSLog(@"new character controller character: %@", [newCharacterController character]);
	[self.navigationController pushViewController:saveGameController animated:YES];
	[saveGameController release];
	
}

-(void) updateUI
{
}

-(void) combatLogString:(NSString*) string
{
//	[[self contentView] addTextToCombatLog:string];
}

@end
