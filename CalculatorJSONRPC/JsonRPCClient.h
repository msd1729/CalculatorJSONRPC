//
//  JsonRPCClient.h
//  CalculatorJSONRPC
//
//  Created by smudigon on 3/6/14.
//  Copyright (c) 2014 smudigon. All rights reserved.
//

@interface JsonRPCClient : NSObject {
    NSString *method;
    NSURL *url;
    NSArray *parms;
    int anId;
}

@property (readwrite, retain, nonatomic) NSString *method;
@property (readwrite, retain, nonatomic) NSURL *url;
@property (readwrite, retain, nonatomic) NSArray *parms;
@property (readwrite, assign, nonatomic) int anId;

- (id) initWithEndpoint: (NSString*) aURL;

- (id) callMethod:(NSString*)methodName withParms:(NSArray*)parms;

- (id) callMethod:(NSString*)methodName;

- (NSData*) post:(NSData*) msg to:(NSURL*) link;

- (NSString*) getRequestString:(NSDictionary *) inputDict;

- (void) dealloc;

@end
