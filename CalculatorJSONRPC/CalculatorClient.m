//
//  CalculatorClient.m
//  CalculatorJSONRPC
//
//  Created by smudigon on 3/6/14.
//  Copyright (c) 2014 smudigon. All rights reserved.
//


#import <Foundation/Foundation.h>
#import <Foundation/NSFileHandle.h>
#import <Foundation/NSAutoreleasePool.h>
#import <Foundation/NSString.h>
#import <Foundation/NSData.h>
#import <Foundation/NSArray.h>
#import <Foundation/NSJSONSerialization.h>
#import "JsonRPCClient.h"
#import "iOSViewController.h"


#import <stdio.h>
#include <string.h>
#include <stdlib.h>

int main( int argc, const char *argv[] ) {
    // don't use auto reference counting.
    NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
   
    //NSString *endText = @"end";
    NSString *endPoint = @"http://129.219.151.99:8080/JsonRPC/calc";
    if (argc >= 2){
        endPoint = [NSString stringWithUTF8String: argv[1]];
    }else{
        printf("use: CalcClient http://pooh.poly.asu.edu:8080/JsonRPC/calc\n");
        printf("Defaulting to: %s\n",[endPoint UTF8String]);
    }
    JsonRPCClient * request = [[[JsonRPCClient alloc] initWithEndpoint:endPoint]
                               autorelease];
    NSString * whoIsIt = (NSString*)[request callMethod:@"calc.whoAreYou"];
    if(whoIsIt){  //in C, true is anything but 0 and nil is zero
        printf("Service identity: %s\n",[whoIsIt UTF8String]);
    }else {
        printf("Error trying to identify service\n");
    }

   
    val = (NSNumber*)[request callMethod:oper
                               withParms:parms];
    
    if(val){
        printf("result is: %6.3f\n",[val doubleValue]);
        

    }else{
        printf("call returned an error\n");
    }

   
    
    
    
    [pool release];
    return 0;
    
}
