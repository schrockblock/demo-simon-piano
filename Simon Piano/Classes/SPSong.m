//
//  SPSong.m
//  Simon Piano
//
//  Created by Elliot Schrock on 9/19/16.
//  Copyright © 2016 Triller. All rights reserved.
//

#import "SPSong.h"

@implementation SPSong

+ (NSDictionary *)JSONKeyPathsByPropertyKey
{
    NSMutableDictionary *mapping = [[NSMutableDictionary alloc] init];
    [mapping addEntriesFromDictionary:@{@"noteId" : @"note_id",
                                        @"songDescription" : @"description"}];
    return mapping;
}

@end
