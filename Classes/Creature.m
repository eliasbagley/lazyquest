//
//  Creature.m
//  LazyQuest
//
//  Created by u0565496 on 4/8/11.
//  Copyright 2011 Deedlestein INC. All rights reserved.
//

#import "Creature.h"

@interface Creature()
@end

@implementation Creature

-(id) initWithName:(NSString*)name 
			prefix:(NSString*)prefix
		  strength:(int) strength
		   agility:(int) agility
		 intellect:(int) intellect
		 endurance:(int) endurance
			  gold:(int)gold
{
	self = [super init];
	if (self == nil)
		return nil;
	
	_armor = 0;
	_name = [name retain];
	_prefix = [prefix retain];
	_strength = strength;
	_agility = agility;
	_intellect = intellect;
	_endurance = endurance;
	_spells = [[NSMutableArray alloc] init];
	_gold = gold;
	
	_currentHealth = [self maxHealth];
	_currentMana = [self maxMana];
	
	Spell* autoAttack = [[Spell alloc] initWithName:@"Attacking" manaCost:0 addedDamage:0];
	[self addSpell:autoAttack];
	
	return self;
}


-(id) init
{
    NSAssert(TRUE, @"Must supply name and stats to create a character.");
    return nil;
}

-(void) dealloc
{
	[_spells release];
	[_action release];
	[_name release];
	[_prefix release];
	[super dealloc];
}

@synthesize armor = _armor;
@synthesize prefix = _prefix;
@synthesize action = _action;
@synthesize actionDuration = _actionDuration;
@synthesize actionProgress = _actionProgress;
@synthesize strength = _strength;
@synthesize agility = _agility;
@synthesize intellect = _intellect;
@synthesize endurance = _endurance;
@synthesize currentHealth = _currentHealth;
@synthesize currentMana = _currentMana;
@synthesize name = _name;
@synthesize gold = _gold;


-(Spell*) spellAtIndex:(NSInteger)spellIndex
{
	NSAssert(spellIndex < [_spells count], @"Not possible to index outside of spells array");
	Spell* spell = [_spells objectAtIndex:spellIndex];
	return spell;
}

-(void) addSpell:(Spell*)spell
{
	[_spells addObject:spell];
}

-(void) incrementHealth:(int)deltaHealth
{	
	_currentHealth += deltaHealth;
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
	return 10*_endurance;
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
		return AP;
	}		
	return MP;
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

-(NSString*) description
{
	NSString* name = [NSString stringWithFormat:@"%@ %@", _prefix, _name];
	NSString* description = [NSString stringWithFormat:@"Name: %@\nHealth: [%i/%i]\nMana: [%i/%i]\nStats:(+%i/+%i/+%i/+%i)", name, _currentHealth, [self maxHealth], _currentMana, [self maxMana], _strength, _agility, _intellect, _endurance];
	return description;
}

@end
