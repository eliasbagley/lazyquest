//
//  Item.m
//  LazyQuest
//
//  Created by u0565496 on 4/9/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "Item.h"

@interface Item()
@end

@implementation Item

-(id) init
{
	self = [super init];
	if (self == nil)
		return nil;
	
	return self;
}

-(id) initWithCoder:(NSCoder*)decoder
{
    
	if (self = [super init])
	{
	self.strength = [decoder decodeIntForKey:@"strength"];
	self.agility = [decoder decodeIntForKey:@"agility"];
	self.intellect = [decoder decodeIntForKey:@"intellect"];
	self.endurance = [decoder decodeIntForKey:@"endurance"];
	self.goldValue = [decoder decodeIntForKey:@"goldValue"];
	self.armor = [decoder decodeIntForKey:@"armor"];
	[self setSlot:[decoder decodeIntForKey:@"slot"]];
	self.rarity = [decoder decodeIntForKey:@"rarity"];
	self.itemName = [decoder decodeObjectForKey:@"itemName"];
	}
	return self;
	
}
-(void) encodeWithCoder:(NSCoder *)encoder
{
	[encoder encodeInt:_strength forKey:@"strength"];
	[encoder encodeInt:_agility forKey:@"agility"];
	[encoder encodeInt:_intellect forKey:@"intellect"];
	[encoder encodeInt:_endurance forKey:@"endurance"];
	[encoder encodeInt:_goldValue forKey:@"goldValue"];
	[encoder encodeInt:_armor forKey:@"armor"];
	[encoder encodeInt:_slot forKey:@"slot"];
	[encoder encodeInt:_rarity forKey:@"rarity"];
	[encoder encodeObject:_itemName forKey:@"itemName"];
}

-(id) initWithName:(NSString*)itemName 
		  strength:(int) strength
		   agility:(int) agility
		 intellect:(int) intellect
		 endurance:(int) endurance
			 goldValue:(int)goldValue
			 armor:(int)armor
			  slot:(Slot)slot
			rarity:(Rarity)rarity
{
	self = [super init];
	if (self == nil)
		return nil;
	
	
	_itemName = [itemName retain];
	_strength = strength;
	_agility = agility;
	_intellect = intellect;
	_endurance = endurance;
	_goldValue = goldValue;
	_slot = slot;
	_rarity = rarity;
	_armor = armor;
	
	return self;
}

@synthesize armor = _armor;
@synthesize goldValue = _goldValue;
@synthesize itemName = _itemName;
@synthesize strength = _strength;
@synthesize intellect = _intellect;
@synthesize agility = _agility;
@synthesize endurance = _endurance;
@synthesize slot = _slot;
@synthesize rarity = _rarity;

-(float) itemLevelForCharacter:(Character*)character
{
	float str = [character strengthCoefficient];
	float agi = [character agilityCoefficient];
	float intel = [character intellectCoefficient];
	float end = [character enduranceCoefficient];

	float itemLevel = str*_strength + agi*_agility + intel*_intellect + end*_endurance;
	return itemLevel;
	
}

-(NSString*) description
{
	if(_rarity==0)
	{
		NSString* descr = [NSString stringWithFormat:@"%@", _itemName];
		return descr;
	}
	
	NSString* descr = [NSString stringWithFormat:@"%@\n(%i Str/%i Agi/%i Int/%i Vit/%i Ar)", _itemName, _strength, _agility, _intellect, _endurance, _armor];
	return descr;
}

@end
