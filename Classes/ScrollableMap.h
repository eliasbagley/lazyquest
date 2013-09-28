//
//  ScrollableMap.h
//  LazyQuest
//
//  Created by u0565496 on 4/20/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ScrollableMap;

@protocol ScrollableMapDelegate
-(void) backButtonPressed;
@end

@interface ScrollableMap : UIView 
{
	NSObject<ScrollableMapDelegate>* _delegate;
	UIImage* _map;
	UIButton* _backButton;
}

@property(nonatomic, assign) NSObject<ScrollableMapDelegate>* delegate;
@property(nonatomic, retain) UIImage* map;

-(void) buttonPressed;
-(void) updateUI;

@end
