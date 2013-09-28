//
//  Controller.m
//  LazyQuest
//
//  Created by u0565496 on 4/12/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "GameController.h"


@interface GameController() <GameScreenDelegate>
@end

@implementation GameController

-(id) initWithCharacter:(Character*)character andWorld:(World*)world
{
	
	self = [super init];
	if (self == nil)
		return nil;
	
	//NSLog(@"initializing game controller...");
	_character = [character retain];
	_world = [world retain];
	_timeInterval = .0075f;
	//_world = world;
	
	_items = [[NSMutableArray alloc] init];
	for (int i = 0; i < 100; i++)
	{
		// item level is anything plus or minus ours by a bit
		int level = [_character level] + arc4random()%10-5;
		if (level < 1)
			level = 1;

		Item* item = [_world getRandomItemWithLevel:level];
		[_items addObject:item];
	}
	
	_spells = [[NSMutableArray alloc] init];
	for (int i = 0; i < 10; i++)
	{
		Spell* spell = [_world getRandomSpellForCharacter:_character];
		[_spells addObject:spell];
	}
	
	

	
	return self;
}

-(void) dealloc
{
	[_character release];
	[_world release];
	[_items release];
	[_spells release];
	[super dealloc];
}

@synthesize spells = _spells;
@synthesize items = _items;
@synthesize character = _character;
@synthesize world = _world;
@synthesize timeInterval = _timeInterval;

-(GameScreen*) contentView
{
	return (GameScreen*)[self view];
}

-(void) updateUI
{
	//[[self contentView] setText:[_character description]];
	[self animateBars];
	[[self contentView] setStatsStrength:[_character strength] Agility:[_character agility] Intellect:[_character intellect] Endurance:[_character endurance] Armor:[_character armor] andGold:[_character gold]];
}

-(void) loadView
{
	//NSLog(@"view being loaded..");
	GameScreen* gameScreen = [[[GameScreen alloc] initWithFrame:CGRectMake(10, 30, 300, 430)] autorelease];
	//gameScreen.editable = FALSE;
	[self setView:gameScreen];
}

-(BOOL) animateActionBar
{
	[_character setActionProgress:[_character actionProgress] + _timeInterval];
	float progress = [_character actionProgress]/[_character actionDuration];
	//[[self contentView] animateBarWithProgress:progress andString:[_character action]];
	[[self contentView] animateBarWithProgress:progress andString:[_character action] atIndex:2];
	if ([_character actionProgress] >= [_character actionDuration])
	{
		[_character setActionProgress:0];
		return TRUE;
	}
	return FALSE;
	
}
-(void) animateBars
{
	float percentHealth = (float)[_character currentHealth]/[_character maxHealth];
	NSString* healthDescription = [NSString stringWithFormat:@"%i/%i", [_character currentHealth], [_character maxHealth]];
	[[self contentView] animateBarWithProgress:percentHealth andString:healthDescription atIndex:0];
	
	float percentMana = (float)[_character currentMana]/[_character maxMana];
	NSString* manaDescription = [NSString stringWithFormat:@"%i/%i", [_character currentMana], [_character maxMana]];
	[[self contentView] animateBarWithProgress:percentMana andString:manaDescription atIndex:1];
	
//	unsigned long long xpTillNext = [_character xpTillNextLevel];
	float percentXP = (float)[_character xpIntoLevel]/[_character xpToNextLevel];
	NSString* xpDescription = [NSString stringWithFormat:@"XP: %llu/%llu", [_character xpIntoLevel], [_character xpToNextLevel]];
	[[self contentView] animateBarWithProgress:percentXP andString:xpDescription atIndex:3];
	
	if ([_character currentEnemy] != nil)
	{
		[[self contentView] setBarHidden:FALSE atIndex:4];
		[[self contentView] setBarHidden:FALSE atIndex:5];
		
		Creature* currentEnemy = [_character currentEnemy];
		float percentEnemyHealth = (float)[currentEnemy currentHealth]/[currentEnemy maxHealth];
		NSString* enemyHealthDescription = [NSString stringWithFormat:@"%i/%i", [currentEnemy currentHealth], [currentEnemy maxHealth]];
		[[self contentView] animateBarWithProgress:percentEnemyHealth andString: enemyHealthDescription atIndex:4];
		
		float percentEnemyMana = (float)[currentEnemy currentMana]/[currentEnemy maxMana];
		NSString* enemyManaDescription = [NSString stringWithFormat:@"%i/%i", [currentEnemy currentMana], [currentEnemy maxMana]];
		[[self contentView] animateBarWithProgress:percentEnemyMana andString: enemyManaDescription atIndex:5];
	}
	else 
	{
		[[self contentView] setBarHidden:TRUE atIndex:4];
		[[self contentView] setBarHidden:TRUE atIndex:5];
	}
	
	Quest* currentQuest = [_character currentQuest];
	if (currentQuest == nil)
	{
		[[self contentView] animateQuestBarWithString:@"No Quests" andProgress:0.0f];

	}
	else 
	{
		float questProgress = (float)[currentQuest currentProgress]/[currentQuest maxProgress];
		//NSLog(@"Quest progress: %f", questProgress);
		[[self contentView] animateQuestBarWithString:[currentQuest name] andProgress:questProgress];
	}
}
	 

-(BOOL) animateEnemyAttackBar
{
	
	Creature* currentEnemy = [_character currentEnemy];
	[currentEnemy setActionProgress:[currentEnemy actionProgress] + _timeInterval];
	float progress = [currentEnemy actionProgress]/[currentEnemy actionDuration];
	//[[self contentView] animateEnemyBarWithProgress:progress andString:[currentEnemy action]];
	[[self contentView] animateBarWithProgress:progress andString:[currentEnemy action] atIndex:6];
	if ([currentEnemy actionProgress] >= [currentEnemy actionDuration])
	{
		[currentEnemy setActionProgress:0];
		return TRUE;
	}
	return FALSE;
}

-(void) doAction
{
	NSString* actionDescription = [_character action];
	NSArray* actionArray= [actionDescription componentsSeparatedByString:@" "];
	NSString* action = [actionArray objectAtIndex:0];
	//NSString* action = @"Travelling";
	if ([actionDescription isEqualToString:@"You are standing in front of an old man"])
	{
		[_character setActionDuration:2];
		NSString* characterAction = @"You are standing in front of an old man";
		[_character setAction:characterAction];
		if([self animateActionBar] == FALSE)
			return;
		[_character setActionProgress:0];
		[_character setIntroFlag:0];
		[_character setAction:@"He says you are the chosen one"];
		
	}
	else if ([actionDescription isEqualToString:@"He says you are the chosen one"])
	{
		[_character setActionDuration:2];
		NSString* characterAction = @"He says you are the chosen one";
		[_character setAction:characterAction];
		if([self animateActionBar] == FALSE)
			return;
		[_character setActionProgress:0];
		[_character setAction:@"He teaches you of an ancient evil"];
		
	}
	else if ([actionDescription isEqualToString:@"He teaches you of an ancient evil"])
	{
		[_character setActionDuration:2];
		NSString* characterAction = @"He teaches you of an ancient evil";
		[_character setAction:characterAction];
		if([self animateActionBar] == FALSE)
			return;
		[_character setActionProgress:0];
		[_character setAction:@"Of the Necromancer King in the north"];
		
	}
	else if ([actionDescription isEqualToString:@"Of the Necromancer King in the north"])
	{
		[_character setActionDuration:2];
		NSString* characterAction = @"Of the Necromancer King in the north";
		[_character setAction:characterAction];
		if([self animateActionBar] == FALSE)
			return;
		[_character setActionProgress:0];
		[_character setAction:@"You are destined to destroy him"];
		
	}
	else if ([actionDescription isEqualToString:@"You are destined to destroy him"])
	{
		[_character setActionDuration:2];
		NSString* characterAction = @"You are destined to destroy him";
		[_character setAction:characterAction];
		if([self animateActionBar] == FALSE)
			return;
		[_character setActionProgress:0];
		[_character setAction:@"You begin your quest"];
		
	}
	else if ([actionDescription isEqualToString:@"You begin your quest"])
	{
		[_character setActionDuration:2];
		NSString* characterAction = @"You begin your quest";
		[_character setAction:characterAction];
		if([self animateActionBar] == FALSE)
			return;
		[_character setActionProgress:0];
		[_character setIntroFlag:0];
		[_character setAction:@"Buying"];
		
	}
	
	
	else if ([action isEqualToString:@"Selling"])
	{
		[_character setActionDuration:1];
		if ([_character inventoryCount] == 0)
		{
			//[_character setDoingAction:FALSE];
			[_character setActionProgress:0];
			[self populateVendorInventory];
			[_character setAction:@"Buying"];
			return;
		}
		
		NSString* characterAction = [NSString stringWithFormat:@"Selling %@", [[[_character inventory] lastObject] itemName]];
		[_character setAction:characterAction];
		// sell last item in inventory
		if ([self animateActionBar] == FALSE)
			return;
		[_character sellLastItem];
		//[[self contentView] addTextToCombatLog:[NSString stringWithFormat:@"Selling %@ for %i gold", [[[_character inventory] lastObject] itemName], [[[_character inventory] lastObject] goldValue]]];
		

	}
	else if ([action isEqualToString:@"Turning"])
	{
		// heal them as  a reward
		[_character setCurrentHealth:[_character maxHealth]];
		[_character setCurrentMana:[_character maxMana]];
		
		NSString* characterAction = @"Turning in quest and collecting reward";
		[_character setAction:characterAction];
		if ([self animateActionBar] == FALSE)
			return;
		Quest* currentQuest = [_character currentQuest];
		if ([currentQuest itemReward] != nil)
		{
			[_character receiveNewItem:[currentQuest itemReward]];
		}
		[_character incrementGold:[currentQuest goldReward]];
		[_character incrementXP:[currentQuest xpReward]];
		[_character setActionProgress:0];
		[_character setAction:@"Selling"];
		[_character setCurrentQuest:nil];
	}
	else if ([action isEqualToString:@"Buying"])
	{		
		
		[_character setActionDuration:1];
		
		
		for (Item* item in _items)
		{
			if ([_character gold] >= [item goldValue] && [item itemLevelForCharacter:_character] > [[[_character gear] objectAtIndex:[item slot]] itemLevelForCharacter:_character])
			{
				// buy it
				NSString* characterAction = [NSString stringWithFormat:@"Buying %@", [item itemName]];
				[_character setAction:characterAction];
				if ([self animateActionBar] == FALSE)
					return;
				[_character incrementGold:-1*[item goldValue]];
				[_character receiveNewItem:item];
				[_character setActionProgress:0];
				[_character updateStats];
				return;
			}
		}
		[_character setDoingAction:FALSE];
		[_character setActionProgress:0];
		float randomNumber = drand48();
		NSLog(@"random number: %f", randomNumber);
		if ( randomNumber < .2)
		{
		 // give them a spell
			Spell* spell = [_world getRandomSpellForCharacter:_character];
			//NSLog(@"spell name: %@", [spell spellName]);
			[_character addSpell:spell];
		}
		
		
	}
	else if ([action isEqualToString:@"Travelling"])
	{
		//head into quest location
		[_character setActionDuration:1];
		if ([[_character currentQuest] currentProgress] < [[_character currentQuest] maxProgress]) 
		{
			NSString* questLocationName = [[_world getLocationFromCoordinate:[[_character currentQuest] questLocation]] retain];
			NSString* characterAction = [NSString stringWithFormat:@"Travelling to %@", questLocationName];
			[_character setAction:characterAction];
			if([self animateActionBar] == FALSE)
				return;
			
			//move one space closer
			else 
			{
				[[self contentView] addTextToCombatLog:[NSString stringWithFormat:@"Travelling to %@", questLocationName]];
				CGPoint destination = [[_character currentQuest] questLocation];
				CGPoint currentLocation = [_character currentLocation];
				int dx = destination.x - currentLocation.x;
				int dy = destination.y - currentLocation.y;			
				if (dx<0) 
				{
					currentLocation = CGPointMake(currentLocation.x-1, currentLocation.y);
				}
				else if(dx>0)
				{
					currentLocation = CGPointMake(currentLocation.x+1, currentLocation.y);
				}
				if (dy<0) 
				{
					currentLocation = CGPointMake(currentLocation.x, currentLocation.y-1);
				}
				else if(dy>0)
				{
					currentLocation = CGPointMake(currentLocation.x, currentLocation.y+1);
				}
				
				[_character setCurrentLocation:currentLocation];
				NSString* backgroundImageName = [_world getBackgroundPictureNameFromLocation:currentLocation];
				[[self contentView] setBackgroundImageFromString:backgroundImageName];
				[[self contentView] setCharacterLocationString:[_world getLocationFromCoordinate:currentLocation]];
				[_character setDoingAction:FALSE];
				[_character setActionProgress:0];
				
			}

		}
		// head to turn in quest
		else 
		{
			NSString* questStartName = [_world getLocationFromCoordinate:[[_character currentQuest] questStart]];
			[_character setAction:[NSString stringWithFormat:@"Travelling to %@", questStartName]];
			if([self animateActionBar] == FALSE)
				return;
			
			//move one space closer
			else 
			{
				[[self contentView] addTextToCombatLog:[NSString stringWithFormat:@"Travelling to turn in quest in %@", questStartName]];
				CGPoint destination = [[_character currentQuest] questStart];
				CGPoint currentLocation = [_character currentLocation];
				int dx = destination.x - currentLocation.x;
				int dy = destination.y - currentLocation.y;
				
				
				if (dx<0) 
				{
					currentLocation = CGPointMake(currentLocation.x-1, currentLocation.y);
				}
				else if(dx>0)
				{
					currentLocation = CGPointMake(currentLocation.x+1, currentLocation.y);
				}
				else if (dy<0) 
				{
					currentLocation = CGPointMake(currentLocation.x, currentLocation.y-1);
				}
				else if(dy>0)
				{
					currentLocation = CGPointMake(currentLocation.x, currentLocation.y+1);
				}
				
				[_character setCurrentLocation:currentLocation];
				NSString* backgroundImageName = [_world getBackgroundPictureNameFromLocation:currentLocation];
				[[self contentView] setBackgroundImageFromString:backgroundImageName];
				[[self contentView] setCharacterLocationString:[_world getLocationFromCoordinate:currentLocation]];
				[_character setDoingAction:FALSE];
				[_character setActionProgress:0];
				
		}
			

	}
		// health regen and mana regen
		[_character incrementHealth:[_character maxHealth]*.01];
		[_character incrementMana:[_character maxMana]*.01];
	}
	else if ([action isEqualToString:@"Reviving"])
	{
		NSString* characterAction = @"Reviving";
		[_character setActionDuration:15];
		[_character setAction:characterAction];
		if ([self animateActionBar] == FALSE)
			return;
		else 
		{
			[_character setCurrentHealth:[_character maxHealth]];
			// TODO: multiple towns, choose one
			[_character setCurrentLocation:CGPointMake(13, 12)];
			[_character setDoingAction:FALSE];
			[_character setActionProgress:0];
		}

	}
	else if ([action isEqualToString:@"Receiving"])
	{
		// action to receive quest
		NSString* characterAction = [NSString stringWithFormat:@"Receiving a quest"];
		[_character setActionDuration:3];
		[_character setAction:characterAction];
		if ([self animateActionBar] == FALSE)
			return;
		else 
		{
			// generate quest
			// choose a random location
			int randX = arc4random()%WIDTH;
			int randY = arc4random()%HEIGHT;
			CGPoint questLocation = CGPointMake(randX, randY);
			//NSString* creatureName = [_world getCreatureNameFromThisCoordinate:questLocation];
			Creature* creature = [_world getCreatureFromThisCoordinate:questLocation andLevel:[_character level]];
			//NSString* creatureName = [NSString stringWithFormat:@"%@ %@", [creature prefix], [creature name]]; // prefix + name
			NSString* creatureName = [creature name];
			Item* itemReward = [_world getRandomItemWithLevel:[_character level]];
			int questType = arc4random()%3+1;

			Quest* quest = [Quest generateQuestWithLevel:[_character level] withLocation:[_world getLocationFromCoordinate:questLocation] atStart:[_character currentLocation] andEnd:questLocation withCreature:creatureName withQuestType:questType questItem:[_world getRandomQuestItem] andItemReward:itemReward];
			[_character setCurrentQuest:quest];
			//[_character updateStats];
			[_character setDoingAction:FALSE];
			[_character setActionProgress:0];
		}
		
	}
	else 
	{
		NSAssert(FALSE, @"Bad action string");
	}
}
-(void) doCombatIteration
{
	// at this point character is guaranteed to have an enemy
	[[self contentView] setBarHidden:FALSE atIndex:6];
	[[self contentView] setEnemyNameplateHidden:FALSE];
	NSString* enemyName = [NSString stringWithFormat:@"%@ %@", [[_character currentEnemy] prefix], [[_character currentEnemy] name]];
	[[self contentView] updateEnemyNameplateWithName:enemyName andLevel:[_character level]];
	
	[_character setActionDuration:3/[_character attackSpeed]];
	Spell* bestAttack = [[_character getBestAttack] retain];
	[_character setAction:[bestAttack description]];
	if([self animateActionBar] != FALSE)
	{
		// attack enemy
		
		int damageDone = [bestAttack addedDamage] + [_character attackDamage];
		
		float critChance = [_character getCritPercentage];
		float chance = drand48();
		if (critChance <= chance)
		{
			damageDone*=2;
			// write it to the combat log
			//[[self contentView] addTextToCombatLog:[NSString stringWithFormat:@"Critial hit for %i damage!", damageDone]];
			[_character attackEnemy:damageDone withCrit:TRUE];

		}
		else
		{
			[_character attackEnemy:damageDone withCrit:FALSE];
		}
		[_character incrementMana:(-1*[bestAttack manaCost])];
		if( [[_character currentEnemy] currentHealth] <= 0)
		{
			// we've killed the enemy, hide their healthbars and nameplate
			[[self contentView] setBarHidden:TRUE atIndex:6];
			[[self contentView] setEnemyNameplateHidden:TRUE];
			
			Creature* currentEnemy = [_character currentEnemy];
			[_character incrementGold:[currentEnemy gold]];
			
			int xp = [currentEnemy strength] + [currentEnemy agility] + [currentEnemy intellect] + [currentEnemy endurance] + [_character level]*20;
			[[_character currentEnemy] setActionDuration:0];

			if ([[currentEnemy name] isEqualToString:[[_character currentQuest] creatureName]])
			{
				float rand = drand48();
				if(rand<[[_character currentQuest] dropRate])
					[[_character currentQuest] incrementProgress];
			}
			[[_character currentEnemy] release];
			[_character setCurrentEnemy:nil];
			[_character incrementXP:xp];
			
			// generate random drop based on rarities
			
			// 50% chance to get junk
			float junkChance = drand48();
			if (junkChance <= .3)
			{
				// spawn some junk
				Item* junk = [[_world getRandomJunkItem] retain];
				[_character addItem:junk];
				[junk release];
			}
			
			float rareChance = drand48();
			//NSLog(@"rare chance: %f"
			if (rareChance <= .01)
			{
				// spawn some junk
				Item* rare = [[_world getRandomRareItemWithLevel:[_character level]] retain];
				[_character receiveNewItem:rare];
				[rare release];
			}
			
			
			return;
		}
	}
	// enemy is still alive, enemy attacks
	[[_character currentEnemy] setActionDuration:4/[[_character currentEnemy] attackSpeed]];
	Spell* bestEnemyAttack = [[_character currentEnemy] getBestAttack];
	[[_character currentEnemy] setAction:[bestEnemyAttack description]];
	if ([self animateEnemyAttackBar] != FALSE)
	{
		// hero takes damage
		int damageDone = [bestEnemyAttack addedDamage] + [[_character currentEnemy] attackDamage];
		[_character incrementHealth:(-1*damageDone)];
		//[self animateCharacterBars];
		if ([_character currentHealth] <= 0)
		{
			// we dead
			[_character setAction:@"Reviving"];
			[_character setDoingAction:TRUE];
			[_character setCurrentEnemy:nil];
			return;
		}
	}


	
}

-(void) doOutOfCombatIteration
{
	if ([_character currentQuest] == nil)
	{
		[_character setAction:@"Receiving"];
		[_character setActionDuration:10];
		[_character setDoingAction:TRUE];
	}
	else if ([[_character currentQuest] currentProgress] >= [[_character currentQuest] maxProgress]) // if done
	{
	//	NSLog(@"current location: (%f, %f), quest location turn in: (%f, %f)", [_character currentLocation].x, [_character currentLocation].y, [[_character currentQuest] questStart].x, [[_character currentQuest] questStart].y);
		if ([self compareLocations:[_character currentLocation] loc2:[[_character currentQuest] questStart]])
		{
			// cash in quest
			[_character setAction:@"Turning"];
			[_character setActionDuration:10];
			[_character setDoingAction:TRUE];
			return;
		}
		float rand = drand48();
		if (rand < .2)
		{
			// set enemy
			Creature* enemy = [_world getCreatureFromThisCoordinate:[_character currentLocation] andLevel:[_character level]];
			[_character setCurrentEnemy:enemy];
			return;
		}
		
		[_character setAction:@"Travelling"];
		[_character setActionDuration:1];
		[_character setDoingAction:TRUE];
	}
	else if (![self compareLocations:[_character currentLocation] loc2:[[_character currentQuest] questLocation]]) // if not there yet
	{
		float rand = drand48();
		if (rand < .2)
		{
			// set enemy
			Creature* enemy = [_world getCreatureFromThisCoordinate:[_character currentLocation] andLevel:[_character level]];
			[_character setCurrentEnemy:enemy];
			return;
		}
																	 
		[_character setAction:@"Travelling"];
		[_character setActionDuration:10];
		[_character setDoingAction:TRUE];
	}
	else if ([self compareLocations:[_character currentLocation] loc2:[[_character currentQuest] questLocation]])
	{
		// spawn a mob at this location
		Creature* enemy = [_world getCreatureFromThisCoordinate:[_character currentLocation] andLevel:[_character level]];
		[_character setCurrentEnemy:enemy];
		return;
	}



}

-(void) gameLoop
{
	// update character nameplate
	if ([_character introFlag] == 1)
	{
		[_character setAction:@"You are standing in front of an old man"];
	}
	
	[[self contentView] setCharacterLocation:[_character currentLocation]];

	[[self contentView] updateOurNameplateWithName:[_character name] className:[_character className] andLevel:[_character level]];
	
	if ([_character doingAction] == TRUE)
	{
		[self doAction];

	}
	else if ([_character currentEnemy] !=nil) // we're in combat
	{
		[self doCombatIteration];
	}
	else 
	{
		[self doOutOfCombatIteration];
	}

}

-(void) viewDidLoad
{
	[[self contentView] setDelegate:self];
	[self updateUI];
	[NSTimer scheduledTimerWithTimeInterval:(1/60.0f) target:self selector:@selector(gameLoop) userInfo:nil repeats:YES];
	
	UIBarButtonItem *anotherButton = [[UIBarButtonItem alloc] initWithTitle:@"Character Info" style:UIBarButtonItemStylePlain target:self action:@selector(displayInventory)];          
	self.navigationItem.rightBarButtonItem = anotherButton;
	[anotherButton release];
	//Spell* spell = [_world getRandomSpellForCharacter:_character];
	//[_character addSpell:spell];


	
}
-(void) viewWillAppear:(BOOL)animated
{
	// Whenever the view appears, reload the data from the model
	[self.navigationController setNavigationBarHidden:TRUE animated:YES];
	[self updateUI];
}
- (BOOL) shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
{
    return TRUE;
}

-(void) gameScreen:(GameScreen *)gameScreen addGold:(int)gold
{
	[_character incrementGold:gold];
	
}
-(BOOL) compareLocations:(CGPoint)loc1 loc2:(CGPoint)loc2
{
	if ((loc1.x==loc2.x) && (loc1.y==loc2.y)) 
	{
		return TRUE;
	}
	return FALSE;
}

-(void) populateVendorInventory
{
	//NSMutableArray* vendor = [[NSMutableArray alloc] init];
	[_items removeAllObjects];
	for (int i = 0; i < 100; i++)
	{
		// item level is anything plus or minus ours by a bit
		int level = [_character level] + arc4random()%10-5;
		if (level < 1)
			level = 1;
		Item* item = [_world getRandomItemWithLevel:level];
		[_items addObject:item];
	}
	//[_items sortUsingSelector:@selector(compare:)];
}

-(void) populateVendorSpellInventory
{
	[_spells removeAllObjects];
	for (int i = 0; i < 10; i++)
	{
		Spell* spell = [_world getRandomSpellForCharacter:_character];
		[_spells addObject:spell];
	}
}

-(void) displayInventory
{
	//NSLog(@"got here in displayInventory");
	InventoryController* inventoryController = [[InventoryController alloc] initWithCharacter:_character];
	[self.navigationController pushViewController:inventoryController animated:YES];
	[inventoryController release];
}

-(void) infoButtonPressed
{
	//NSLog(@"got here in infobuttonpressed");
	InventoryController* inventoryController = [[InventoryController alloc] initWithCharacter:_character];
	[self.navigationController pushViewController:inventoryController animated:YES];
	[inventoryController release];
	[self.navigationController setNavigationBarHidden:TRUE animated:YES];
}

-(void) mapTouched
{
	MapScrollController* mapScrollController = [[MapScrollController alloc] init];
	[self.navigationController pushViewController:mapScrollController animated:YES];
	[mapScrollController release];
	[self.navigationController setNavigationBarHidden:FALSE animated:YES];
	
}

-(void) combatLogString:(NSString*) string
{
	[[self contentView] addTextToCombatLog:string];
}


@end
