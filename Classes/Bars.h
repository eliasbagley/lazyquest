//
//  Bars.h
//  LazyQuest
//
//  Created by u0565496 on 4/15/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface Bars : UIView 
{
	UIImage* _backgroundImage;
	float _percentage;
	float _vertOffset;
	float _horizOffset;
	int _xPixOffset;
	int _yPixOffset;
	BOOL _hidden;
	NSString* _text;
}

@property (nonatomic, retain) NSString* text;
@property (nonatomic, assign) BOOL hidden;
@property (nonatomic, assign) float percentage;

-(id) initWithFrame:(CGRect)frame andBackgroundImage:(NSString*)image andHidden:(BOOL)hidden;
@end
