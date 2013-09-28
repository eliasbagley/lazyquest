//
//  Quest.h
//  LazyQuest
//
//  Created by u0565496 on 4/9/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Item.h"


@interface Quest : NSObject 
{
	NSString* _name;
	int _goldReward;
	Item* _itemReward;
	int _xpReward;
	float _dropRate;
	int _currentProgress;
	int _maxProgress;
	CGPoint _questStart;
	CGPoint _questLocation;
	NSString* _questItem;
	NSString* _creatureName;
	int _type;
	
}


@property (nonatomic, retain) NSString* name;
@property (nonatomic, assign) int goldReward;
@property (nonatomic, retain) Item* itemReward;
@property (nonatomic, assign) int xpReward;
@property (nonatomic, assign) float dropRate;
@property (nonatomic, assign) int currentProgress;
@property (nonatomic, assign) int maxProgress;
@property (nonatomic, assign) CGPoint questStart;
@property (nonatomic, assign) CGPoint questLocation;
@property (nonatomic, retain) NSString* creatureName;
@property (nonatomic, assign) int type;

-(id) initWithName:(NSString*)name
		goldReward:(int)goldReward
		itemReward:(Item*)itemReward
		  xpReward:(int)xpReward
		  dropRate:(float)dropRate
	   maxProgress:(int)maxProgress
		questStart:(CGPoint)questStart
	 questLocation:(CGPoint)questLocation
		  creature:(NSString*)creatureName
		 questItem:(Item*)questItem
		   andType:(int)type;

-(void) incrementProgress;
-(BOOL) isQuestComplete;

// class method to generate a quest
+(Quest*) generateQuestWithLevel:(int)level withLocation:(NSString*)location atStart:(CGPoint)startPoint andEnd:(CGPoint)endPoint withCreature:(NSString*)creatureName withQuestType:(int)questType questItem:(Item*)questItem andItemReward:(Item*)reward;

@end
