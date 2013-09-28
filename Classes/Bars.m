//
//  Bars.m
//  LazyQuest
//
//  Created by u0565496 on 4/15/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "Bars.h"

@interface Bars()
@end

@implementation Bars

-(id) initWithFrame:(CGRect)frame andBackgroundImage:(NSString*)image andHidden:(BOOL)hidden
{
	self = [super initWithFrame:frame];
	if (self == nil)
		return nil;
	
	[self setOpaque:FALSE];
	_backgroundImage = [[UIImage imageNamed:image] retain];
	_percentage = 0.99f;
	_vertOffset = 0.32f;
	_horizOffset = 0.15f;
	_xPixOffset = -2*200/frame.size.width;
	_yPixOffset = 1*50/frame.size.height;
	_hidden = hidden;
	_text = @"";
	
	
	return self;
}

@synthesize text = _text;
@synthesize hidden = _hidden;
@synthesize percentage = _percentage;

-(void) dealloc
{
	[_backgroundImage release];
	[super dealloc];
}

-(void) drawRect:(CGRect)rect
{
	
	if(_percentage<0)
		_percentage = 0;
	if (_percentage>1) 
	{
		_percentage = 1;
	}
	
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
	
	

	//[_text drawInRect:rect withFont:[UIFont fontWithName:@"Helvetica" size:200]];
	/*
	double w = r.size.width;
	double h = r.size.width;
	CGContextAddRect(context, r);
	CGContextMoveToPoint(context, w*_percentage-r.origin.x, 0+r.origin.y);
	CGContextAddLineToPoint(context, w-r.origin.x, 0);
	CGContextAddLineToPoint(context, w-r.origin.x, h);
	CGContextAddLineToPoint(context, w*_percentage-r.origin.x, h);
	*/
	
	
	double w = rect.size.width;
	w = w - (2*(_horizOffset*w));
	double h = rect.size.height;
	
	
	if (_percentage<1)
	{
		CGContextMoveToPoint(context, _percentage*(w+(w*_horizOffset)) + (w*_horizOffset) + _xPixOffset, _vertOffset*h-_yPixOffset);	//top left
		CGContextAddLineToPoint(context, w+(2*w*_horizOffset)+_xPixOffset, _vertOffset*h-_yPixOffset);									//top right
		CGContextAddLineToPoint(context, w+(2*w*_horizOffset)+_xPixOffset, h-(h*_vertOffset)-_yPixOffset);								//bottom right
		CGContextAddLineToPoint(context, _percentage*(w+(w*_horizOffset)) + (w*_horizOffset) + _xPixOffset, h-(h*_vertOffset)-_yPixOffset);	//bottom left
			CGContextClosePath(context);
			CGContextDrawPath(context, kCGPathFillStroke);
	}
	
	
	//char* text = "TrailsintheSand.com";
	//char* text = [NSString stringWitH
	//const char* text = [_text cStringUsingEncoding:ASCIIEncoding]; 

	
	//ContextShowTextAtPoint(context, w/2.0f, h/2.0f, _text, 20); 
	 


	
	char* text = [_text UTF8String];
    CGContextSelectFont(context, "Helvetica", 12, kCGEncodingMacRoman);
    CGContextSetTextDrawingMode(context, kCGTextFill);
    CGContextSetRGBFillColor(context, 255, 255,255, 1);
	
    CGAffineTransform xform = CGAffineTransformMake(
													1.0,  0.0,
													0.0, -1.0,
													0.0,  0.0);
    CGContextSetTextMatrix(context, xform);

	CGContextShowTextAtPoint(context, rect.size.width/2-3*strlen(text), (3*h/5), text, strlen(text));;
	
	
	
	

	
}


@end
