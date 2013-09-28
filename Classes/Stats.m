//
//  Stats.m
//  LazyQuest
//
//  Created by u0565496 on 4/21/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "Stats.h"


@implementation Stats

-(id) initWithFrame:(CGRect)frame
{
	self = [super initWithFrame:frame];
	if (self == nil)
		return nil;
		
	_backgroundImage = [[UIImage imageNamed:@"statspane"] retain]; // temporary image
	_strength = 0;
	_agility = 0;
	_intellect = 0;
	_endurance = 0;
	_armor = 0;
	_gold = 0;
		
	return self;
		
		
}
@synthesize backgroundImage = _backgroundImage;
@synthesize strength = _strength;
@synthesize agility = _agility;
@synthesize intellect = _intellect;
@synthesize endurance = _endurance;
@synthesize armor = _armor;
@synthesize gold = _gold;

-(void) dealloc
{
	[_backgroundImage release];
	[super dealloc];
	
}

-(void) drawRect:(CGRect)rect
{
	CGContextRef context = UIGraphicsGetCurrentContext();
	[_backgroundImage drawInRect:rect];
	int h = rect.size.height;
	int w = rect.size.width;

	
	char* strengthText = [[NSString stringWithFormat:@"%i", _strength] UTF8String];
	char* agilityText = [[NSString stringWithFormat:@"%i", _agility] UTF8String];
	char* intellectText = [[NSString stringWithFormat:@"%i", _intellect] UTF8String];
	char* enduranceText = [[NSString stringWithFormat:@"%i", _endurance] UTF8String];
	char* armorText = [[NSString stringWithFormat:@"%i", _armor] UTF8String];
	char* goldText = [[NSString stringWithFormat:@"%i", _gold] UTF8String];
	
	
	
	CGContextSelectFont(context, "Helvetica", 12, kCGEncodingMacRoman);
	CGContextSetTextDrawingMode(context, kCGTextFill);
	CGContextSetRGBFillColor(context, 255, 255, 255, 1);
	CGAffineTransform xform = CGAffineTransformMake(
													1.0,  0.0,
													0.0, -1.0,
													0.0,  0.0);
    CGContextSetTextMatrix(context, xform);
	
	int xOffset = 110;
	int yOffset = 38;
	int yScale = h*8.12/60;
	float charwidth = 9.3;
	
    CGContextShowTextAtPoint(context, xOffset+3*strlen(strengthText) - (charwidth*strlen(strengthText)), yOffset+(yScale*0), strengthText, strlen(strengthText));
    CGContextShowTextAtPoint(context, xOffset+3*strlen(agilityText) - (charwidth*strlen(agilityText)), yOffset+(yScale*1), agilityText, strlen(agilityText));
	CGContextShowTextAtPoint(context, xOffset+3*strlen(intellectText) - (charwidth*strlen(intellectText)), yOffset+(yScale*2), intellectText, strlen(intellectText));
	CGContextShowTextAtPoint(context, xOffset+3*strlen(enduranceText) - (charwidth*strlen(enduranceText)), yOffset+(yScale*3), enduranceText, strlen(enduranceText));
	CGContextShowTextAtPoint(context, xOffset+3*strlen(armorText) - (charwidth*strlen(armorText)), yOffset+(yScale*4), armorText, strlen(armorText));
	CGContextShowTextAtPoint(context, xOffset+3*strlen(goldText) - (charwidth*strlen(goldText)), yOffset+(yScale*5), goldText, strlen(goldText));
	
	
}

@end
