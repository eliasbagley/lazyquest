//
//  Minimap.h
//  LazyQuest
//
//  Created by u0565496 on 4/16/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface Minimap : UIView 
{

	UIImage* _image;
	UIImage* _imageBorder;
	CGImageRef _mapCG;
	CGPoint _characterLocation;
}

@property(nonatomic, assign) CGPoint characterLocation;
@property(nonatomic, retain) UIImage* image;

@end
