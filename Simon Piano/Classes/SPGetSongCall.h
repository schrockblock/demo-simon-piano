//
//  SPGetSongCall.h
//  Simon Piano
//
//  Created by Elliot Schrock on 9/19/16.
//  Copyright © 2016 Triller. All rights reserved.
//

#import "SPNetworkCall.h"
@class SPSong;

@interface SPGetSongCall : SPNetworkCall
- (void)fetchSong:(SPSong *)song completionBlock:(void(^)(SPSong *song, NSError *error))completionBlock;
@end
