//
//  Nameplate.m
//  LazyQuest
//
//  Created by u0565496 on 4/17/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "Nameplate.h"
@interface Nameplate()
@end

@implementation Nameplate

-(id) initWithFrame:(CGRect)frame andHidden:(BOOL)hidden
{
	self = [super initWithFrame:frame];
	if (self == nil)
		return nil;
	
	[self setOpaque:FALSE];
	_name = @"Hurr";
	_className = @"Monster";
	_level = 1;
	_backgroundImage = [[UIImage imageNamed:@"nameplate"] retain];
	_hidden = hidden;
	
	return self;
	
}

@synthesize name = _name;
@synthesize className = _className;
@synthesize level = _level;
@synthesize hidden = _hidden;
@synthesize backgroundImage = _backgroundImage;

-(void) dealloc
{
	[_backgroundImage release];
	[_name release];
	[_className release];
	[super dealloc];
}

-(void) drawRect:(CGRect)rect
{
	if (_hidden == TRUE)
	{
		return;	
	}
	CGContextRef context = UIGraphicsGetCurrentContext();
	//CGContextClearRect(context, [self bounds]);
	[_backgroundImage drawInRect:rect];
	
	// set colors for drawing
	CGContextSetStrokeColorWithColor(context, [[UIColor blackColor] CGColor]);
	CGContextSetFillColorWithColor(context, [[UIColor blackColor] CGColor]);
	
	//int w = rect.size.width;
	int h = rect.size.height;
	char* textName = [_name UTF8String];
	NSString* classNameAndLevel = [NSString stringWithFormat:@"Level %i %@", _level, _className];
	char* textClass = [classNameAndLevel UTF8String];
    CGContextSelectFont(context, "Courier New", 10, kCGEncodingMacRoman);
    CGContextSetTextDrawingMode(context, kCGTextFill);
    CGContextSetRGBFillColor(context, 0, 0, 0, 1);
	
    CGAffineTransform xform = CGAffineTransformMake(
													1.0,  0.0,
													0.0, -1.0,
													0.0,  0.0);
    CGContextSetTextMatrix(context, xform);
	
    CGContextShowTextAtPoint(context, rect.size.width/2-3*strlen(textName), 2*h/5, textName, strlen(textName));
	CGContextShowTextAtPoint(context, rect.size.width/2-3*strlen(textClass), 4*h/5,textClass, strlen(textClass));
	
}

@end
