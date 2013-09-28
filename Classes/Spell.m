//
//  Spell.m
//  LazyQuest
//
//  Created by u0565496 on 4/9/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "Spell.h"

@interface Spell()
@end

@implementation Spell

-(id) initWithName:(NSString*)spellName
		  manaCost:(int)manaCost
	   addedDamage:(int) addedDamage
{
	self = [super init];
	if (self == nil)
		return nil;
	
	_spellName = [spellName retain];
	_manaCost = manaCost;
	_addedDamage = addedDamage;
	_rank = 1;
	
	return self;
}

-(void) dealloc
{
	// clean up after we take a sucker's money
	[_spellName release];
	[super dealloc];
}

@synthesize spellName = _spellName;
@synthesize manaCost = _manaCost;
@synthesize addedDamage = _addedDamage;
@synthesize rank = _rank;
@synthesize price = _price;


-(id) initWithCoder:(NSCoder*)decoder
{
	if (self = [super init])
	{
		self.spellName = [decoder decodeObjectForKey:@"spellName"];
		self.manaCost = [decoder decodeIntForKey:@"manaCost"];
		self.addedDamage = [decoder decodeIntForKey:@"addedDamage"];
		self.rank = [decoder decodeIntForKey:@"rank"];
		self.price = [decoder decodeIntForKey:@"price"];
	}
	return self;
	
}
-(void) encodeWithCoder:(NSCoder *)encoder
{
	[encoder encodeObject:_spellName forKey:@"spellName"];
	[encoder encodeInt:_manaCost forKey:@"manaCost"];
	[encoder encodeInt:_addedDamage forKey:@"addedDamage"];
	[encoder encodeInt:_rank forKey:@"rank"];
	[encoder encodeInt:_price forKey:@"price"];
}


-(void) incrementRank
{
	_addedDamage+=30;
	_price*=3;
	_manaCost+=40;
	_rank++;
}

-(NSString*) description
{
	if( [_spellName isEqualToString:@"Attacking"])
	{
		return _spellName;
	}
	NSString* descr = [NSString stringWithFormat:@"%@ Rank %i", _spellName, _rank];
	
	return descr;
}

-(NSString*) descriptionPrint
{
	if( [_spellName isEqualToString:@"Attacking"])
	{
		return @"";
	}
	NSString* descr = [NSString stringWithFormat:@"%@ Rank %i\n(+%i Dmg %i Mana)", _spellName, _rank, _addedDamage, _manaCost];
	
	return descr;
}

@end
