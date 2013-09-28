//
//  InventoryController.h
//  LazyQuest
//
//  Created by u0565496 on 4/19/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Character.h"
#import "InventoryView.h"

@interface InventoryController : UIViewController<InventoryViewProtocol>
{
	Character* _character;
}

@property(nonatomic, retain) Character* character;
-(void) updateUI;

-(id) initWithCharacter:(Character*)character;

@end

