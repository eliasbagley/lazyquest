//
//  CombatLog.m
//  LazyQuest
//
//  Created by u0565496 on 4/24/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "CombatLog.h"


@implementation CombatLog

-(id) initWithFrame:(CGRect)frame
{
	self = [super initWithFrame:frame];
	if (self == nil)
		return nil;
	
	_strings = [[NSMutableArray alloc] init];
	_backgroundImage = [[UIImage imageNamed:@"combatlog"] retain];
	CGRect r = CGRectInset(frame, 3, 3);
	_combatLog = [[UITextView alloc] initWithFrame:CGRectMake(3, 3, r.size.width, r.size.height)];
	[_combatLog setBackgroundColor:[UIColor clearColor]];
	_combatLog.editable = NO;
	[_combatLog setTextColor:[UIColor whiteColor]];
	
	
	[self addSubview:_combatLog];
	
	return self;
		
}
-(void) dealloc
{
	[_backgroundImage release];
	[_combatLog release];
	[super dealloc];
}

-(void) drawRect:(CGRect)rect
{
	[_backgroundImage drawInRect:rect];
}

@synthesize combatLog = _combatLog;

-(void) pushText:(NSString*)text
{
	if ([_strings count] > 100)
	{
		[_strings removeObjectAtIndex:0];
	}
	[_strings addObject:text];
	
	NSString* combatText = @"";
	for (NSString* string in _strings)
	{
		combatText = [combatText stringByAppendingFormat:@"%@\n", string];
	}
	_combatLog.text = combatText;
	[_combatLog scrollRangeToVisible:NSMakeRange(_combatLog.text.length-10, 3)];

}

@end
