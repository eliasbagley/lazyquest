//
//  Controller.h
//  LazyQuest
//
//  Created by u0565496 on 4/12/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

// TODO: sort inventory and spells, bold fonts, buying spells, random item mob drops, unique item drops/rewards based on rarities, saving char to file

#import <Foundation/Foundation.h>
#import "Character.h"
#import "World.h"
#import "GameScreen.h"
#import "Creature.h"
#import "Item.h"
#import "Nameplate.h"
#import "InventoryController.h"
#import "MapScrollController.h"

#define WIDTH 27
#define HEIGHT 24

@class Character;
@class World;
@class Item;
@class LazyQuestAppDelegate;

@interface GameController : UIViewController <GameScreenDelegate, UINavigationControllerDelegate>
{
	Character* _character;
	World* _world;
	float _timeInterval;
	NSMutableArray* _items;
	NSMutableArray* _spells;
}

@property(nonatomic, retain) NSMutableArray* spells;
@property(nonatomic, retain) NSMutableArray* items;
@property(nonatomic, readonly) float timeInterval;
@property(nonatomic, retain) Character* character;
@property(nonatomic, retain) World* world;

-(id) initWithCharacter:(Character*)character andWorld:(World*)world;
-(void) updateUI;
-(void) gameLoop;
-(void) doAction;
-(void) doCombatIteration;
-(void) doOutOfCombatIteration;
-(BOOL) compareLocations:(CGPoint)loc1 loc2:(CGPoint)loc2;
-(BOOL) animateActionBar;
-(void) animateBars; // other than action
-(void) populateVendorInventory;
-(void) populateVendorSpellInventory;
- (IBAction)toggleNavigationBar:(id)sender;
-(void) displayInventory;
@end
