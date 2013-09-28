//
//  TitleScreenController.h
//  LazyQuest
//
//  Created by u0565496 on 4/22/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LoadGame.h"
#import "GameController.h"
#import "Character.h"
#import "World.h"


@interface LoadGameController : UIViewController <LoadGameDelegate, UINavigationControllerDelegate>
{
	Character* _character;
	World* _world;
}

-(id) initWithCharacter:(Character*)character andWorld:(World*)world;

@property(nonatomic, retain) Character* character;
@property(nonatomic, retain) World* world;

-(void) updateUI;
@end
