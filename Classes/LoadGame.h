//
//  LoadGame.h
//  LazyQuest
//
//  Created by u0565496 on 4/25/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@class LoadGame;

@protocol LoadGameDelegate
-(void) slotUsed:(int)slot;
-(void) backButtonPressed;
@end

@interface LoadGame : UIView 
{
	NSObject<LoadGameDelegate>* _delegate;
	UIButton* _saveSlot1;
	UIButton* _saveSlot2;
	UIButton* _backButton;
	UIImage* _backgroundImage;
	
}

@property(nonatomic, assign) NSObject<LoadGameDelegate>* delegate;
@property(nonatomic, retain) UIButton* saveSlot1;
@property(nonatomic, retain) UIButton* saveSlot2;
@property(nonatomic, retain) UIButton* backButton;

@end
