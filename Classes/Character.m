//
//  Character.m
//  LazyQuest
//
//  Created by u0565496 on 4/8/11.
//  Copyright 2011 Deedlestein INC. All rights reserved.
//

#import "Character.h"



@interface Character()
@end

@implementation Character


-(id) initWithName:(NSString*)name 
		  strength:(float) strength
		   agility:(float) agility
		 intellect:(float) intellect
		 endurance:(float) endurance
		 className:(NSString*)className
currentLocation:(CGPoint)currentLocation
{
	self = [super init];
	if (self == nil)
		return nil;
	
	_saveGameSlot = 0; // this will be set later to a proper value
	
	_armor = 0;
	_name = [name retain];
	_strengthCoefficient = strength;
	_agilityCoefficient = agility;
	_intellectCoefficient = intellect;
	_enduranceCoefficient = endurance;
	_className = [className retain];
	_inventory = [[NSMutableArray alloc] init];
	_spells = [[NSMutableArray alloc] init];
	_gear = [[NSMutableArray alloc] init];
	_currentLocation = currentLocation;
	_level = 1;
	_xpIntoLevel = 0;
	//_xpToNextLevel = [self xpToNextLevel];
	_gold = 300;
	_currentEnemy = nil;
	_action = @"Buying";
	_actionDuration = 1;
	_actionProgress = 0;
	_introFlag = 1;
	
	for (int i = 0; i < 10; i++)
	{
		Item* none = [[Item alloc] initWithName:@"None" strength:0 agility:0 intellect:0 endurance:0 goldValue:0 armor:0 slot:i rarity:JUNK];
		[_gear addObject:none];
	}

	[self updateStats];
	
	_currentHealth = [self maxHealth];
	_currentMana = [self maxMana];
	
	Spell* autoAttack = [[Spell alloc] initWithName:@"Attacking" manaCost:0 addedDamage:0];
	[self addSpell:autoAttack];
	[self setDoingAction:TRUE];
	//[self setAction:@"Buying"];
	
	
	return self;
}


-(id) init
{
    NSAssert(TRUE, @"Must supply name and stats to create a character.");
    return nil;
}

-(void) dealloc
{
	// TODO
	[self setDelegate:nil];
	[_spells release];
	[_inventory release];
	[_gear release];
	[super dealloc];
}

@synthesize introFlag = _introFlag;
@synthesize saveGameSlot = _saveGameSlot;
@synthesize armor = _armor;
@synthesize gear = _gear;
@synthesize actionDuration = _actionDuration;
@synthesize action = _action;
@synthesize currentEnemy = _currentEnemy;
@synthesize doingAction = _doingAction;
@synthesize level = _level;
@synthesize strengthCoefficient = _strengthCoefficient;
@synthesize agilityCoefficient = _agilityCoefficient;
@synthesize intellectCoefficient = _intellectCoefficient;
@synthesize enduranceCoefficient = _enduranceCoefficient;
@synthesize className = _className;
@synthesize delegate = _delegate;
@synthesize currentLocation = _currentLocation;
@synthesize currentQuest = _currentQuest;
@synthesize strength = _strength;
@synthesize agility = _agility;
@synthesize intellect = _intellect;
@synthesize endurance = _endurance;
@synthesize currentHealth = _currentHealth;
@synthesize currentMana = _currentMana;
@synthesize name = _name;
@synthesize xpIntoLevel = _xpIntoLevel;
@synthesize gold = _gold;
@synthesize actionProgress = _actionProgress;
@synthesize inventory = _inventory;
@synthesize spells = _spells;



-(void) equipItem:(Item*)item
{

	int slot = [item slot];
	// get object already equiped
	Item* current = [_gear objectAtIndex:slot];

	if ([[current itemName] isEqualToString:@"None"])
	{
		// don't add it to the inventory
		[_gear replaceObjectAtIndex:slot withObject:item];
		[_delegate combatLogString:[NSString stringWithFormat:@"Equipping %@", [item itemName]]];
	}
	else 
	{
		
		/*
		if (slot == RING1)
		{
			[current setSlot:RING2];
			[_gear replaceObjectAtIndex:slot withObject:item];
			[self receiveNewItem:current];
		}
		else if (slot == RING2)
		{
			[current setSlot:RING1];
			[_gear replaceObjectAtIndex:slot withObject:item];
			[self receiveNewItem:current];
		}
		 
		else 
		{
		 */
			[self addItem:current];
			[_gear replaceObjectAtIndex:slot withObject:item];
			[_delegate combatLogString:[NSString stringWithFormat:@"Equipping %@", [item itemName]]];
		
		//}

	}
	[self updateStats];
	[_delegate characterChanged:self];
}
-(void) setCurrentQuest:(Quest*)quest
{
	_currentQuest = [quest retain];
	[_delegate characterChanged:self];
	if (quest != nil)
	[_delegate combatLogString:[NSString stringWithFormat:@"Received new quest: %@", [quest name]]];
}
-(void) setCurrentLocation:(CGPoint) location
{
	_currentLocation = location;
	[_delegate characterChanged:self];
}
-(void) setCurrentEnemy:(Creature *)enemy
{
	_currentEnemy = [enemy retain];
	[_delegate characterChanged:self];
	if (enemy != nil)
		[_delegate combatLogString:[NSString stringWithFormat:@"You are being attacked by a %@!", [enemy name]]];
}
-(void) addItem:(Item*)item
{
	[_inventory addObject:item];
	[_delegate characterChanged:self];
	[_delegate combatLogString:[NSString stringWithFormat:@"Adding %@ to inventory", [item itemName]]];
}
-(void) addSpell:(Spell*)spell
{
	NSLog(@"spell name: %@", [spell spellName]);
	if ([[spell spellName] isEqualToString:@"Attacking"])
	{
	}
	else {
	[_delegate combatLogString:[NSString stringWithFormat:@"Learned new spell: %@", [spell spellName]]];	
	}

	
	
	for (Spell* s in _spells)
	{
		if ([[s spellName] isEqualToString:[spell spellName]])
		{
			[s incrementRank];
			[_delegate characterChanged:self];
			
			return;
		}
	}
	[_spells addObject:spell];
	[_delegate characterChanged:self];
	//[_delegate combatLogString:[NSString stringWithFormat:@"Learned new spell:", [spell spellName]]];
}

-(int) inventoryCount
{
	return [_inventory count];
}
-(int) spellCount
{
	return [_spells count];
}

-(int) maxHealth
{
	return 10*_endurance;
}
-(int) maxMana
{
	return 10*_intellect;
}


-(unsigned long long)xpToNextLevel
{	
	
	int XP = 100*(pow(2, [self level]-1));
	return XP;
}

-(float) attackSpeed // attacks per second
{
	return log(_agility)+.5f;
}
-(float) attackDamage
{
	float AP = _strength*2 + _agility;
	float MP = 2*_intellect;
	if (AP>MP) 
	{
		return AP/2;
	}		
	return MP/2;
	
}

-(void) levelUp
{	
	//NSLog(@"You have dinged!");
	_currentHealth = [self maxHealth];
	_currentMana = [self maxMana];
	[_delegate combatLogString:[NSString stringWithFormat:@"Congratulations! You are now level %i!", _level]];
	// play sound file and do a shitty animation
}

-(void) sellLastItem
{
	Item* item = [[_inventory lastObject] retain];
	int goldValue = [[_inventory lastObject] goldValue];
	_gold += goldValue;
	[_inventory removeLastObject];
	[_delegate characterChanged:self];
	[_delegate combatLogString:[NSString stringWithFormat:@"Selling %@ for %i gold", [item itemName], goldValue]];
	[item release];
}

-(void) updateStats
{
	//NSLog(@"updating stats");
	// endurance and intellect before calculating new items
	int previousLevel = _level;
	if (_xpIntoLevel >= [self xpToNextLevel])
	{
		_level++;
		_xpIntoLevel = 0;
	}
	int previousEndurance = _endurance;
	int previousIntellect = _intellect;
	//_level = [self level];

	// stats after calculating item addons
	_strength = _level*(_strengthCoefficient*10)+10;
	_agility = _level*(_agilityCoefficient*10)+10;
	_intellect = _level*(_intellectCoefficient*10)+10;
	_endurance = _level*(_enduranceCoefficient*10)+10;
	_armor = 0;
	
	for (Item* disItem in _gear) 
	{
		_strength+=	[disItem strength];
		_agility+=	[disItem agility];
		_intellect+=[disItem intellect];
		_endurance+=[disItem endurance];
		//NSLog(@"armor added: %i", [disItem armor]);
		_armor +=[disItem armor];
	}
	// add health if items changed endurance or int
	_currentHealth += (_endurance - previousEndurance)*10;
	_currentMana +=(_intellect - previousIntellect)*10;
	if (_currentMana < 0)
		_currentMana = 0;
	if (_level > previousLevel)
	{
		[self levelUp];
	}
	[_delegate characterChanged:self];
}

-(void) attackEnemy:(int)damage withCrit:(BOOL)crit
{	
	// make it more random
	damage = damage + arc4random()%damage - damage/2;
	[_currentEnemy incrementHealth:-1*damage];
	[_delegate characterChanged:self];
	if (crit == FALSE)
	{
	[_delegate combatLogString:[NSString stringWithFormat:@"Hit %@ for %i damage", [_currentEnemy name], damage]];
	}
	else {
	[_delegate combatLogString:[NSString stringWithFormat:@"Crit %@ for %i damage!", [_currentEnemy name], damage]];	
	}

}

-(void) incrementHealth:(int)deltaHealth
{
	//NSLog(@"starting delta health: %i", deltaHealth);
		if (deltaHealth < 0) // taking damage
		{
			deltaHealth = deltaHealth + (arc4random()%abs(deltaHealth)) + deltaHealth/2;
			//NSLog(@"delta health: %i", deltaHealth);
			int amountReduced = _armor/20;
			//NSLog(@"amount reduced: %i", amountReduced);
			deltaHealth = deltaHealth + amountReduced;
			if (deltaHealth > 0)
			{
				//amountReduced = abs(deltaHealth)-1;
				deltaHealth = -1;

			}
			_currentHealth+=deltaHealth;
			[_delegate combatLogString:[NSString stringWithFormat:@"Hit for %i damage. Armor reduced %i damage.", abs(deltaHealth), amountReduced]];
		}
		else 
		{ // regenerating

			_currentHealth+=deltaHealth;
			if (_currentHealth >= [self maxHealth])
			{
				_currentHealth = [self maxHealth];
			}

		}

	if (_currentHealth < 0)
	{
		[_delegate combatLogString:[NSString stringWithFormat:@"You have died. Your body has been found, and are being revived in Thornberg."]];
	}
	[_delegate characterChanged:self];
}
-(void) incrementMana:(int)deltaMana
{
	//NSLog(@"current mana: %i, deltamana %i", _currentMana, deltaMana);
	_currentMana+=deltaMana;
	if (_currentMana > [self maxMana])
	{
		_currentMana = [self maxMana];
	}
	NSAssert(_currentMana >= 0, @"Why do I have negative mana?");
	//if (_currentMana < 0)
	//	_currentMana = 0;
	[_delegate characterChanged:self];
}
-(void) incrementXP:(unsigned long long)deltaXP
{
	_xpIntoLevel +=deltaXP;
	[self updateStats];
	[_delegate combatLogString:[NSString stringWithFormat:@"Received %i xp", deltaXP]];
	//[_delegate characterChanged:self];
}

-(void)incrementGold:(int)gold
{
	_gold +=gold;
	[_delegate characterChanged:self];
	if (gold > 0)
		[_delegate combatLogString:[NSString stringWithFormat:@"Received %i gold", gold]];
}

-(void) receiveNewItem:(Item*)item
{
	//NSLog(@"receiving %@", [item description]);
	Slot slot = [item slot];
	//NSLog(@"slot: %i", slot);
	[_delegate combatLogString:[NSString stringWithFormat:@"Received %@", [item itemName]]];
	//NSLog(@"new item level: %f, old item level: %f", iLevel, currLevel);
	if (slot == MISC)
	{
		[self addItem:item];
		return;
	}

	
	if ([item itemLevelForCharacter:self] > [[_gear objectAtIndex:slot] itemLevelForCharacter:self])
	{
		[self equipItem:item];
	}
	else 
	{
		//NSLog(@"adding to inventory");
		[self addItem:item];
	}

	[_delegate characterChanged:self];
}

-(Spell*) getBestAttack
{
	float max = -1;
	int bestSpell = 0;
	int i = 0;
	for (Spell* spell in _spells)
	{
		if ([spell addedDamage] > max && [spell manaCost] <= [self currentMana])
		{
			max = [spell addedDamage];
			bestSpell = i;
		}
		i++;
	}
	
	return [_spells objectAtIndex:bestSpell];
}

-(NSString*) inventoryDescription
{
	NSString* inventorydesc = [NSString stringWithFormat:@""];
	for(Item* item in _inventory)
	{
		inventorydesc = [inventorydesc stringByAppendingFormat:@"%@\n", [item description]];
	}
	return inventorydesc;
}
-(NSString*) spellsDescription
{
	NSString* spelldesc = [NSString stringWithFormat:@""];
	for(Spell* spell in _spells)
	{	if ([[spell spellName] isEqualToString:@"Attacking"])
		{
		}
		else
			spelldesc = [spelldesc stringByAppendingFormat:@"%@\n\n", [spell descriptionPrint]];
	}
	return spelldesc;
}
-(NSString*) gearDescription
{
	NSString* geardesc = [NSString stringWithFormat:@"MH: %@\n\nOH: %@\n\nHead: %@\n\nChest: %@\n\nLeggings: %@\n\nGloves: %@\n\nBoots: %@\n\nLeftRing :%@\n\nRightRing :%@\n\nAmulet: %@\n", [_gear objectAtIndex:0], [_gear objectAtIndex:1], [_gear objectAtIndex:2], [_gear objectAtIndex:3], [_gear objectAtIndex:4], [_gear objectAtIndex:5], [_gear objectAtIndex:6], [_gear objectAtIndex:7], [_gear objectAtIndex:8], [_gear objectAtIndex:9]];
	return geardesc;
}

-(NSString*) description
{
	NSString* descr = [NSString stringWithFormat:@""];
	
	NSString* characterdesc = [NSString stringWithFormat:@"Name: %@\nClass: %@\nLevel: %i\n\nHealth: %i/%i\nMana: %i/%i\n\nStrength: %i\nAgility: %i\nIntellect: %i\nEndurance: %i\nArmor: %i\nXP: %qu\nGold: %qu\n", _name, _className, _level, _currentHealth, [self maxHealth], _currentMana, [self maxMana], _strength, _agility, _intellect, _endurance, _armor, _xpIntoLevel, _gold];
	
	NSString* geardesc = [NSString stringWithFormat:@"MH: %@\nOH: %@\nHead: %@\nChest: %@\nLeggings: %@\nGloves %@\nBoots: %@\nLeftRing :%@\nRightRing :%@\nAmulet: %@\n", [_gear objectAtIndex:0], [_gear objectAtIndex:1], [_gear objectAtIndex:2], [_gear objectAtIndex:3], [_gear objectAtIndex:4], [_gear objectAtIndex:5], [_gear objectAtIndex:6], [_gear objectAtIndex:7], [_gear objectAtIndex:8], [_gear objectAtIndex:9]];
	
	NSString* spelldesc = [NSString stringWithFormat:@"Spells:\n"];
	for(Spell* spell in _spells)
	{
		spelldesc = [spelldesc stringByAppendingFormat:@"%@\n", [spell description]];
	}
	
	NSString* inventorydesc = [NSString stringWithFormat:@"Inventory:\n"];
	for(Item* item in _inventory)
	{
		inventorydesc = [inventorydesc stringByAppendingFormat:@"%@\n", [item description]];
	}
	
	NSString* questdesc =@"No quest";
	if (_currentQuest != nil)
	{
		questdesc = [NSString stringWithFormat:@"Quest: %@", [_currentQuest description]];
	}

	
	
	NSString* location = [NSString stringWithFormat:@"Current Location: (%i, %i)", (int)_currentLocation.x, (int)_currentLocation.y];
	
	NSString* enemyDescription = @"";
	if (_currentEnemy != nil)
	{
		enemyDescription = [[_currentEnemy description] retain];
	}
	
	descr = [characterdesc stringByAppendingFormat:@"\n%@\n%@\n%@\n%@\n%@\n\nCurrent Enemy:\n", geardesc, spelldesc, inventorydesc, questdesc, location];


	return descr;
}

-(float) getCritPercentage
{
	return (float)_agility/600.0;
}

@end
