//
//  SPNetworkCall.m
//  Simon Piano
//
//  Created by Elliot Schrock on 9/19/16.
//  Copyright © 2016 Triller. All rights reserved.
//

#import "SPNetworkCall.h"
#import "SPJsonSerializer.h"

@interface SPNetworkCall ()
@property (nonatomic, strong) NSString *scheme;
@property (nonatomic, strong) NSString *host;
@property (nonatomic, strong) NSString *baseRoute;
@property (nonatomic, strong) NSMutableURLRequest *mutableRequest;
@property (nonatomic, strong) NSURLSessionDataTask *task;

@end

@implementation SPNetworkCall

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self setup];
    }
    return self;
}

- (void)setup
{
    self.httpMethod = @"GET";
    self.scheme = @"http";
    self.host = @"ec2-54-218-31-233.us-west-2.compute.amazonaws.com";
    self.baseRoute = @"/api/v1/";
}

- (void)cancel
{
    if (self.task) {
        [self.task cancel];
    }
}

- (NSURL *)url
{
    return [NSURL URLWithString:[NSString stringWithFormat:@"%@://%@%@%@", self.scheme, self.host, self.baseRoute, self.endpoint]];
}

- (NSMutableURLRequest *)mutableRequest
{
    _mutableRequest = [NSMutableURLRequest requestWithURL:[self url]];
    _mutableRequest.HTTPMethod = self.httpMethod;
    [_mutableRequest setValue:@"application/json" forHTTPHeaderField:@"Content-type"];
    
    if (![self.httpMethod isEqualToString:@"GET"]) _mutableRequest.HTTPBody = self.postData;
    
    return _mutableRequest;
}

- (void)executeWithCompletionBlock:(void(^)(NSDictionary *json, NSError *error))completionBlock
{
    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    self.task = [session dataTaskWithRequest:self.mutableRequest completionHandler:^(NSData *data, NSURLResponse *response, NSError *error){
        dispatch_async(dispatch_get_main_queue(), ^{
            if (error) NSLog(@"%@", error.debugDescription);
            if (((NSHTTPURLResponse *)response).statusCode >= 300) {
                NSLog(@"status %li: %@", (long)((NSHTTPURLResponse *)response).statusCode, [self url]);
                NSError *serverError = [NSError errorWithDomain:@"TrillerServerDomain" code:((NSHTTPURLResponse *)response).statusCode userInfo:[SPJsonSerializer serializeData:data]];
                completionBlock([SPJsonSerializer serializeData:data], serverError);
            }else if (error.code != -999) {
                if (data) {
                    completionBlock([SPJsonSerializer serializeData:data], error);
                }else{
                    completionBlock(nil, error);
                }
                
            }
        });
    }];
    [self.task resume];
}

- (NSString *)getApiKey
{
    return nil;
}

@end
