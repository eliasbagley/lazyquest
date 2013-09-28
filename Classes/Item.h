//
//  Item.h
//  LazyQuest
//
//  Created by u0565496 on 4/9/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Character.h"

typedef enum
{
	MAINHAND,
	OFFHAND,
	HEAD,
	CHEST,
	LEGGINGS,
	GLOVES,
	BOOTS,
	RING1,
	RING2,
	AMULET,
	MISC
} Slot;

typedef enum
{
	JUNK,
	COMMON,
	UNCOMMON,
	RARE,
	EPIC,
	LEGENDARY
} Rarity;

@interface Item : NSObject <NSCoding>
{
	NSString* _itemName;
	int _strength;
	int _intellect;
	int _agility;
	int _endurance;
	int _armor;
	Slot _slot;
	int _goldValue;
	Rarity _rarity;
}

@property(nonatomic, assign) int armor;
@property(nonatomic, assign) int goldValue;
@property(nonatomic, retain) NSString* itemName;
@property(nonatomic, assign) int strength;
@property(nonatomic, assign) int intellect;
@property(nonatomic, assign) int agility;
@property(nonatomic, assign) int endurance;
@property(nonatomic, assign) Slot slot;
@property(nonatomic, assign) Rarity rarity;

-(id) initWithName:(NSString*)itemName 
		  strength:(int) strength
		   agility:(int) agility
		 intellect:(int) intellect
		 endurance:(int) endurance
		 goldValue:(int)goldValue
			 armor:(int)armor
			  slot:(Slot)slot
			rarity:(Rarity)rarity;

-(NSString*) description;
-(float) itemLevelForCharacter:(Character*)character;

@end
