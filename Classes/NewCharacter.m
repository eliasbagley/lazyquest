//
//  MainMenu.m
//  LazyQuest
//
//  Created by u0565496 on 4/19/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "NewCharacter.h"
@interface NewCharacter()
@end

@implementation NewCharacter


-(id) initWithFrame:(CGRect)frame
{
	self = [super initWithFrame:frame];
	if (self == nil)
		return nil;
	
	_statBudget = 2.3f;
	
	_strengthSliderPrevious = .55f;
	_agilitySliderPrevious = .55f;
	_intellectSliderPrevious = .55f;
	_enduranceSliderPrevious = .55f;
	
	_redSlider = [[UIImage imageNamed:@"redslider"] retain];
	_blueSlider = [[UIImage imageNamed:@"blueslider"] retain];
	
	_backgroundImage = [[UIImage imageNamed:@"menu-newcharacter"] retain];
	_backButton = [[UIButton buttonWithType:UIButtonTypeRoundedRect] retain];
	[_backButton setFrame:CGRectMake(30, 413, 130, 35)];
	[_backButton setTitle:@"Back" forState:UIControlStateNormal];
	[_backButton addTarget:self action:@selector(backButtonPressed) forControlEvents:UIControlEventTouchUpInside];
	
	_startButton = [[UIButton buttonWithType:UIButtonTypeRoundedRect] retain];
	[_startButton setFrame:CGRectMake(160, 413, 130, 35)];
	[_startButton setTitle:@"Start Game" forState:UIControlStateNormal];
	[_startButton addTarget:self action:@selector(startButtonPressed) forControlEvents:UIControlEventTouchUpInside];
	
	_strengthSlider = [[UISlider alloc] initWithFrame:CGRectMake(55, 190, 200, 20)];
	_agilitySlider  = [[UISlider alloc] initWithFrame:CGRectMake(55, 245, 200, 20)];
	_intellectSlider  = [[UISlider alloc] initWithFrame:CGRectMake(55, 303, 200, 20)];
	_enduranceSlider  = [[UISlider alloc] initWithFrame:CGRectMake(55, 358, 200, 20)];
	_name = [[UITextField alloc] initWithFrame:CGRectMake(135, 51, 130, 30)];
	_className = [[UITextField alloc] initWithFrame:CGRectMake(135, 86, 130, 30)];

	
	_className.borderStyle = UITextBorderStyleRoundedRect;
	_className.textColor = [UIColor blackColor];
	_className.font = [UIFont systemFontOfSize:17.0];
	_className.placeholder = @"Wizard";
	_className.text = @"Wizard";
	_className.autocorrectionType = UITextAutocorrectionTypeNo;
	
	_className.keyboardType = UIKeyboardTypeDefault;
	_className.returnKeyType = UIReturnKeyDone;
	
	_className.clearButtonMode = UITextFieldViewModeWhileEditing;
	_className.delegate = self;
	
	_name.borderStyle = UITextBorderStyleRoundedRect;
	_name.textColor = [UIColor blackColor];
	_name.font = [UIFont systemFontOfSize:17.0];
	_name.placeholder = @"Johnson";
	_name.text = @"Johnson";
	_name.autocorrectionType = UITextAutocorrectionTypeNo;
	
	_name.keyboardType = UIKeyboardTypeDefault;
	_name.returnKeyType = UIReturnKeyDone;
	
	_name.clearButtonMode = UITextFieldViewModeWhileEditing;
	_name.delegate = self;
	
	
	[_strengthSlider setMinimumValue:.1f];
	[_strengthSlider setMaximumValue:1.0f];
	[_strengthSlider setValue:.55f];
	[_strengthSlider addTarget:self action:@selector(strengthSliderChanged) forControlEvents:UIControlEventValueChanged];

	[_agilitySlider setMinimumValue:.1f];
	[_agilitySlider setMaximumValue:1.0f];
	[_agilitySlider setValue:.55f];
	[_agilitySlider addTarget:self action:@selector(agilitySliderChanged) forControlEvents:UIControlEventValueChanged];
	
	[_intellectSlider setMinimumValue:.1f];
	[_intellectSlider setMaximumValue:1.0f];
	[_intellectSlider setValue:.55f];
	[_intellectSlider addTarget:self action:@selector(intellectSliderChanged) forControlEvents:UIControlEventValueChanged];
	
	[_enduranceSlider setMinimumValue:.1f];
	[_enduranceSlider setMaximumValue:1.0f];
	[_enduranceSlider setValue:.55f];
	[_enduranceSlider addTarget:self action:@selector(enduranceSliderChanged) forControlEvents:UIControlEventValueChanged];
	
	[self addSubview:_startButton];
	[self addSubview:_backButton];
	[self addSubview:_strengthSlider];
	[self addSubview:_agilitySlider];
	[self addSubview:_intellectSlider];
	[self addSubview:_enduranceSlider];
	[self addSubview:_name];
	[self addSubview:_className];
	
	return self;
	
}

@synthesize backButton = _backButton;
@synthesize delegate = _delegate;
@synthesize startButton = _startButton;
@synthesize strengthSlider = _strengthSlider;
@synthesize agilitySlider = _agilitySlider;
@synthesize intellectSlider = _intellectSlider;
@synthesize enduranceSlider = _enduranceSlider;
@synthesize name = _name;
@synthesize className = _className;


-(void) dealloc
{
	[_startButton release];
	[_backButton release];
	[_strengthSlider release];
	[_agilitySlider release];
	[_intellectSlider release];
	[_enduranceSlider release];
	[_name release];
	[_className release];
	[_backgroundImage release];
	[super dealloc];
}

-(void) drawRect:(CGRect)rect
{
	[_backgroundImage drawInRect:rect];
}

-(void) startButtonPressed
{
	[_delegate startGameButtonPressed];
}
-(void) backButtonPressed
{
	[_delegate backButtonPressed];
}

-(float) sumOfSliders
{
	float sum = _strengthSlider.value + _agilitySlider.value + _intellectSlider.value + _enduranceSlider.value;
	//NSLog(@"sum of sliders: %f", sum);
	return sum;
}

-(void) strengthSliderChanged
{
	if ([self sumOfSliders] >= _statBudget)
	{
		_strengthSlider.value = _statBudget - _agilitySlider.value - _intellectSlider.value - _enduranceSlider.value;
		
		[_strengthSlider setMinimumTrackImage:_redSlider forState:UIControlStateNormal];
		[_agilitySlider setMinimumTrackImage:_redSlider forState:UIControlStateNormal];
		[_intellectSlider setMinimumTrackImage:_redSlider forState:UIControlStateNormal];
		[_enduranceSlider setMinimumTrackImage:_redSlider forState:UIControlStateNormal];
	}
	else 
	{
		_strengthSliderPrevious = _strengthSlider.value;
		
		[_strengthSlider setMinimumTrackImage:_blueSlider forState:UIControlStateNormal];
		[_agilitySlider setMinimumTrackImage:_blueSlider forState:UIControlStateNormal];
		[_intellectSlider setMinimumTrackImage:_blueSlider forState:UIControlStateNormal];
		[_enduranceSlider setMinimumTrackImage:_blueSlider forState:UIControlStateNormal];
	}
	
}

-(void) agilitySliderChanged
{

	if ([self sumOfSliders] >= _statBudget)
	{
		_agilitySlider.value = _statBudget - _intellectSlider.value - _enduranceSlider.value - _strengthSlider.value;
		
		[_strengthSlider setMinimumTrackImage:_redSlider forState:UIControlStateNormal];
		[_agilitySlider setMinimumTrackImage:_redSlider forState:UIControlStateNormal];
		[_intellectSlider setMinimumTrackImage:_redSlider forState:UIControlStateNormal];
		[_enduranceSlider setMinimumTrackImage:_redSlider forState:UIControlStateNormal];
	}
	else
	{
	_agilitySliderPrevious = _agilitySlider.value;
		
		[_strengthSlider setMinimumTrackImage:_blueSlider forState:UIControlStateNormal];
		[_agilitySlider setMinimumTrackImage:_blueSlider forState:UIControlStateNormal];
		[_intellectSlider setMinimumTrackImage:_blueSlider forState:UIControlStateNormal];
		[_enduranceSlider setMinimumTrackImage:_blueSlider forState:UIControlStateNormal];
	}
}

-(void) intellectSliderChanged
{
	if ([self sumOfSliders] >= _statBudget)
	{
		_intellectSlider.value = _statBudget - _agilitySlider.value -  _enduranceSlider.value - _strengthSlider.value;
		
		[_strengthSlider setMinimumTrackImage:_redSlider forState:UIControlStateNormal];
		[_agilitySlider setMinimumTrackImage:_redSlider forState:UIControlStateNormal];
		[_intellectSlider setMinimumTrackImage:_redSlider forState:UIControlStateNormal];
		[_enduranceSlider setMinimumTrackImage:_redSlider forState:UIControlStateNormal];
	}
	else
	{
		_intellectSliderPrevious = _intellectSlider.value;
		
		[_strengthSlider setMinimumTrackImage:_blueSlider forState:UIControlStateNormal];
		[_agilitySlider setMinimumTrackImage:_blueSlider forState:UIControlStateNormal];
		[_intellectSlider setMinimumTrackImage:_blueSlider forState:UIControlStateNormal];
		[_enduranceSlider setMinimumTrackImage:_blueSlider forState:UIControlStateNormal];
	}
}

-(void) enduranceSliderChanged
{

	if ([self sumOfSliders] >= _statBudget)
	{
		_enduranceSlider.value = _statBudget - _agilitySlider.value - _intellectSlider.value - _strengthSlider.value;
		
		[_strengthSlider setMinimumTrackImage:_redSlider forState:UIControlStateNormal];
		[_agilitySlider setMinimumTrackImage:_redSlider forState:UIControlStateNormal];
		[_intellectSlider setMinimumTrackImage:_redSlider forState:UIControlStateNormal];
		[_enduranceSlider setMinimumTrackImage:_redSlider forState:UIControlStateNormal];
	}
	else
	{
		_enduranceSliderPrevious = _enduranceSlider.value;
		
		[_strengthSlider setMinimumTrackImage:_blueSlider forState:UIControlStateNormal];
		[_agilitySlider setMinimumTrackImage:_blueSlider forState:UIControlStateNormal];
		[_intellectSlider setMinimumTrackImage:_blueSlider forState:UIControlStateNormal];
		[_enduranceSlider setMinimumTrackImage:_blueSlider forState:UIControlStateNormal];
	}
}

-(BOOL) textFieldShouldReturn:(UITextField*)textField
{
	[textField resignFirstResponder];
	return YES;
	
}

@end
