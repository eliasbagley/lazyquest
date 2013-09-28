//
//  MapNameplate.h
//  LazyQuest
//
//  Created by u0565496 on 4/20/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface MapNameplate : UIView 
{
	NSString* _text;
	UIImage* _mapNameplate;
}

@property(nonatomic, retain) NSString* text;

@end
