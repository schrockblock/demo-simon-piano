//
//  SPGetSongCall.m
//  Simon Piano
//
//  Created by Elliot Schrock on 9/19/16.
//  Copyright © 2016 Triller. All rights reserved.
//

#import "SPGetSongCall.h"
#import "SPSong.h"

@implementation SPGetSongCall

- (void)fetchSong:(SPSong *)song completionBlock:(void(^)(SPSong *song, NSError *error))completionBlock
{
    self.endpoint = [NSString stringWithFormat:@"notes/%i", song.noteId];
    
    [self executeWithCompletionBlock:^(NSDictionary *json, NSError *error) {
        if (error) {
            completionBlock(nil, error);
        }else {
            song.notes = [json[@"data"][@"description"] componentsSeparatedByString:@"-"];
            completionBlock(song, nil);
        }
    }];
}

@end
