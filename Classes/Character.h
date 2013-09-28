//
//  Character.h
//  LazyQuest
//
//  Created by u0565496 on 4/8/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

@class Item, Quest, Character, Creature;
#import <Foundation/Foundation.h>
#import "Item.h"
#import "Quest.h"
#import "Spell.h"
#import "Creature.h"

@protocol CharacterDelegate
-(void) characterChanged:(Character*)character;
-(void) combatLogString:(NSString*)string;
@end

@interface Character : NSObject 
{
	NSObject<CharacterDelegate>* _delegate;
	
	NSString* _name;
	NSString* _className;
	
	int _strength;
	int _agility;
	int _intellect;
	int _endurance;
	int _armor;
	
	int _saveGameSlot;
	
	int _level;
	
	float _strengthCoefficient;
	float _agilityCoefficient;
	float _intellectCoefficient;
	float _enduranceCoefficient;
	
	int _currentHealth;
	int _currentMana;
	
	NSMutableArray* _inventory;
	NSMutableArray* _spells;
	NSMutableArray* _gear;
	
	
	unsigned long long _xpIntoLevel;
	//int _xpToNextLevel;
	unsigned long long _gold;
	
	Quest* _currentQuest;
	CGPoint _currentLocation;
	
	// game loop information
	Creature* _currentEnemy;
	BOOL _doingAction;
	NSString* _action;
	float _actionDuration;
	float _actionProgress;
	
	int _introFlag;
	
}

@property(nonatomic, assign) int introFlag;
@property(nonatomic, assign) int saveGameSlot;
@property(nonatomic, assign) int armor;
@property(nonatomic, retain) NSMutableArray* gear;
@property(nonatomic, retain) NSMutableArray* inventory;
@property(nonatomic, retain) NSMutableArray* spells;
@property(nonatomic, assign) float actionProgress;
@property(nonatomic, assign) float actionDuration;
@property(nonatomic, retain) NSString* action;
@property(nonatomic, retain) Creature* currentEnemy;
@property(nonatomic, assign) BOOL doingAction;
@property(nonatomic, assign) int level;
@property(nonatomic, assign) float strengthCoefficient;
@property(nonatomic, assign) float agilityCoefficient;
@property(nonatomic, assign) float intellectCoefficient;
@property(nonatomic, assign) float enduranceCoefficient;
@property(nonatomic, retain) NSString* className;
@property(nonatomic, assign) NSObject<CharacterDelegate>* delegate;
@property(nonatomic, assign) CGPoint currentLocation;
@property(nonatomic, retain) Quest* currentQuest;
@property(nonatomic, assign) int strength;
@property(nonatomic, assign) int agility;
@property(nonatomic, assign) int intellect;
@property(nonatomic, assign) int endurance;
@property(nonatomic, assign) int currentHealth;
@property(nonatomic, assign) int currentMana;
@property(nonatomic, retain) NSString* name;
@property(nonatomic, assign) unsigned long long xpIntoLevel;
@property(nonatomic, assign) unsigned long long gold;


-(id) initWithName:(NSString*)name 
		  strength:(float) strength
		   agility:(float) agility
		 intellect:(float) intellect
		 endurance:(float) endurance
		 className:(NSString*)className
currentLocation:(CGPoint)currentLocation;

-(void) addItem:(Item*)item;
-(void) addSpell:(Spell*)spell;

-(int) inventoryCount;
-(int) spellCount;

-(int) maxHealth;
-(int) maxMana;

-(int) level;
-(void) updateStats;

// combat stuff
-(float) attackSpeed; // attacks per second
-(float) attackDamage;

-(void)incrementHealth:(int)deltaHealth;
-(void)incrementMana:(int)deltaMana;
-(void)incrementXP:(unsigned long long)deltaXP;
-(void)incrementGold:(int)gold;
-(void) attackEnemy:(int)damage withCrit:(BOOL)crit;
-(void) receiveNewItem:(Item*)item;
-(void) equipItem:(Item*)item;
-(unsigned long long) xpToNextLevel;

-(Spell*) getBestAttack;

-(void)levelUp;
-(void) sellLastItem;
-(NSString*) description;
-(float) getCritPercentage;

@end
