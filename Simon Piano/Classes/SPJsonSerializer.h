//
//  SPJsonSerializer.h
//  Simon Piano
//
//  Created by Elliot Schrock on 9/19/16.
//  Copyright © 2016 Triller. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SPJsonSerializer : NSObject
+ (NSDictionary *)serializeData:(NSData *)data;
@end
