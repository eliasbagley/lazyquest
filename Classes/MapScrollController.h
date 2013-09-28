//
//  MapScrollController.h
//  LazyQuest
//
//  Created by u0565496 on 4/20/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ScrollableMap.h"


@interface MapScrollController : UIViewController <ScrollableMapDelegate>
{
	UIScrollView* _mapScrollView;
}


-(void) updateUI;
@end
