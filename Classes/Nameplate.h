//
//  Nameplate.h
//  LazyQuest
//
//  Created by u0565496 on 4/17/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface Nameplate : UIView 
{
	NSString* _name;
	NSString* _className;
	int _level;
	UIImage* _backgroundImage;
	BOOL _hidden;
}

-(id) initWithFrame:(CGRect)frame andHidden:(BOOL)hidden;

@property(nonatomic, retain) NSString* name;
@property(nonatomic, retain) NSString* className;
@property(nonatomic, assign) int level;
@property(nonatomic, retain) UIImage* backgroundImage;
@property(nonatomic, assign) BOOL hidden;

@end
