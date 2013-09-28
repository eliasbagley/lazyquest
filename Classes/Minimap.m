//
//  Minimap.m
//  LazyQuest
//
//  Created by u0565496 on 4/16/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "Minimap.h"

@interface Minimap()
@end

@implementation Minimap

-(id) initWithFrame:(CGRect)frame
{
	self = [super initWithFrame:frame];
	if (self == nil)
		return nil;
	
	[self setOpaque:FALSE];
	_image = [[UIImage imageNamed:@"map"] retain];
	_imageBorder = [[UIImage imageNamed:@"minimapborder"] retain];
	_mapCG = _image.CGImage;
	_characterLocation = CGPointMake(13, 14);
	return self;
}
-(void) dealloc
{
	[_image release];
	[_imageBorder release];
	[super dealloc];
}

@synthesize characterLocation = _characterLocation;
@synthesize image = _image;

-(void) drawRect:(CGRect)rect
{
	
	CGContextRef context = UIGraphicsGetCurrentContext();
	// Create a new path
    CGMutablePathRef path = CGPathCreateMutable();

	int minimapWidth = 250;
	int minimapHeight = 250;
	//CGImageRef mapCG = _image.CGImage;
	
	int x = (55.3*_characterLocation.x+35.2)+28;
	int y =(48.5f*_characterLocation.y + 47.4)+19;
	int derp = _characterLocation.y;
	if (derp%2 == 1) // if even
	{
		x+=32;
	}
	
	CGRect re = CGRectInset([self bounds], 2.0f, 2.0f); // rect to elimiate 1 pixel transparency issue
    CGContextSetStrokeColorWithColor(context, [[UIColor redColor] CGColor]);
    CGContextSetFillColorWithColor(context, [[UIColor redColor] CGColor]);
	CGRect r = CGRectInset([self bounds], 61.0f, 61.0f);
	
	
    CGImageRef minimapCG = CGImageCreateWithImageInRect(_mapCG, CGRectMake(x-minimapWidth/2, y-minimapHeight/2, minimapWidth, minimapHeight));
	UIImage* minimap = [UIImage imageWithCGImage:minimapCG];

    CGPathAddEllipseInRect(path, NULL, re);

	
    CGContextAddPath(context, path);
   //  Clip to the circle and draw the image
    CGContextClip(context);
    [minimap drawInRect:rect];
	[_imageBorder drawInRect:rect];
	CGContextAddRect(context, r);
	CGContextDrawPath(context, kCGPathFillStroke);
	
	CFRelease(path);

	
	
}

@end
