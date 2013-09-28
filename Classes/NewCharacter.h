//
//  MainMenu.h
//  LazyQuest
//
//  Created by u0565496 on 4/19/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@class NewCharacter;

@protocol NewCharacterScreenDelegate
-(void) startGameButtonPressed;
-(void) backButtonPressed;
@end

@interface NewCharacter : UIView <UITextViewDelegate>
{
	UIImage* _backgroundImage;
	UIImage* _redSlider;
	UIImage* _blueSlider;
	
	UIButton* _startButton;
	UIButton* _backButton;
	UISlider* _strengthSlider;
	UISlider* _agilitySlider;
	UISlider* _intellectSlider;
	UISlider* _enduranceSlider;
	UITextField* _name;
	UITextField* _className;
	NSObject<NewCharacterScreenDelegate>* _delegate;
	
	float _statBudget;
	float _strengthSliderPrevious;
	float _agilitySliderPrevious;
	float _intellectSliderPrevious;
	float _enduranceSliderPrevious;
}

@property(nonatomic, assign) NSObject<NewCharacterScreenDelegate>* delegate;
@property(nonatomic, retain) UITextField* className;
@property(nonatomic, retain) UITextField* name;
@property(nonatomic, retain) UIButton* startButton;
@property(nonatomic, retain) UIButton* backButton;
@property(nonatomic, retain) UISlider* strengthSlider;
@property(nonatomic, retain) UISlider* agilitySlider;
@property(nonatomic, retain) UISlider* intellectSlider;
@property(nonatomic, retain) UISlider* enduranceSlider;

-(void) startButtonPressed;
-(void) backButtonPressed;

@end
