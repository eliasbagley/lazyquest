//
//  Quest.m
//  LazyQuest
//
//  Created by u0565496 on 4/9/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "Quest.h"

@interface Quest()
@end

@implementation Quest

-(id) initWithName:(NSString*)name
		goldReward:(int)goldReward
		itemReward:(Item*)itemReward
		  xpReward:(int)xpReward
		  dropRate:(float)dropRate
	   maxProgress:(int)maxProgress
		questStart:(CGPoint)questStart
	 questLocation:(CGPoint)questLocation
		  creature:(NSString*)creatureName
		 questItem:(NSString*)questItem
		   andType:(int)type;
{
	self = [super init];
	if (self == nil)
		return nil;
	
	_name = [name retain];
	_goldReward = goldReward;
	_itemReward = [itemReward retain];
	_xpReward = xpReward;
	_dropRate = dropRate;
	_maxProgress = maxProgress;
	_questStart = questStart;
	_questLocation = questLocation;
	_creatureName = [creatureName retain];
	_questItem = questItem;
	
	return self;
	
}

@synthesize name = _name;
@synthesize goldReward = _goldReward;
@synthesize itemReward = _itemReward;
@synthesize xpReward = _xpReward;
@synthesize dropRate = _dropRate;
@synthesize currentProgress = _currentProgress;
@synthesize maxProgress = _maxProgress;
@synthesize questStart = _questStart;
@synthesize questLocation = _questLocation;
@synthesize creatureName = _creatureName;
@synthesize type = _type;




-(void) incrementProgress
{
	_currentProgress++;
}
-(BOOL) isQuestComplete
{
	if (_currentProgress >= _maxProgress)
	{
		return TRUE;
	}

	return FALSE;

}

+(Quest*) generateQuestWithLevel:(int)level withLocation:(NSString*)location atStart:(CGPoint)startPoint andEnd:(CGPoint)endPoint withCreature:(NSString*)creatureName withQuestType:(int)questType questItem:(Item*)questItem andItemReward:(Item*)reward
{
	// Pick a location
	//NSLog(@"location in quest method: %@", location);
	// get string of location based on coordinates
	/*
	 
	 1)
	 Kill [number] [creature]s at [location]
	 
	 2)
	 Kill [rare creature] at [location]
	 
	 3) 
	 Collect [number] [quest item] from [creature] at [location]
	 
	 4)
	 Deliver [quest item] to [person] at [place]
	 
	 5)
	 Explore [location]
	 
	 
	 */
	// choose a random quest type
	//int type = random()%5+1;

	if (questType == 1)
	{
		// kill [number] [creatures] at location
		int numberOfKills = (random()%6+5)*2;
		int gold = 10*level;
		NSString* questName = [NSString stringWithFormat:@"Kill %i %@s", numberOfKills, creatureName, location];
		Quest* quest = [[Quest alloc] initWithName:questName goldReward:gold itemReward:reward xpReward:100*level dropRate:1 maxProgress:numberOfKills questStart:startPoint questLocation:endPoint creature:creatureName questItem:nil andType:questType];
		return quest;
	}
	else if (questType == 2)
	{
		int numberOfKills = 1;
		int gold = 20*level;
		NSString* questName = [NSString stringWithFormat:@"Kill The %@", creatureName, location];
		Quest* quest = [[Quest alloc] initWithName:questName goldReward:gold itemReward:reward xpReward:100*level dropRate:1 maxProgress:numberOfKills questStart:startPoint questLocation:endPoint creature:creatureName questItem:nil andType:questType];
		return quest;
	}
	else if (questType == 3)
	{
		int numberOfKills = (random()%6+5);
		int gold = 10*level;
		NSString* questName = [NSString stringWithFormat:@"Collect %i %@s", numberOfKills, questItem];
		Quest* quest = [[Quest alloc] initWithName:questName goldReward:gold itemReward:reward xpReward:100*level dropRate:drand48()*.7+.3 maxProgress:numberOfKills questStart:startPoint questLocation:endPoint creature:creatureName questItem:questItem andType:questType];
		return quest;
	}
	else 
	{
		NSAssert(FALSE, @"what is wrong with your quest type?");
	}
	
	return nil;
}

-(NSString*) description
{
	NSString* desc = [NSString stringWithFormat:@"%@ [%i/%i]", _name, _currentProgress, _maxProgress];
	return desc;
}

@end
