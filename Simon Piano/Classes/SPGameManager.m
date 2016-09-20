//
//  SPGameManager.m
//  Simon Piano
//
//  Created by Elliot Schrock on 9/19/16.
//  Copyright © 2016 Triller. All rights reserved.
//

#import "SPGameManager.h"
#import "SPSong.h"
#import "SPSoundPlayer.h"

@interface SPGameManager ()
@property (nonatomic) int level;
@property (nonatomic) int index;
@property (nonatomic, strong) NSMutableArray *userNotes;

@end

static float const SPBPM = 90;

@implementation SPGameManager

- (void)startGame
{
    self.isUserPlaying = YES;
    
    self.level = 0;
    self.index = 0;
    self.isPlaying = YES;
    [self playNextLevel];
}

- (void)stopGame
{
    self.isPlaying = NO;
    self.isUserPlaying = NO;
    self.index = 0;
}

- (void)playNextLevel
{
    if (self.level < self.song.notes.count) {
        self.level++;
        self.index = 0;
        self.userNotes = [[NSMutableArray alloc] init];
        [self.delegate computersTurn];
        self.isPlaying = YES;
        [self playNoteAtIndex:self.index];
    }else{
        [self.delegate userWon];
    }
}

- (void)playNoteAtIndex:(int)index
{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(60.f / SPBPM * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        if (self.isPlaying) {
            if (self.index < self.level) {
                NSString *noteString = self.song.notes[self.index];
                [self.delegate willPlayNote:noteString];
                
                self.index++;
                [self playNoteAtIndex:self.index];
            }else{
                self.isPlaying = NO;
                self.index = 0;
                [self.delegate usersTurn];
            }
        }
    });
}

- (void)checkUserCorrectness:(int)keyId
{
    if (self.isUserPlaying) {
        BOOL isUserCorrect = YES;
        [self.userNotes addObject:[NSString stringWithFormat:@"%i", keyId]];
        for (int i = 0; i<self.userNotes.count; i++) {
            if (![self.userNotes[i] isEqualToString:self.song.notes[i]]) {
                isUserCorrect = NO;
                break;
            }
        }
        if (isUserCorrect) {
            if (self.index == self.level - 1) {
                [self playNextLevel];
            }else{
                self.index++;
            }
        }else{
            self.userNotes = [[NSMutableArray alloc] init];
            [self.delegate userLost];
        }
    }
}

#pragma mark - lazy loading

- (NSMutableArray *)userNotes
{
    if (!_userNotes) _userNotes = [[NSMutableArray alloc] init];
    return _userNotes;
}

@end
