//
//  Item.h
//  LazyQuest
//
//  Created by u0565496 on 4/9/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Creature.h"
#import "Spell.h"
#import "Character.h"

@interface World : NSObject 
{
	NSMutableArray* _map;
	NSMutableDictionary* _legend;
	NSMutableArray* _creatureLegend;
	NSMutableArray* _creaturePrefix;
	NSMutableArray* _itemLegend;
	NSMutableArray* _itemPrefix;
	NSMutableArray* _itemSuffix;
	NSMutableArray* _items;
	NSMutableArray* _uniqueItems;
	NSMutableArray* _backgroundLegend;
	NSMutableArray* _junk;
	NSMutableArray* _spells;
	NSMutableArray* _questItems;
	NSMutableArray* _rareItems;
}

@property(nonatomic, retain) NSMutableArray* spells;
@property(nonatomic, retain) NSMutableArray* backgroundLegend;
@property(nonatomic, retain) NSMutableArray* items;
@property(nonatomic, retain) NSMutableArray* itemPrefix;
@property(nonatomic, retain) NSMutableArray* itemSuffix;
@property(nonatomic, retain) NSMutableArray* creaturePrefix;
@property(nonatomic, retain) NSMutableArray* creatureLegend;
@property(nonatomic, retain) NSMutableDictionary* legend;
@property(nonatomic, retain) NSMutableArray* map;
@property(nonatomic, retain) NSMutableArray* itemLegend;

-(id) initWithMap:(NSString*)map andLegend:(NSString*)leg andCreatures:(NSString*)creatures andItems:(NSString*)items;
-(NSString*) getLocationFromCoordinate:(CGPoint)coordinate;
-(NSString*) getCreatureNameFromThisCoordinate:(CGPoint)coordinate;
-(Creature*) getCreatureFromThisCoordinate:(CGPoint)coordinate andLevel:(int)level;
-(Item*) getRandomItemWithLevel:(int)level;
-(Item*) getRandomJunkItem;
-(NSString*) getCreaturePrefixWithLeveL:(int)level;
-(NSString*) getItemPrefixWithLevel:(int)level;
-(NSString*) getItemNameWithLevel:(int)level andSlot:(int)slot;
-(NSArray*) getRandomItemSuffix;
-(NSArray*) getRandomItemWithLevel:(int)level andSlot:(int)slot;
-(void) readInItemFileWithName:(NSString*)name;
-(NSString*) getBackgroundPictureNameFromLocation:(CGPoint)location;
-(int) getArmorValueForLevel:(int)level andSlot:(Slot)slot;
-(Spell*) getRandomSpellForCharacter:(Character*)character;
-(NSString*) getRandomQuestItem;
-(Item*) getRandomRareItemWithLevel:(int)level;
@end

