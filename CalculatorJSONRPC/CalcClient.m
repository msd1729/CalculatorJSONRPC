//
//  CalcClient.m
//  CalculatorJSONRPC
//
//  Created by smudigon on 3/6/14.
//  Copyright (c) 2014 smudigon. All rights reserved.
//

#import "CalcClient.h"
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
    NSString *endPoint = @"http://129.219.151.99:8080/JsonRPC/calc";
    JsonRPCClient * request = [[[JsonRPCClient alloc] initWithEndpoint:endPoint]
                               autorelease];
    val = (NSNumber*)[request callMethod:oper
                               withParms:parms];
    
    
    [pool release];
    return 0;
}

