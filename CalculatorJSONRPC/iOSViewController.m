//
//  iOSViewController.m
//  CalculatorJSONRPC
//
//  Created by smudigon on 3/5/14.
//  Copyright (c) 2014 smudigon. All rights reserved.
//

#import "iOSViewController.h"
#import "JsonRPCClient.h"
#import <Foundation/Foundation.h>
#import <Foundation/NSFileHandle.h>
#import <Foundation/NSAutoreleasePool.h>
#import <Foundation/NSString.h>
#import <Foundation/NSData.h>
#import <Foundation/NSArray.h>
#import <Foundation/NSJSONSerialization.h>
#include <string.h>
#include <stdlib.h>








@interface iOSViewController ()
@property (retain, nonatomic) IBOutlet UIButton *ChangeURL;


@property (retain, nonatomic) IBOutlet UIButton *DefaultURL;
@property (retain, nonatomic) IBOutlet UITextField *URLText;


@end

@implementation iOSViewController


@synthesize URLText;



NSString *endPoint = @"http://129.219.151.99:8080/JsonRPC/calc";



- (IBAction)onClickSetURL:(id)sender {
    
   
    URLText.text = endPoint;

}


- (IBAction)onClickingText:(id)sender {
    
    endPoint = URLText.text;
    
}

- (IBAction)onClickDefault:(id)sender {
    endPoint = @"http://129.219.151.99:8080/JsonRPC/calc";
   
    
}






-(IBAction)onClickButton:(id)sender{

    UIButton *button = (UIButton *)sender;
    number = button.currentTitle;

    Screen.text = [Screen.text stringByAppendingString:number];
    SelectNumber = [Screen.text floatValue];
    button_pressed = YES;
    
    
    

}

-(IBAction)Times:(id)sender{
    
    if (RunningTotal == 0) {
        
        RunningTotal = SelectNumber;
        
    }
    
    else{
    
        switch (Method) {
            case 1:
                RunningTotal = RunningTotal * SelectNumber;
                break;
            case 2:
                RunningTotal = RunningTotal / SelectNumber;
                break;
            case 3:
                RunningTotal = RunningTotal + SelectNumber;
                break;
            case 4:
                RunningTotal = RunningTotal - SelectNumber;
                break;
                
            default:
                break;
        }
    }
    
    Method = 1;
    SelectNumber = 0;
    Screen.text = [NSString stringWithFormat:@""];
    operation_started = YES;
    button_pressed = NO;


}
-(IBAction)Divide:(id)sender{
    if (RunningTotal == 0) {
        
        RunningTotal = SelectNumber;
        
    }
    
    else{
        
        switch (Method) {
            case 1:
                RunningTotal = RunningTotal * SelectNumber;
                break;
            case 2:
                RunningTotal = RunningTotal / SelectNumber;
                break;
            case 3:
                RunningTotal = RunningTotal + SelectNumber;
                break;
            case 4:
                RunningTotal = RunningTotal - SelectNumber;
                break;
                
            default:
                break;
        }
    }
    
    Method = 2;
    SelectNumber = 0;
    Screen.text = [NSString stringWithFormat:@""];
    operation_started = YES;
    button_pressed = NO;



}
-(IBAction)Subtract:(id)sender{
    
    
    
    if (RunningTotal == 0 && Screen.text.length == 0) {
        
        RunningTotal = SelectNumber;
        Screen.text = [NSString stringWithFormat:@"-"];
        
        Method = 4;
        SelectNumber = 0;
        
        operation_started = YES;
        button_pressed = NO;
        
        
    }
    
    
    else if (RunningTotal == 0 && Screen.text.length != 0) {
    
        RunningTotal = SelectNumber;
        Method = 4;
        SelectNumber = 0;
        operation_started = YES;
        button_pressed = NO;
        Screen.text = [NSString stringWithFormat:@""];
    
    
    
    }
    
    else if (RunningTotal != 0 && Screen.text.length == 0){
        
        Screen.text = [NSString stringWithFormat:@"-"];
        
       
        
        
        
        button_pressed = NO;
            }
    
    else if (RunningTotal != 0 && Screen.text.length != 0){
        
        
        switch (Method) {
            case 1:
                RunningTotal = RunningTotal * SelectNumber;
                break;
            case 2:
                RunningTotal = RunningTotal / SelectNumber;
                break;
            case 3:
                RunningTotal = RunningTotal + SelectNumber;
                break;
            case 4:
                RunningTotal = RunningTotal - SelectNumber;
                break;
                
            default:
                break;
        }
        
        
        Method = 4;
        SelectNumber = 0;
        Screen.text = [NSString stringWithFormat:@""];
        
        operation_started = YES;
        button_pressed = NO;
    }

    


}
-(IBAction)Plus:(id)sender{
    if (RunningTotal == 0) {
        
        RunningTotal = SelectNumber;
        
    }
    
    else{
        
        switch (Method) {
            case 1:
                RunningTotal = RunningTotal * SelectNumber;
                break;
            case 2:
                RunningTotal = RunningTotal / SelectNumber;
                break;
            case 3:
                RunningTotal = RunningTotal + SelectNumber;
                break;
            case 4:
                RunningTotal = RunningTotal - SelectNumber;
                break;
                
            default:
                break;
        }
    }
    
    Method = 3;
    SelectNumber = 0;
    Screen.text = [NSString stringWithFormat:@""];
    operation_started = YES;
    button_pressed = NO;



}
-(IBAction)Equals:(id)sender{
    
    if(operation_started == NO){
    
       
    
    }
    
    else if(operation_started == YES && button_pressed == YES){
    
        if (Method == 2 && SelectNumber == 0 && RunningTotal == 0){
           
            Screen.text = [NSString stringWithFormat:@"Not a Number"];
            
        }
        
        else if (Method == 2 && SelectNumber == 0 && RunningTotal != 0){
        
            Screen.text = [NSString stringWithFormat:@"Infinite"];
        }
        
        else {
        switch (Method) {
            case 1:
                oper = @"calc.multiply";
                break;
            case 2:
                oper = @"calc.divide";
                break;
            case 3:
                oper = @"calc.add";
                break;
            case 4:
                oper = @"calc.subtract";
                break;
                
            default:
                break;
        }
        JsonRPCClient * request = [[[JsonRPCClient alloc] initWithEndpoint:endPoint]
                                   autorelease];
        
         left = [NSNumber numberWithFloat: RunningTotal ];
         right = [NSNumber numberWithFloat: SelectNumber];
    
         parms = [NSArray arrayWithObjects:left,right,nil];
         val = (NSNumber*)[request callMethod:oper
                                   withParms:parms];
        RunningTotal = [val floatValue];


        
        
        
    Method = 0;
    SelectNumber = 0;
    Screen.text = [NSString stringWithFormat:@"%.2f", RunningTotal];
    }
    }

}
-(IBAction)Clear:(id)sender{
    
    Method = 0;
    RunningTotal = 0;
    SelectNumber = 0;
    operation_started = NO;
    
    Screen.text = [NSString stringWithFormat:@""];


}
- (void)viewDidLoad
{
    
    

    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    
    [URLText release];
    [_DefaultURL release];
    
    
    [_ChangeURL release];
    [super dealloc];
}
@end
