//
//  SPNetworkCall.h
//  Simon Piano
//
//  Created by Elliot Schrock on 9/19/16.
//  Copyright © 2016 Triller. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SPNetworkCall : NSObject
@property (nonatomic, strong) NSString *httpMethod;
@property (nonatomic, strong) NSString *endpoint;
@property (nonatomic, strong) NSData *postData;

- (void)executeWithCompletionBlock:(void(^)(NSDictionary *json, NSError *error))completionBlock;
- (NSMutableURLRequest *)mutableRequest;
- (void)setup;
- (void)cancel;
@end
