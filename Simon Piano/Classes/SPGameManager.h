//
//  SPGameManager.h
//  Simon Piano
//
//  Created by Elliot Schrock on 9/19/16.
//  Copyright © 2016 Triller. All rights reserved.
//

#import <Foundation/Foundation.h>
@class SPSong;

@protocol SPGameManagerDelegate <NSObject>
- (void)computersTurn;
- (void)usersTurn;
- (void)userWon;
- (void)userLost;
- (void)willPlayNote:(NSString *)noteString;
@end

@interface SPGameManager : NSObject
@property (nonatomic, weak) NSObject<SPGameManagerDelegate> *delegate;
@property (nonatomic) BOOL isPlaying;
@property (nonatomic) BOOL isUserPlaying;
@property (nonatomic, weak) SPSong *song;

- (void)startGame;
- (void)stopGame;
- (void)checkUserCorrectness:(int)keyId;
@end
