//
//  InventoryView.h
//  LazyQuest
//
//  Created by u0565496 on 4/21/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
@class InventoryView;
@protocol InventoryViewProtocol
-(void) backButtonPressed;
@end

@interface InventoryView : UIView 
{
	NSObject<InventoryViewProtocol>* _delegate;
	UIButton* _backButton;
	UIImage* _backgroundImage;
	UITextView* _inventoryTextView;
	UITextView* _gearTextView;
	UITextView* _spellsTextView;
	
}

@property(nonatomic, assign) NSObject<InventoryViewProtocol>* delegate;
@property(nonatomic, retain) UIButton* backButton;
@property(nonatomic, retain) UITextView* inventoryTextView;
@property(nonatomic, retain) UITextView* gearTextView;
@property(nonatomic, retain) UITextView* spellsTextView;
@property(nonatomic, retain) UIImage* backgroundImage;

-(void) backButtonPressed;

@end
