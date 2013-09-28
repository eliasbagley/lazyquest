//
//  LightUpAppDelegate.h
//  LightUp
//
//  Created by Matt on 1/12/11.
//  Copyright __MyCompanyName__ 2011. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Character.h"
#import "Item.h"
#import "World.h"
#import "GameScreen.h"
#import "GameController.h"
#import "NewCharacterController.h"
#import "TitleScreenController.h"

@class GameController;

@interface LazyQuestAppDelegate : NSObject <UIApplicationDelegate, CharacterDelegate> 
{
    UIWindow* _window;
	Character* _hero;
	
	//test variables
	NSString* name;
	NSString* className;
	UITextView* label;
	UINavigationController* _navController;
	GameController* _gameController;
	NewCharacterController* _mainMenuController;
	TitleScreenController* _titleScreenController;
	World* _world;
	Quest* _quest;
	NSUserDefaults* _prefs;
	NSMutableDictionary* _characterStateDictionary;
}

@end

