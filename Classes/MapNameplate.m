//
//  MapNameplate.m
//  LazyQuest
//
//  Created by u0565496 on 4/20/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "MapNameplate.h"

@interface MapNameplate()
@end

@implementation MapNameplate

-(id) initWithFrame:(CGRect)frame
{
	self = [super initWithFrame:frame];
	if (self == nil)
		return nil;
	_mapNameplate = [[UIImage imageNamed:@"mapnameplate"] retain];
	_text = @"Town";
	
	return self;
}

@synthesize text = _text;


-(void) dealloc
{
	[_mapNameplate release];
	[super dealloc];
}

-(void) drawRect:(CGRect)rect
{
	CGContextRef context = UIGraphicsGetCurrentContext();
	// set colors for drawing
	[_mapNameplate drawInRect:rect];
	double h = rect.size.height;
	char* text = [_text UTF8String];
    CGContextSelectFont(context, "Helvetica", 12, kCGEncodingMacRoman);
    CGContextSetTextDrawingMode(context, kCGTextFill);
    CGContextSetRGBFillColor(context, 255, 255, 255, 1);
	
    CGAffineTransform xform = CGAffineTransformMake(
													1.0,  0.0,
													0.0, -1.0,
													0.0,  0.0);
    CGContextSetTextMatrix(context, xform);
	
    CGContextShowTextAtPoint(context, rect.size.width/2-3*strlen(text), 7*h/10, text, strlen(text));
	
}
					 
				


@end
