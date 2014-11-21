//
//  JsonRPCClient.m
//  CalculatorJSONRPC
//
//  Created by smudigon on 3/6/14.
//  Copyright (c) 2014 smudigon. All rights reserved.
//

#import "JsonRPCClient.h"
#define DEBUGON NO

@implementation JsonRPCClient

@synthesize method;
@synthesize url;
@synthesize parms;
@synthesize anId;

- (id) initWithEndpoint: (NSString*) aURL {
    if ( self = [super init] ) {
        // with properties you can either call the getter/setter or use the id.
        [self setUrl:[NSURL URLWithString:aURL]];
        anId = 0;
    }
    return self;
}

- (id) callMethod:(NSString*)methodName
        withParms:(NSArray*)parms {
    anId = anId + 1;
    NSDictionary * req = [NSDictionary
                          dictionaryWithObjectsAndKeys:@"2.0",@"jsonrpc",
                          methodName,@"method",
                          parms,@"params",
                          [NSNumber numberWithInt:anId],@"id",nil];
    NSError * error;
    NSData * json = [NSJSONSerialization dataWithJSONObject: req
                     //options:NSJSONWritingPrettyPrinted
                                                    options:0
                                                      error:&error];
    [self debug:[NSString stringWithFormat:@"json request: %s\n",
                 [[[NSString alloc] initWithData:json
                                        encoding:NSISOLatin1StringEncoding]
                  UTF8String]]];
    NSData *result = [self post: json to: url];
    id ret = nil;
    if(result!=nil){
        [self debug:[NSString stringWithFormat:@"json result: %s\n",
                     [[[NSString alloc] initWithData:result
                                            encoding:NSISOLatin1StringEncoding]
                      UTF8String]]];
        NSError * dserror = nil;
        NSDictionary*dict = [NSJSONSerialization JSONObjectWithData: result
                                                            options:0
                                                              error:&dserror];
        ret = [dict objectForKey:@"result"];
    }
    return ret;
}

- (id) callMethod:(NSString*)methodName {
    anId = anId + 1;
    NSDictionary * req = [NSDictionary
                          dictionaryWithObjectsAndKeys:@"2.0",@"jsonrpc",
                          methodName,@"method",
                          [NSNumber numberWithInt:anId],@"id",nil];
    NSError * error;
    NSData * json = [NSJSONSerialization dataWithJSONObject: req
                     //options:NSJSONWritingPrettyPrinted
                                                    options:0
                                                      error:&error];
    [self debug:[NSString stringWithFormat:@"json request: %s\n",
                 [[[NSString alloc] initWithData:json
                                        encoding:NSISOLatin1StringEncoding]
                  UTF8String]]];
    NSData *result = [self post: json to: url];
    id ret = nil;
    if(result!=nil){
        [self debug:[NSString stringWithFormat:@"json result: %s\n",
                     [[[NSString alloc] initWithData:result
                                            encoding:NSISOLatin1StringEncoding]
                      UTF8String]]];
        NSError * dserror = nil;
        NSDictionary*dict = [NSJSONSerialization JSONObjectWithData: result
                                                            options:0
                                                              error:&dserror];
        ret = [dict objectForKey:@"result"];
    }
    return ret;
}

-(NSData*) post:(NSData*) msg to:(NSURL*) link{
    NSMutableURLRequest *request=[[NSMutableURLRequest alloc] initWithURL:link];
    [request          setValue:@"application/x-www-form-urlencoded"
            forHTTPHeaderField:@"content-type"];
    [request setHTTPMethod: @"POST"];
    [request setHTTPBody: msg];
    [request setTimeoutInterval:10]; // timeout in 10 seconds not 2 minutes
    NSError * error = nil;
    NSData *returnData = [NSURLConnection sendSynchronousRequest: request
                                               returningResponse: nil
                                                           error: &error];
    NSData * ret = nil;
    if(!error){
        ret = returnData;
    }else{
        [self debug:[NSString stringWithFormat:@"error from http post: %s\n",
                     [[error localizedDescription] UTF8String]]];
    }
    return ret;
}

- (NSString *) getRequestString:(NSDictionary *)inputDict {
    NSMutableString * outStr = [NSMutableString stringWithCapacity:512];
    
    NSArray * allKeys = [inputDict allKeys];
    [outStr appendString: @"{ "];
    for (NSString * key in allKeys) {
        if ([[inputDict objectForKey:key] isKindOfClass:[NSDictionary class]]) {
            [outStr appendString:
             [self getRequestString: (NSDictionary *)inputDict]];
        } else {
            [outStr appendString: key];
            [outStr appendString: @": "];
            [outStr appendString:[[inputDict objectForKey: key] description]];
            [outStr appendString: @", "];
        }
    }
    [outStr appendString: @"}\n"];
    return [NSString stringWithString: outStr];
}

- (void) debug: (NSString*) aMessage{
    if(DEBUGON){
        NSLog(aMessage);
        /*
         //NSBundle*aBundle = [NSBundle bundleForClaas:[self class]];
         NSBundle*aBundle = [NSBundle mainBundle];
         // path to application: .../SampleNiblessApp/NiblessApp.app
         NSString*pathSeg = [aBundle bundlePath];
         NSString * fileName = [NSString stringWithFormat:@"%s/%s",
         [pathSeg UTF8String],[@"DebugMessageLog.txt" UTF8String]];
         NSFileHandle* fh = [NSFileHandle fileHandleForWritingAtPath: fileName];
         [fh seekToEndOfFile];
         [fh writeData: [aMessage dataUsingEncoding:NSUTF8StringEncoding]];
         [fh closeFile];
         */
    }
}

- (void) dealloc {
    [method release];
    [url release];
    [parms release];
    [super dealloc];
}

@end
