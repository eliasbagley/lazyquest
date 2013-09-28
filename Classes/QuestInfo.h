//
//  QuestInfo.h
//  LazyQuest
//
//  Created by u0565496 on 4/24/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface QuestInfo : UIView 
{
	UIImage* _backgroundImage;
	NSString* _text;
	float _progress;
	
	int _xLeftOffset;
	int _xRightOffset;
	int _yTopOffset;
	int _yBotOffset;
}

@property(nonatomic, retain) UIImage* backgroundImage;
@property(nonatomic, retain) NSString* text;
@property(nonatomic, assign) float progress;

@end
