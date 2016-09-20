//
//  SPGetSongsCall.h
//  Simon Piano
//
//  Created by Elliot Schrock on 9/19/16.
//  Copyright © 2016 Triller. All rights reserved.
//

#import "SPNetworkCall.h"

@interface SPGetSongsCall : SPNetworkCall
- (void)fetchSongsWithCompletionBlock:(void(^)(NSArray *songs, NSError *error))completionBlock;
@end
