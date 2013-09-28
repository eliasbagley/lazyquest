//
//  Stats.h
//  LazyQuest
//
//  Created by u0565496 on 4/21/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface Stats : UIView 
{
	UIImage* _backgroundImage;
	int _strength;
	int _agility;
	int _intellect;
	int _endurance;
	int _armor;
	int _gold;
}

@property(nonatomic, retain) UIImage* backgroundImage;
@property(nonatomic, assign) int strength;
@property(nonatomic, assign) int agility;
@property(nonatomic, assign) int intellect;
@property(nonatomic, assign) int endurance;
@property(nonatomic, assign) int armor;
@property(nonatomic, assign) int gold;


@end