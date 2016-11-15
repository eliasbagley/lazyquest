// Author: Our Lord and Savior, Master Programmer Elias Bagley, and Peon Alex Doub. elias.bagley@gmail.com alexdoub1990@gmail.com
// Date:April 8, 2011
// Company: Deedlestein INC.
// Project: LazyQuest


#import "LazyQuestAppDelegate.h"

@interface LazyQuestAppDelegate ()
@end

#pragma mark -
@implementation LazyQuestAppDelegate

#pragma mark Constructors
- (void) applicationDidFinishLaunching:(UIApplication*)application 
{   
    //Create window
    _window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
	[_window setBackgroundColor:[UIColor blackColor]];
	
	_prefs = [NSUserDefaults standardUserDefaults];
	_characterStateDictionary = [[NSMutableDictionary alloc] init];
	
	_world = [[World alloc] initWithMap:@"map" andLegend:@"legend" andCreatures:@"creatures" andItems:@"items"];
	name= @"Empty";
	className = @"Janitor";
	_hero = [[Character alloc] initWithName:name strength:.9f agility:.3f intellect:.1f endurance:.7f className:className currentLocation:CGPointMake(13, 12)];
	//Item* headpiece = [[Item alloc] initWithName:@"Ass Ruiner" strength:99 agility:99 intellect:99 endurance:99 goldValue:99 slot:HEAD rarity:EPIC];
	//Quest* quest1 = [[Quest alloc] initWithName:@"Kill 10 dragons" goldReward:5000 itemReward:headpiece xpReward:500 dropRate:1 maxProgress:10 questStart:CGPointMake(50, 50) questLocation:CGPointMake(50, 50) creature:@"Minor Dragon" andType:1];
	//Spell* spell1 = [[Spell alloc] initWithName:@"Inferno" manaCost:10 addedDamage:6];
	//Spell* spell2 = [[Spell alloc] initWithName:@"Molten Hands" manaCost:5 addedDamage:13];


	//[_hero addSpell:spell1];
	//[_hero addSpell:spell2];
	
	[_hero setDelegate:self];
	_gameController = [[GameController alloc] initWithCharacter:_hero andWorld:_world];
	_mainMenuController = [[NewCharacterController alloc] initWithCharacter:_hero andWorld:_world];
	_titleScreenController = [[TitleScreenController alloc] initWithCharacter:_hero andWorld:_world];
	_navController = [[UINavigationController alloc] initWithRootViewController:_titleScreenController];

    _window.rootViewController = _navController;
	//[_window addSubview:[_navController view]];
	[_window makeKeyAndVisible];
	
}



- (void) applicationWillTerminate:(UIApplication*)application
{
	// save character stuff
	NSString* key = [NSString stringWithFormat:@"%i", [_hero saveGameSlot]];
	[_prefs setObject:_hero forKey:key];
	[_prefs synchronize];
	
    [_window release];
	[_hero release];
	[name release];
	[className release];
	[label release];
	[_navController release];
	[_gameController release];
	[_mainMenuController release];
	[_titleScreenController release];
	[_world release];
	[_quest release];
	[_prefs release];
	[_characterStateDictionary release];
	
}

-(void) characterChanged:(Character*)character
{
	//NSLog(@"character changed");
	[_navController.visibleViewController updateUI];
	
	[_characterStateDictionary setObject:[_hero name] forKey:@"name"];
	[_characterStateDictionary setObject:[_hero className] forKey:@"classname"];
	
	NSNumber* level = [[[NSNumber alloc] initWithInt:[_hero level]] autorelease];
	NSNumber* flag = [[[NSNumber alloc] initWithInt:[_hero introFlag]] autorelease];
	[_characterStateDictionary setObject:level forKey:@"level"];
	[_characterStateDictionary setObject:flag forKey:@"flag"];
	NSNumber* gold = [[[NSNumber alloc] initWithInt:[_hero gold]] autorelease];
	[_characterStateDictionary setObject:gold forKey:@"gold"];
	NSNumber* xpIntoLevel = [[[NSNumber alloc] initWithInt:[_hero xpIntoLevel]] autorelease];
	[_characterStateDictionary setObject:xpIntoLevel forKey:@"xpIntoLevel"];
	//NSNumber* xpToNextLevel = [[NSNumber alloc] initWithInt:[_hero xpToNextLevel]];
	//[_characterStateDictionary setObject:xpToNextLevel forKey:@"xpToNextLevel"];
	
	NSNumber* strcoefficient = [[[NSNumber alloc] initWithFloat:[_hero strengthCoefficient]] autorelease];
	[_characterStateDictionary setObject:strcoefficient forKey:@"strcoefficient"];
	NSNumber* agicoefficient = [[[NSNumber alloc] initWithFloat:[_hero agilityCoefficient]] autorelease];
	[_characterStateDictionary setObject:agicoefficient forKey:@"agicoefficient"];
	NSNumber* intcoefficient = [[[NSNumber alloc] initWithFloat:[_hero intellectCoefficient]] autorelease];
	[_characterStateDictionary setObject:intcoefficient forKey:@"intcoefficient"];
	NSNumber* endcoefficient = [[[NSNumber alloc] initWithFloat:[_hero enduranceCoefficient]] autorelease];
	[_characterStateDictionary setObject:endcoefficient forKey:@"endcoefficient"];
	
	NSNumber* saveSlot = [[[NSNumber alloc] initWithInt:[_hero saveGameSlot]] autorelease];
	[_characterStateDictionary setObject:saveSlot forKey:@"saveslot"];
	
	NSData* inventoryData = [NSKeyedArchiver archivedDataWithRootObject:[_hero inventory]];	
	NSData* gearData = [NSKeyedArchiver archivedDataWithRootObject:[_hero gear]];
	NSData* spellData = [NSKeyedArchiver archivedDataWithRootObject:[_hero spells]];
	[_characterStateDictionary setObject:inventoryData forKey:@"inventory"];
	[_characterStateDictionary setObject:gearData forKey:@"gear"];
	[_characterStateDictionary setObject:spellData forKey:@"spells"];
	
	
	
	
	
	NSString* key = [NSString stringWithFormat:@"%i", [_hero saveGameSlot]];

	[_prefs setObject:_characterStateDictionary forKey:key];
	[_prefs synchronize];
	

}
-(void) combatLogString:(NSString *)string
{
	NSArray* viewControllers = [_navController viewControllers];
	if ([viewControllers count] == 3) // load game
		[[viewControllers objectAtIndex:2] combatLogString:string];
	else { // new game
		[[viewControllers objectAtIndex:3] combatLogString:string];
	}

}


@end
