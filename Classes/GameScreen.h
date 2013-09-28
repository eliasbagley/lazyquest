//
//  GameScreen.h
//  LazyQuest
//
//  Created by u0565496 on 4/12/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Bars.h"
#import "Minimap.h"
#import "Nameplate.h"
#import "MapNameplate.h"
#import "Stats.h"
#import "CombatLog.h"
#import "QuestInfo.h"

@class GameScreen;

@protocol GameScreenDelegate
-(void) infoButtonPressed;
-(void) mapTouched;
@end

@interface GameScreen : UIView 
{
	NSObject<GameScreenDelegate>* _delegate;
	Minimap* _minimap;
	UIButton* _button;
	// order: player health, player mana, player action, player xp enemy health, enemymana, enemyaction
	NSMutableArray* _bars;
	// nameplates display name, class, and level
	Nameplate* _ourNameplate;
	Nameplate* _enemyNameplate;
	UIImageView* _backgroundImage;
	MapNameplate* _mapNameplate;
	Stats* _stats;
	CombatLog* _combatLog;
	QuestInfo* _questInfo;

	
}

@property(nonatomic, retain) QuestInfo* questInfo;
@property(nonatomic, retain) CombatLog* combatLog;
@property(nonatomic, retain) Stats* stats;
@property(nonatomic, retain) MapNameplate* mapNameplate;
@property(nonatomic, retain) UIImageView* backgroundImage;
@property(nonatomic, retain) UIButton* button;
@property(nonatomic, retain) Nameplate* ourNameplate;
@property(nonatomic, retain) Nameplate* enemyNameplate;
@property(nonatomic, assign) NSObject<GameScreenDelegate>* delegate;
-(void) setText:(NSString *)text;
-(void) animateBarWithProgress:(float)progress andString:(NSString*)string atIndex:(int)index;
-(void) setBarHidden:(BOOL)hidden atIndex:(int)index;
-(void) setEnemyNameplateHidden:(BOOL)hidden;
-(void) updateEnemyNameplateWithName:(NSString*)name andLevel:(int)level;
-(void) updateOurNameplateWithName:(NSString*)name className:(NSString*)className andLevel:(int)level;
-(void) setCharacterLocation:(CGPoint)location;
-(void) characterInfoButtonPressed;
-(void) setBackgroundImageFromString:(NSString*)imageName;
-(void) setCharacterLocationString:(NSString*)location;
-(void) setStatsStrength:(int)strength Agility:(int)agility Intellect:(int)intellect Endurance:(int)endurance Armor:(int)armor andGold:(int)gold;
-(void) addTextToCombatLog:(NSString*)text;
-(void) animateQuestBarWithString:(NSString*)string andProgress:(float)progress;
@end
