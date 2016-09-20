//
//  SPJsonSerializer.m
//  Simon Piano
//
//  Created by Elliot Schrock on 9/19/16.
//  Copyright © 2016 Triller. All rights reserved.
//

#import "SPJsonSerializer.h"

@implementation SPJsonSerializer

+ (NSDictionary *)serializeData:(NSData *)data
{
    NSError *jsonError;
    NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&jsonError];
    return json;
}

@end
