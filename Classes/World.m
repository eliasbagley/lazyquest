//
//  Item.m
//  LazyQuest
//
//  Created by u0565496 on 4/9/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "World.h"

@interface World()
@end

@implementation World

-(id) initWithMap:(NSString*)map andLegend:(NSString*)leg andCreatures:(NSString*)creatures andItems:(NSString*)items
{

	self = [super init];
	if (self == nil)
		return nil;
	
	
	_map = [[NSMutableArray alloc] init];
	_creatureLegend = [[NSMutableArray alloc] init];
	_legend = [[NSMutableDictionary alloc] init];
	_itemLegend = [[NSMutableArray alloc] init];
	_creaturePrefix = [[NSMutableArray alloc] init];
	_itemPrefix = [[NSMutableArray alloc] init];
	_itemSuffix = [[NSMutableArray alloc] init];
	_items = [[NSMutableArray alloc] init];
	_uniqueItems = [[NSMutableArray alloc] init];
	_backgroundLegend = [[NSMutableArray alloc] init];
	_junk = [[NSMutableArray alloc] init];
	_spells = [[NSMutableArray alloc] init];
	_questItems = [[NSMutableArray alloc] init];
	_rareItems = [[NSMutableArray alloc] init];
	int width = 27;

	// build the path based on the pass in f ile name
	NSString* filePathWorld = [[NSBundle mainBundle] pathForResource:@"map-map" ofType:@"txt"];
	NSString* filePathLegend = [[NSBundle mainBundle] pathForResource:@"map-legend" ofType:@"txt"];
	NSString* filePathCreature = [[NSBundle mainBundle] pathForResource:@"map-creature-locations" ofType:@"txt"];
	NSString* filePathItem = [[NSBundle mainBundle] pathForResource:items ofType:@"txt"];
	NSString* filePathCreaturePrefix = [[NSBundle mainBundle] pathForResource:@"creature-prefixes" ofType:@"txt"];
	NSString* filePathItemPrefix = [[NSBundle mainBundle] pathForResource:@"item-prefixes" ofType:@"txt"];
	NSString* filePathItemSuffix = [[NSBundle mainBundle] pathForResource:@"item-suffixes" ofType:@"txt"];
	NSString* filePathUniqueItems = [[NSBundle mainBundle] pathForResource:@"uniqueitems" ofType:@"txt"];
	NSString* filePathBackgroundLegend = [[NSBundle mainBundle] pathForResource:@"background-legend" ofType:@"txt"];
	NSString* filePathJunk = [[NSBundle mainBundle] pathForResource:@"items-junk" ofType:@"txt"];
	NSString* filePathSpells = [[NSBundle mainBundle] pathForResource:@"item-spells" ofType:@"txt"];
	NSString* filePathQuestItems = [[NSBundle mainBundle] pathForResource:@"item-questitems" ofType:@"txt"];
	NSString* filePathRareItems = [[NSBundle mainBundle] pathForResource:@"item-rare" ofType:@"txt"];
	
	// read in all the items
	[self readInItemFileWithName:@"item-mainhand"];
	[self readInItemFileWithName:@"item-offhand"];
	[self readInItemFileWithName:@"item-head"];
	[self readInItemFileWithName:@"item-chest"];
	[self readInItemFileWithName:@"item-leggings"];
	[self readInItemFileWithName:@"item-gloves"];
	[self readInItemFileWithName:@"item-boots"];
	[self readInItemFileWithName:@"item-ring"];
	[self readInItemFileWithName:@"item-ring"];
	[self readInItemFileWithName:@"item-amulet"];
	
	// if the file exists...
	
	if (filePathWorld)
	{

		// get all the text out of the file
		NSString* myText = [NSString stringWithContentsOfFile:filePathWorld];
		// if there's text in the file..
		if (myText)
		{
			NSArray* prerows = [myText componentsSeparatedByString:@"\n"];	

			int count = 0;
			for (int j = 0; j < width; j++)
			{
				NSMutableArray* col = [[NSMutableArray alloc] init];
				for (NSString* s in prerows)
				{
					NSString* c;
					c = [[NSString alloc] initWithFormat:@"%c",[s characterAtIndex:count]];
					[col addObject:c];
				}
				count++;
				[_map addObject:col];
			}
		}
	}
	 
	if (filePathLegend)
	{
		NSString* myText = [NSString stringWithContentsOfFile:filePathLegend];
		if (myText)
		{
			// array of each line..
			NSArray* line = [myText componentsSeparatedByString:@"\n"];
			//NSLog(@"line: %@", line);
			for (NSString* s in line)
			{
				NSArray* string = [s componentsSeparatedByString:@"#"];
				[_legend setObject:[string objectAtIndex:1] forKey:[string objectAtIndex:0]];
			}
									
			
		}
	}
		
	
	if (filePathSpells)
	{
		NSString* spellsText = [NSString stringWithContentsOfFile:filePathSpells];
		if (spellsText)
		{
			NSArray* line = [spellsText componentsSeparatedByString:@"\n"];
			for (NSString* s in line)
			{
				NSArray* string = [s componentsSeparatedByString:@"#"];
				[_spells addObject:string];
				//NSLog(@"array: %@", string);
			}
		}
	}
	
	if (filePathCreature)
	{
		NSString* creatureText = [NSString stringWithContentsOfFile:filePathCreature];
		if (creatureText)
		{
			// array of each line..
			NSArray* line = [creatureText componentsSeparatedByString:@"\n"];
			for (NSString* s in line)
			{
				NSArray* string = [s componentsSeparatedByString:@"#"];
				[_creatureLegend addObject:string];
			}
		}
		
	}
	if (filePathItem)
	{
		NSString* itemText = [NSString stringWithContentsOfFile:filePathItem];
		if (itemText)
		{
			NSArray* line = [itemText componentsSeparatedByString:@"\n"];
			for (NSString* s in line)
			{
				NSArray* string = [s componentsSeparatedByString:@"#"];
				[_itemLegend addObject:string];
			}
			
		}
	}
	
	if (filePathCreaturePrefix)
	{
		NSString* creaturePrefixText = [NSString stringWithContentsOfFile:filePathCreaturePrefix];
		if (creaturePrefixText)
		{
			NSArray* line = [creaturePrefixText componentsSeparatedByString:@"\n"];
			for (NSString* prefix in line)
			{
				[_creaturePrefix addObject:prefix];
			}
		}
	}
	
	if (filePathItemPrefix)
	{
		NSString* itemPrefixText = [NSString stringWithContentsOfFile:filePathItemPrefix];
		if (itemPrefixText)
		{
			NSArray* line = [itemPrefixText componentsSeparatedByString:@"\n"];
			for (NSString* prefix in line)
			{
				[_itemPrefix addObject:prefix];
			}
		}
	}

	if (filePathItemSuffix)
	{
		NSString* itemSuffixText = [NSString stringWithContentsOfFile:filePathItemSuffix];
		if (itemSuffixText)
		{
			NSArray* line = [itemSuffixText componentsSeparatedByString:@"\n"];
			for (NSString* suffix in line)
			{
				NSArray* derp = [suffix componentsSeparatedByString:@"#"];
				[_itemSuffix addObject:derp];
			}
		}
	}
	
	if (filePathUniqueItems)
	{
		NSString* uniqueItemText = [NSString stringWithContentsOfFile:filePathUniqueItems];
		if (uniqueItemText)
		{
			NSArray* line = [uniqueItemText componentsSeparatedByString:@"\n"];
			for (NSString* uniqueItem in line)
			{
				NSArray* itemInfo = [uniqueItem componentsSeparatedByString:@"#"];
				[_uniqueItems addObject:itemInfo];
			}
		}
	}
	
	if (filePathBackgroundLegend)
	{
		NSString* backgroundLegendText = [NSString stringWithContentsOfFile:filePathBackgroundLegend];
		if (backgroundLegendText)
		{	
			NSArray* line = [backgroundLegendText componentsSeparatedByString:@"\n"];
			for (NSString* backgroundImageString in line)
			{
				NSArray* backgroundImageInfo = [backgroundImageString componentsSeparatedByString:@"#"];
				[_backgroundLegend addObject:backgroundImageInfo];
				//NSLog(@"yerdle! %@",backgroundImageInfo);
			}
		}
	}
	
	if (filePathJunk)
	{
		NSString* junkText = [NSString stringWithContentsOfFile:filePathJunk];
		if (junkText)
		{
			NSArray* line = [junkText componentsSeparatedByString:@"\n"];
			for (NSString* junkItem in line)
			{
				[_junk addObject:junkItem];
			}
		}
	}
	
	if (filePathQuestItems)
	{
		NSString* junkText = [NSString stringWithContentsOfFile:filePathQuestItems];
		if (junkText)
		{
			NSArray* line = [junkText componentsSeparatedByString:@"\n"];
			for (NSString* junkItem in line)
			{
				[_questItems addObject:junkItem];
			}
		}
	}
	
	if (filePathRareItems)
	{
		NSString* rareText = [NSString stringWithContentsOfFile:filePathRareItems];
		if (rareText)
		{
			NSArray* line = [rareText componentsSeparatedByString:@"\n"];
			for (NSString* item in line)
			{
				NSArray* separatedItem = [item componentsSeparatedByString:@"#"];
				[_rareItems addObject:separatedItem];
			}
		}
		
	}
	
	
	return self;
}

-(void) dealloc
{
	// clean up after we take a sucker's money
	[_map release];
	[_creatureLegend release];
	[_legend release];
	[_itemLegend release];
	[_creaturePrefix release];
	[_itemPrefix release];
	[_itemSuffix release];
	[_items release];
	[_uniqueItems release];
	[_backgroundLegend release];
	[_junk release];
	[_questItems release];
	[_rareItems release];
	[super dealloc];
}

@synthesize spells =  _spells;
@synthesize items = _items;
@synthesize itemSuffix = _itemSuffix;
@synthesize itemPrefix = _itemPrefix;
@synthesize creaturePrefix = _creaturePrefix;
@synthesize legend = _legend;
@synthesize map = _map;
@synthesize creatureLegend = _creatureLegend;
@synthesize itemLegend = _itemLegend;
@synthesize backgroundLegend = _backgroundLegend;


-(NSString*) getCreatureNameFromThisCoordinate:(CGPoint)coordinate
{
	
	NSMutableArray* rarities = [[NSMutableArray alloc] init];
	NSMutableArray* creatures = [[NSMutableArray alloc] init];
	NSString* type = [[_map objectAtIndex:coordinate.x] objectAtIndex:coordinate.y];
	
	for (NSArray* array in _creatureLegend)
	{
		NSString* possibleLocations = [array objectAtIndex:1];
		NSArray* eachLocation = [possibleLocations componentsSeparatedByString:@" "];
		for (NSString* candidate in eachLocation)
		{
			if ([candidate isEqualToString:type])
			{
				NSString* creature = [array objectAtIndex:0];
				NSString* rarity = [array objectAtIndex:2];
				// parse rarity string to float
				//float fl = [rarity floatValue];
				NSNumber* rarityFloat =  [[NSNumber alloc] initWithFloat:[rarity floatValue]];
				
				// then this is a candidate creature
				[creatures addObject:creature];
				[rarities addObject:rarityFloat];
			}
		}
		/*
		if ([[array objectAtIndex:1] isEqualToString:type])
		{
			NSString* creature = [array objectAtIndex:0];
			NSString* rarity = [array objectAtIndex:2];
			// parse rarity string to float
			//float fl = [rarity floatValue];
			NSNumber* rarityFloat =  [[NSNumber alloc] initWithFloat:[rarity floatValue]];
			
			// then this is a candidate creature
			[creatures addObject:creature];
			[rarities addObject:rarityFloat];
		}
		 */
	}
	
	// normalize the numbers in the rarities array
	float length = 0;
	//int size = [rarities count];
	for (NSNumber* f in rarities)
	{
		length += [f floatValue];
	}
	//length = sqrt(length);
	//for (int i = 0; i < size; i++)
	//{
	//	float f = [rarities objectAtIndex:i];
	//	[rarities replaceObjectAtIndex: withObject:f/length];
	//}
	//[.1 .3 .2 .1 .1 .1 .1]
	
	
	// choose random creature based on normalized rarities
	//srand(time(nil));
	float rand = length*drand48();
	
	for (int i = 0; i < [rarities count]; i++)
	{
		NSNumber* f = [rarities objectAtIndex:i];
		rand-=[f floatValue];
		if (rand <= 0)
		{

			NSString* creatureName = [creatures objectAtIndex:i];
			return creatureName;
		}
	}
	
	return nil;
}

-(Creature*) getCreatureFromThisCoordinate:(CGPoint)coordinate andLevel:(int)level;
{
	NSString* creatureName = [self getCreatureNameFromThisCoordinate:coordinate];
	NSString* prefix = [self getCreaturePrefixWithLeveL:level];
	Creature* creature = [[[Creature alloc] initWithName:creatureName prefix:prefix strength:5*level agility:5*level intellect:5*level endurance:5*level gold:10*level] autorelease];
	return creature;
	
}

-(NSString*) getLocationFromCoordinate:(CGPoint)coordinate
{
	NSString* type = [[_map objectAtIndex:coordinate.x] objectAtIndex:coordinate.y];
	NSString* location = [_legend objectForKey:type];
	return location;
	
}

-(Item*) getRandomItemWithLevel:(int)level;
{
	//NSMutableArray* rarities = [[NSMutableArray alloc] init];
	//NSMutableArray* item = [[NSMutableArray alloc] init];
	
	// TODO: finish this once prefix/suffix/rare item generation is figured out
	NSString* prefix;
	NSString* itemName;
	NSArray* suffix;
	int slot = arc4random()%10; // this won't be MISC
	//int slot = 7; // always chest right now
	if (level <= [_itemPrefix count])
	{
		int prefixLevel = arc4random()%level;
		prefix = [self getItemPrefixWithLevel:prefixLevel];
		//int itemSuffixIndex = arc4random()%[_itemSuffix count];
		suffix = [self getRandomItemSuffix];
		NSString* suffixName = [suffix objectAtIndex:0];
		NSArray* itemStats = [[suffix objectAtIndex:1] componentsSeparatedByString:@" "];
		int str = [[itemStats objectAtIndex:0] intValue];
		int agi = [[itemStats objectAtIndex:1] intValue];
		int intellect = [[itemStats objectAtIndex:2] intValue];
		int endurance = [[itemStats objectAtIndex:3] intValue];
		itemName = [NSString stringWithFormat:@"%@ %@ %@", prefix, [self getItemNameWithLevel:(level-prefixLevel) andSlot:slot], suffixName];
		int armor = [self getArmorValueForLevel:(int)level andSlot:(Slot)slot];
		
		Item* item = [[[Item alloc] initWithName:itemName strength:level*str agility:agi*level intellect:level*intellect endurance:level*endurance goldValue:100*level armor:armor slot:slot rarity:COMMON] autorelease];
		return item;
	}
	else 
	{
		int prefixLevel = arc4random()%[_itemPrefix count];
		//NSLog(@"level: %i prefix level: %i", level, prefixLevel);
		prefix = [self getItemPrefixWithLevel:prefixLevel];
		suffix = [self getRandomItemSuffix];
		NSString* suffixName = [suffix objectAtIndex:0];
		NSArray* itemStats = [[suffix objectAtIndex:1] componentsSeparatedByString:@" "];
		
		int str = [[itemStats objectAtIndex:0] intValue];
		int agi = [[itemStats objectAtIndex:1] intValue];
		int intellect = [[itemStats objectAtIndex:2] intValue];
		int endurance = [[itemStats objectAtIndex:3] intValue];
		itemName = [NSString stringWithFormat:@"%@ %@ %@", prefix, [self getItemNameWithLevel:(level-prefixLevel) andSlot:slot], suffixName];
		int armor = [self getArmorValueForLevel:(int)level andSlot:(Slot)slot];
		Item* item = [[[Item alloc] initWithName:itemName strength:level*str agility:agi*level intellect:level*intellect endurance:level*endurance goldValue:100*level armor:armor slot:slot rarity:COMMON] autorelease];
	//	NSLog(@"item: %@", item);
		return item;
		
	}


	return nil;
	
}
					 
-(int) getArmorValueForLevel:(int)level andSlot:(Slot)slot
{
	int armorRandomness = arc4random()%(10*level)-5*level;
	//NSLog(@"armor randomness = %i", armorRandomness);
	// these items provide no armor
	if (slot == RING1 || slot == RING2 || slot == AMULET || slot == MAINHAND || slot == MISC)
	{
		return 0;
	}
	else 
	{
		// small amount of armor
		if (slot == GLOVES || slot == BOOTS)
		{
			return 10*level + armorRandomness;
		}
		// medium amount of armor
		else if (slot == LEGGINGS || slot == HEAD)
		{
			return 15*level + armorRandomness;
		}
		// large amounts of armor
		else if (slot == CHEST || slot == OFFHAND)
		{
			return 20*level+armorRandomness;
		}
			
	}
	
	NSAssert(FALSE, @"you're missing an item type to assign armor to");
	return 0;

}
					  
-(NSString*) getItemNameWithLevel:(int)level andSlot:(int)slot
{
	//NSLog(@"beginning to get item name with level: %i and slot %i", level, slot);
	NSArray* itemsOfSlot = [_items objectAtIndex:slot];  // array of (level: % separated list of item names)
	//NSLog(@"items of slot: %@", itemsOfSlot);
	int count = 0;
	for (NSArray* possibleItems in itemsOfSlot)
	{	
		count++;
		int itemLevel = [[possibleItems objectAtIndex:0] intValue];
			//NSLog(@"here2");
		if (itemLevel >= level)
		{

			break;
		}
		

		
	}
	count--;

	//NSLog(@"got here with count %i and slot = %i", count, slot);
	NSArray* possibleItems = [itemsOfSlot objectAtIndex:count];
	//NSLog(@"possible items: %@", possibleItems);
	NSArray* possibleItemNames = [[possibleItems objectAtIndex:1] componentsSeparatedByString:@"%"];
	int itemIndex = arc4random()%[possibleItemNames count];
	NSString* itemName = [possibleItemNames objectAtIndex:itemIndex];
	
	return itemName;
}
						  
-(NSString*) getItemPrefixWithLevel:(int)level
{
	return [_itemPrefix objectAtIndex:level];
}

-(NSArray*) getRandomItemSuffix
{
	int index = arc4random()%[_itemSuffix count];
	return [_itemSuffix objectAtIndex:index];
}

-(NSString*) getCreaturePrefixWithLeveL:(int)level
{
	
	return [_creaturePrefix objectAtIndex:(level-1)];
}

-(NSArray*) getRandomItemWithLevel:(int)level andSlot:(int)slot
{
	return nil;	
}

-(void) readInItemFileWithName:(NSString*)name
{
	NSString* filePathMH = [[NSBundle mainBundle] pathForResource:name ofType:@"txt"];
	if (filePathMH)
	{
		NSMutableArray* MHArray = [[[NSMutableArray alloc] init] autorelease];
		NSString* MHText = [NSString stringWithContentsOfFile:filePathMH];
		if (MHText)
		{
			NSArray* line = [MHText componentsSeparatedByString:@"\n"];
			for (NSString* s in line)
			{
				NSArray* array = [s componentsSeparatedByString:@"#"];
				[MHArray addObject:array];
			}
		}
		[_items addObject:MHArray];
	}
}

-(NSString*) getBackgroundPictureNameFromLocation:(CGPoint)location
{
//	NSLog(@"getting here..");
	// look up in the map to see what char the location corresponts to
	NSString* locChar = [[_map objectAtIndex:location.x] objectAtIndex:location.y];
	
	// look up the string image name from the backgroundLegend
	for (NSArray* backgroundImageInfo in _backgroundLegend)
	{
		NSString* backgroundImageName = [backgroundImageInfo objectAtIndex:0];
		NSArray* backgroundImageLoactions = [[backgroundImageInfo objectAtIndex:1] componentsSeparatedByString:@" "];
		for (NSString* charLocation in backgroundImageLoactions)
		{
			if ([charLocation isEqualToString:locChar]) 
			{
			//	NSLog(@"background image name: %@", backgroundImageName);
				return backgroundImageName;
			}
		}
	}
				
	//NSLog(@"locChar: %@", locChar);
	NSAssert(FALSE, @"why are we given a location that doesn't exist? in getBackgroundPictureFromNameLocation");
	return nil;
}

-(Item*) getRandomJunkItem
{
	int index = arc4random()%[_junk count];
	int goldValue = arc4random()%50;
	NSString* junkName = [_junk objectAtIndex:index];
	Item* junkItem = [[[Item alloc] initWithName:junkName strength:0 agility:0 intellect:0 endurance:0 goldValue:goldValue armor:0 slot:MISC rarity:JUNK] autorelease];
	return junkItem;
}

-(Spell*) getRandomSpellForCharacter:(Character *)character
{
	NSMutableArray* values = [[NSMutableArray alloc] init];
	NSMutableArray* spells = [[NSMutableArray alloc] init];
	//NSLog(@"spells: %@", _spells);
	for (NSArray* array in _spells)
	{
		NSArray* statCoefficients = [[array objectAtIndex:1] componentsSeparatedByString:@" "];
		NSNumber* value =[[NSNumber alloc] initWithFloat:([character strengthCoefficient]*[[statCoefficients objectAtIndex:0] floatValue] + [character agilityCoefficient]*[[statCoefficients objectAtIndex:1] floatValue]  + [character intellectCoefficient]*[[statCoefficients objectAtIndex:2] floatValue]  + [character enduranceCoefficient]*[[statCoefficients objectAtIndex:3] floatValue])];
		NSNumber* newNumber = [[NSNumber alloc] initWithFloat:[value floatValue]*[value floatValue]];
		[values addObject:newNumber];
		
		NSString* spellName = [array objectAtIndex:0];
		//NSLog(@"spell name: %@ with value: %f", spellName, [newNumber floatValue]);
		
		int damage = arc4random()%10+20;
		
		Spell* spell = [[Spell alloc] initWithName:spellName manaCost:[character maxMana]/10 addedDamage:damage];
		[spells addObject:spell];
		[value release];
		[newNumber release];

	}
	
	float length = 0;
	for (NSNumber* f in values)
	{
		length += [f floatValue];
	}
	//NSLog(@"length: %f", length);
	float rand = length*drand48();
	//NSLog(@"rand: %f", rand);
	for (int i = ([values count]-1); i >= 0; i--)
	{
		NSNumber* f = [values objectAtIndex:i];
		rand-=[f floatValue];
		if (rand <=0)
		{
			return [spells objectAtIndex:i];
		}
	}
	
	NSAssert(FALSE, @"spell isn't getting made right");
	return nil;
	
	
}

-(NSString*) getRandomQuestItem
{
	int randIndex = arc4random()%[_questItems count];
	NSString* itemName = [_questItems objectAtIndex:randIndex];
	return itemName;
}
-(Item*) getRandomRareItemWithLevel:(int)level
{
	NSMutableArray* potentialItems = [[NSMutableArray alloc] init];
	for (NSArray* itemArray in _rareItems)
	{
		NSString* itemName = [itemArray objectAtIndex:0];
		int itemLevel = [[itemArray objectAtIndex:1] intValue];
		int itemSlot = [[itemArray objectAtIndex:2] intValue];
		NSArray* itemStats = [[itemArray objectAtIndex:3] componentsSeparatedByString:@" "];
		//NSLog(@"d%@",itemName);
		if (itemLevel<=level)
		{
			Item* possibleItem = [[Item alloc] initWithName:itemName strength:[[itemStats objectAtIndex:0] intValue] agility:[[itemStats objectAtIndex:1] intValue] intellect:[[itemStats objectAtIndex:2] intValue] endurance:[[itemStats objectAtIndex:3] intValue] goldValue:1000+level*100 armor:[[itemStats objectAtIndex:4] intValue] slot:itemSlot rarity:3];
			[potentialItems addObject:possibleItem];
		}
	}
	
	if ([potentialItems count]==0) 
	{
		return [self getRandomJunkItem];
	}
	
	
	int randIndex = arc4random()%[potentialItems count];
	return [potentialItems objectAtIndex:randIndex];
}

@end
 
