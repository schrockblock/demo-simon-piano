//
//  SPSongPlayer.m
//  Simon Piano
//
//  Created by Elliot Schrock on 9/19/16.
//  Copyright © 2016 Triller. All rights reserved.
//

#import "SPSoundPlayer.h"
#import <AVFoundation/AVFoundation.h>

@interface SPSoundPlayer ()
@property (nonatomic, strong) AVAudioPlayer *player;
@end

@implementation SPSoundPlayer

- (instancetype)init
{
    self = [super init];
    if (self) {
        [[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryAmbient error:nil];
        [[AVAudioSession sharedInstance] setActive:YES error:nil];
    }
    return self;
}

- (void)playSoundWithName:(NSString *)name withType:(NSString *)fileType
{
    NSURL *sound = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:name ofType:fileType]];
    NSError *error;
    self.player = [[AVAudioPlayer alloc] initWithContentsOfURL:sound error:&error];
    [self.player prepareToPlay];
    
    [self.player play];
}

@end
