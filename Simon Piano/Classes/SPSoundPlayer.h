//
//  SPSongPlayer.h
//  Simon Piano
//
//  Created by Elliot Schrock on 9/19/16.
//  Copyright © 2016 Triller. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SPSoundPlayer : NSObject
- (void)playSoundWithName:(NSString *)name withType:(NSString *)fileType;
@end
