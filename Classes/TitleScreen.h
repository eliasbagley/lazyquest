//
//  Menu.h
//  LazyQuest
//
//  Created by u0565496 on 4/9/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@class TitleScreen;

@protocol TitleScreenDelegate
-(void) newCharacterButtonPressed;
-(void) loadCharacterButtonPressed;
@end


@interface TitleScreen : UIView
{
	NSObject<TitleScreenDelegate>* _delegate;
	UIButton* _newCharacter;
	UIButton* _loadCharacter;
	UIImage* _backgroundImage;
}

@property(nonatomic, assign) NSObject<TitleScreenDelegate>* delegate;
@property(nonatomic, retain) UIImage* backgroundImage;
@property(nonatomic, retain) UIButton* newCharacter;
@property(nonatomic, retain) UIButton* loadCharacter;

-(void) newCharacterPressed;
-(void) loadCharacterPressed;

@end
