//
//  TitleScreenController.m
//  LazyQuest
//
//  Created by u0565496 on 4/22/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "SaveGameController.h"
#import "GameController.h"
#import "NewCharacterController.h"


@implementation SaveGameController

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
-(SaveGame*) contentView
{
	return (SaveGame*)[self view];
}
-(void) loadView
{
	SaveGame* saveGameScreen = [[[SaveGame alloc] initWithFrame:CGRectMake(10, 30, 300, 430)] autorelease];
	[self setView:saveGameScreen];
	[self.navigationController setNavigationBarHidden:TRUE animated:NO];
}

-(void) viewDidLoad
{
	[[self contentView] setDelegate:self];
	if ([_character saveGameSlot] == 0)
	{
		[[[self contentView] saveSlot1] setTitle:@"Empty" forState:UIControlStateNormal];
		[[[self contentView] saveSlot2] setTitle:@"Empty" forState:UIControlStateNormal];
	}
	else if ([_character saveGameSlot] == 1)
	{
		[[[self contentView] saveSlot1] setTitle:[_character name] forState:UIControlStateNormal];
	}
	else if ([_character saveGameSlot] == 2)
	{
		[[[self contentView] saveSlot2] setTitle:[_character name] forState:UIControlStateNormal];
	}
	for (int i = 1; i <= 2 ; i++)
	{
		NSString* slotString = [NSString stringWithFormat:@"%i", i];
		NSMutableDictionary* characterStateDictionary = [[NSUserDefaults standardUserDefaults] objectForKey:slotString];
		if (characterStateDictionary != nil)
		{
			[_character setName:[characterStateDictionary objectForKey:@"name"]];
			[_character setClassName:[characterStateDictionary objectForKey:@"classname"]];
			[_character setLevel:[[characterStateDictionary objectForKey:@"level"] intValue]];
			NSString* slotTitle = [NSString stringWithFormat:@"%@\nLevel %i %@", [_character name], [_character level], [_character className]];
			if (i == 1)
			{
				[[[self contentView] saveSlot1] setTitle:slotTitle forState:UIControlStateNormal];
			}
			else if(i ==2)
			{
				[_character setName:[characterStateDictionary objectForKey:@"name"]];
				[[[self contentView] saveSlot2] setTitle:slotTitle forState:UIControlStateNormal];
			}
		}
	}
}


-(void) slotUsed:(int)slot
{

	[_character setSaveGameSlot:slot]; // so the character stores what game slot it's associated with
	NewCharacterController* newCharacterController = [[NewCharacterController alloc] initWithCharacter:_character andWorld:_world];
	[self.navigationController pushViewController:newCharacterController animated:YES];
	[newCharacterController release];
}
-(void) backButtonPressed
{
	[self.navigationController popViewControllerAnimated:TRUE];
}

-(void) updateUI
{
}

-(void) combatLogString:(NSString*) string
{
//	[[self contentView] addTextToCombatLog:string];
}

@end
