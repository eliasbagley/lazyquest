//
//  GameScreen.m
//  LazyQuest
//
//  Created by u0565496 on 4/12/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "GameScreen.h"
#import "TitleScreen.h"

@interface GameScreen()
@end

@implementation GameScreen


-(id)initWithFrame:(CGRect)frame
{
	self = [super initWithFrame:frame];
	if (self == nil)
		return nil;
	
	[self setBackgroundColor:[UIColor greenColor]];
	_backgroundImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 480)];
	[self setBackgroundImageFromString:@"background-town-new"]; // character starts in town
	//_backgroundImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"background-town"]];
	[self addSubview:_backgroundImage];

	//_backgroundImage = [[UIImage imageNamed:@"background-town"] retain];
	_bars = [[NSMutableArray alloc] init];
	Bars* ourHealth = [[[Bars alloc] initWithFrame:CGRectMake(0, 30, 150, 40) andBackgroundImage:@"healthbar.png" andHidden:FALSE] autorelease];
	Bars* ourMana = [[[Bars alloc] initWithFrame:CGRectMake(0, 70, 150, 40) andBackgroundImage:@"manabar.png" andHidden:FALSE] autorelease];
	Bars* ourAction = [[[Bars alloc] initWithFrame:CGRectMake(15, 320, 290, 40) andBackgroundImage:@"actionbar.png" andHidden:TRUE] autorelease];
	Bars* ourXP = [[[Bars alloc] initWithFrame:CGRectMake(-20, 428, 360 , 40) andBackgroundImage:@"xpbar.png" andHidden:FALSE] autorelease];
	Bars* enemyHealth = [[[Bars alloc] initWithFrame:CGRectMake(170, 30, 150, 40) andBackgroundImage:@"healthbar.png" andHidden:TRUE] autorelease];
	Bars* enemyMana = [[[Bars alloc] initWithFrame:CGRectMake(170, 70, 150, 40) andBackgroundImage:@"manabar.png" andHidden:TRUE] autorelease];
	Bars* enemyAction = [[[Bars alloc] initWithFrame:CGRectMake(170, 280, 150, 40) andBackgroundImage:@"actionbar.png" andHidden:TRUE] autorelease];
	_button = [[UIButton buttonWithType:UIButtonTypeRoundedRect] retain];
	[_button setFrame:CGRectMake(5, 110, 140, 20)];
	[_button setTitle:@"Character Info" forState:UIControlStateNormal];
	[_button addTarget:self action:@selector(characterInfoButtonPressed) forControlEvents:UIControlEventTouchUpInside];
	
	_mapNameplate = [[MapNameplate alloc] initWithFrame:CGRectMake(158, 220, 150, 25)];
	
	
	_stats = [[Stats alloc] initWithFrame:CGRectMake(15, 140, 120, 140)];
	
	[_bars addObject:ourHealth];
	[_bars addObject:ourMana];
	[_bars addObject:ourAction];
	[_bars addObject:ourXP];
	[_bars addObject:enemyHealth];
	[_bars addObject:enemyMana];
	[_bars addObject:enemyAction];
	
	_minimap = [[Minimap alloc] initWithFrame:CGRectMake(168, 110, 125, 125)];
	
	_ourNameplate = [[Nameplate alloc] initWithFrame:CGRectMake(0, 0, 150, 30) andHidden:FALSE];
	_enemyNameplate = [[Nameplate alloc] initWithFrame:CGRectMake(170, 0, 150, 30) andHidden:TRUE];

	
	_combatLog = [[CombatLog alloc] initWithFrame:CGRectMake(25, 360, 270, 70)];
	_questInfo = [[QuestInfo alloc] initWithFrame:CGRectMake(145, 245, 175, 35)]; // change the rect later
	
	[self addSubview:_enemyNameplate];
	for (Bars* b in _bars)
	{
		[self addSubview:b]; // b stands for ballin
	}
	
	[self addSubview:_minimap];
	[self addSubview:_ourNameplate];
	[self addSubview:_button];
	[self addSubview:_mapNameplate];
	[self addSubview:_stats];
	[self addSubview:_combatLog];
	[self addSubview:_questInfo];
	return self;
}

@synthesize questInfo = _questInfo;
@synthesize combatLog = _combatLog;
@synthesize stats = _stats;
@synthesize mapNameplate = _mapNameplate;
@synthesize backgroundImage = _backgroundImage;
@synthesize ourNameplate = _ourNameplate;
@synthesize enemyNameplate = _enemyNameplate;
@synthesize delegate = _delegate;
@synthesize button = _button;
-(void) dealloc
{
	// clean up after we take a sucker's money
	[_button release];
	[_bars release];
	[_minimap release];
	[_ourNameplate release];
	[_enemyNameplate release];
	[_backgroundImage release];
	[_mapNameplate release];
	[_stats release];
	[_combatLog release];
	[_questInfo release];
	[super dealloc];
}

-(void) setBackgroundImageFromString:(NSString*)imageName
{
	//NSLog(@"your current location: %@", imageName);
	UIImage* image = [[UIImage imageNamed:imageName] retain];
	[_backgroundImage setImage:image];
	[image release];	
}


-(void) setText:(NSString*)text atIndex:(int)index
{
	
}

-(void) setBarHidden:(BOOL)hidden atIndex:(int)index
{
	[[_bars objectAtIndex:index] setHidden:hidden];
	[[_bars objectAtIndex:index] setNeedsDisplay];
}
-(void) setEnemyNameplateHidden:(BOOL)hidden
{
	[_enemyNameplate setHidden:hidden];
	[_enemyNameplate setNeedsDisplay];
}

-(void) updateOurNameplateWithName:(NSString*)name className:(NSString*)className andLevel:(int)level
{
	[_ourNameplate setName:name];
	[_ourNameplate setClassName:className];
	[_ourNameplate setLevel:level];
	[_ourNameplate setNeedsDisplay];
}

-(void) updateEnemyNameplateWithName:(NSString*)name andLevel:(int)level
{
	[_enemyNameplate setName:name];
	[_enemyNameplate setLevel:level];
	[_enemyNameplate setNeedsDisplay];
}

-(void) animateBarWithProgress:(float)progress andString:(NSString*)string atIndex:(int)index
{

	[self setBarHidden:FALSE atIndex:index];
	[[_bars objectAtIndex:index] setText:string];
	[[_bars objectAtIndex:index] setPercentage:progress];
	[[_bars objectAtIndex:index] setNeedsDisplay];
	
	
}
-(void) setCharacterLocation:(CGPoint)location
{
	[_minimap setCharacterLocation:location];
	[_minimap setNeedsDisplay];
}

// called when the character info button is pressed
-(void) characterInfoButtonPressed
{
	[_delegate infoButtonPressed];
}

-(void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{

	CGPoint touchPoint = [[touches anyObject] locationInView:self];
	if (CGRectContainsPoint([_minimap frame], touchPoint))
	{
		// touched the map
		[_delegate mapTouched];
	}
}

-(void) setCharacterLocationString:(NSString*)location
{
	[_mapNameplate setText:location];
	[_mapNameplate setNeedsDisplay];
}
-(void) setStatsStrength:(int)strength Agility:(int)agility Intellect:(int)intellect Endurance:(int)endurance Armor:(int)armor andGold:(int)gold
{
	[_stats setStrength:strength];
	[_stats setAgility:agility];
	[_stats setIntellect:intellect];
	[_stats setEndurance:endurance];
	[_stats setArmor:armor];
	[_stats setGold:gold];
	[_stats setNeedsDisplay];
	
}

-(void) addTextToCombatLog:(NSString*)text
{
	[_combatLog pushText:text];
	[_combatLog setNeedsDisplay];
}
-(void) animateQuestBarWithString:(NSString*)string andProgress:(float)progress
{
		// todo
	[_questInfo setProgress:progress];
	[_questInfo setText:string];
	[_questInfo setNeedsDisplay];
}

@end
