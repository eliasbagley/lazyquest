//
//  MainMenuController.h
//  LazyQuest
//
//  Created by u0565496 on 4/19/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NewCharacter.h"
#import "Character.h"
#import "World.h"

@interface NewCharacterController : UIViewController <UINavigationControllerDelegate, NewCharacterScreenDelegate>
{
	Character* _character;
	World* _world;
}
@property(nonatomic, retain) Character* character;
@property(nonatomic, retain) World* world;

-(id) initWithCharacter:(Character*)character andWorld:(World*)world;
-(void) updateUI;
-(void) startGameButtonPressed;
@end
