//
//  CombatLog.h
//  LazyQuest
//
//  Created by u0565496 on 4/24/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface CombatLog : UIView
{
	UITextView* _combatLog;
	UIImage* _backgroundImage;
	NSMutableArray* _strings;
}

@property(nonatomic, retain) UITextView* combatLog;

-(void) pushText:(NSString *)text;

@end
