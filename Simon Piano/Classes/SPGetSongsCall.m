//
//  SPGetSongsCall.m
//  Simon Piano
//
//  Created by Elliot Schrock on 9/19/16.
//  Copyright © 2016 Triller. All rights reserved.
//

#import "SPGetSongsCall.h"
#import "Mantle.h"
#import "SPSong.h"

@implementation SPGetSongsCall

- (void)fetchSongsWithCompletionBlock:(void(^)(NSArray *songs, NSError *error))completionBlock{
    self.endpoint = @"songs";
    
    [self executeWithCompletionBlock:^(NSDictionary *json, NSError *error) {
        if (error) {
            completionBlock(nil, error);
        }else {
            NSError *mantleError;
            NSArray *songs = [MTLJSONAdapter modelsOfClass:[SPSong class] fromJSONArray:json[@"data"] error:&mantleError];
            completionBlock(songs, mantleError);
        }
    }];
}

@end
