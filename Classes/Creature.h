//
//  Creature.h
//  LazyQuest
//
//  Created by u0565496 on 4/8/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

@class Item;
#import <Foundation/Foundation.h>
#import "Item.h"
#import "Spell.h"

@interface Creature : NSObject 
{
	NSString* _name;
	NSString* _prefix;
	
	int _strength;
	int _agility;
	int _intellect;
	int _endurance;
	int _armor;
	int _currentHealth;
	int _currentMana;
	
	NSMutableArray* _spells;
	long _gold;
	NSString* _action;
	float _actionDuration;
	float _actionProgress;
}

@property(nonatomic, assign) int armor;
@property(nonatomic, retain) NSString* prefix;
@property(nonatomic, retain) NSString* action;
@property(nonatomic, assign) float actionDuration;
@property(nonatomic, assign) float actionProgress;
@property(nonatomic, assign) int strength;
@property(nonatomic, assign) int agility;
@property(nonatomic, assign) int intellect;
@property(nonatomic, assign) int endurance;
@property(nonatomic, assign) int currentHealth;
@property(nonatomic, assign) int currentMana;
@property(nonatomic, retain) NSString* name;
@property(nonatomic, assign) long gold;


-(id) initWithName:(NSString*)name 
	   	 prefix:(NSString*)prefix
		  strength:(int) strength
		   agility:(int) agility
		 intellect:(int) intellect
		 endurance:(int) endurance
			  gold:(int)gold;


-(Spell*) spellAtIndex:(NSInteger)spellIndex;
-(void) addSpell:(Spell*)spell;
-(int) spellCount;

-(int) maxHealth;
-(int) maxMana;

// combat stuff
-(float) attackSpeed; // attacks per second
-(float) attackDamage;

-(void) incrementHealth:(int)deltaHealth;
-(Spell*) getBestAttack;

-(NSString*) description;

@end
