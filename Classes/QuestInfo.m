//
//  QuestInfo.m
//  LazyQuest
//
//  Created by u0565496 on 4/24/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "QuestInfo.h"


@implementation QuestInfo

-(id) initWithFrame:(CGRect) frame
{
	self = [super initWithFrame:frame];
	if (self == nil)
		return nil;
	
	_backgroundImage = [[UIImage imageNamed:@"questinfo"] retain];
	_text = @"";
	_progress = 0;
	
	_xLeftOffset = 3;
	_xRightOffset = 4;
	_yTopOffset = 27;
	_yBotOffset = 4;
	
	return self;
}

-(void) dealloc
{
	[_backgroundImage release];
	[_text release];
	[super dealloc];
}

@synthesize text = _text;
@synthesize progress = _progress;
@synthesize backgroundImage = _backgroundImage;

-(void) drawRect:(CGRect)rect
{
	[_backgroundImage drawInRect:rect];
	
	// animate bar later
	if(_progress<0)
		_progress = 0;
	if (_progress>1) 
	{
		_progress = 1;
	}
	
	CGContextRef context = UIGraphicsGetCurrentContext();
	// set colors
	CGContextSetStrokeColorWithColor(context, [[UIColor blackColor] CGColor]);
	CGContextSetFillColorWithColor(context, [[UIColor blackColor] CGColor]);
	
	double w = rect.size.width - (_xLeftOffset + _xRightOffset);
	double h = rect.size.height;
	if (_progress<1)
	{
		CGContextMoveToPoint(context, (_progress*w)+_xLeftOffset+1, _yTopOffset);			//top left
		CGContextAddLineToPoint(context, rect.size.width-_xRightOffset, _yTopOffset);		//top right
		CGContextAddLineToPoint(context, rect.size.width-_xRightOffset, h-_yBotOffset);		//bottom right
		CGContextAddLineToPoint(context,  (_progress*w)+_xLeftOffset+1, h-_yBotOffset);		//bottom left
		CGContextClosePath(context);
		CGContextDrawPath(context, kCGPathFillStroke);
	}
	

	
	char* text = [_text UTF8String];
    CGContextSelectFont(context, "Helvetica", 12, kCGEncodingMacRoman);
    CGContextSetTextDrawingMode(context, kCGTextFill);
    CGContextSetRGBFillColor(context, 255, 255, 255, 1);
	
    CGAffineTransform xform = CGAffineTransformMake(
													1.0,  0.0,
													0.0, -1.0,
													0.0,  0.0);
    CGContextSetTextMatrix(context, xform);
	
    CGContextShowTextAtPoint(context, rect.size.width/2-3*strlen(text), 5*h/10, text, strlen(text));
	
	
}

@end
