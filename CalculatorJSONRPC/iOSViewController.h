//
//  iOSViewController.h
//  CalculatorJSONRPC
//
//  Created by smudigon on 3/5/14.
//  Copyright (c) 2014 smudigon. All rights reserved.
//

#import <UIKit/UIKit.h>

int Method;
float SelectNumber;
float RunningTotal;
NSString *number;
bool operation_started = NO;
bool button_pressed;
NSString *oper;
NSNumber *left;
NSNumber *right;
NSArray *parms;
NSNumber *val;

@interface iOSViewController : UIViewController
{
    IBOutlet UILabel *Screen;

}

-(IBAction)onClickButton:(id)sender;

-(IBAction)Times:(id)sender;
-(IBAction)Divide:(id)sender;
-(IBAction)Subtract:(id)sender;
-(IBAction)Plus:(id)sender;
-(IBAction)Equals:(id)sender;
-(IBAction)Clear:(id)sender;

@end
