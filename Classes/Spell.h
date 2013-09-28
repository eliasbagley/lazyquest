//
//  Spell.h
//  LazyQuest
//
//  Created by u0565496 on 4/9/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface Spell : NSObject 
{
	NSString* _spellName;
	int _manaCost;
	int _addedDamage;
	int _rank;
	int _price;
}

@property(nonatomic, retain) NSString* spellName;
@property(nonatomic, assign) int manaCost;
@property(nonatomic, assign) int addedDamage;
@property(nonatomic, assign) int rank;
@property(nonatomic, assign) int price;

-(id) initWithName:(NSString*)spellName
		  manaCost:(int)manaCost
	   addedDamage:(int) addedDamage;

-(void) incrementRank;
-(NSString*) description;
-(NSString*) descriptionPrint;
@end
