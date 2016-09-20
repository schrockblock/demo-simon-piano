//
//  SPPianoViewController.m
//  Simon Piano
//
//  Created by Elliot Schrock on 9/19/16.
//  Copyright © 2016 Triller. All rights reserved.
//

#import "SPPianoViewController.h"
#import "SPKeyView.h"
#import "SPSoundPlayer.h"
#import "UIColor+Hex.h"
#import "SPGetSongCall.h"
#import "SPSong.h"
#import "SPGameManager.h"

@interface SPPianoViewController () <SPKeyViewDelegate, SPGameManagerDelegate>
@property (weak, nonatomic) IBOutlet UIView *pianoView;
@property (weak, nonatomic) IBOutlet SPKeyView *keyOne;
@property (weak, nonatomic) IBOutlet SPKeyView *keyTwo;
@property (weak, nonatomic) IBOutlet SPKeyView *keyThree;
@property (weak, nonatomic) IBOutlet SPKeyView *keyFour;
@property (weak, nonatomic) IBOutlet SPKeyView *keyFive;
@property (weak, nonatomic) IBOutlet SPKeyView *keySix;
@property (strong, nonatomic) IBOutletCollection(SPKeyView) NSArray *keys;
@property (weak, nonatomic) IBOutlet UIButton *playButton;
@property (weak, nonatomic) IBOutlet UILabel *feedbackLabel;
@property (weak, nonatomic) IBOutlet UIImageView *backgroundImage;
@property (nonatomic, strong) SPSoundPlayer *player;
@property (nonatomic, strong) SPGameManager *gameManager;

@end

@implementation SPPianoViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setupKeys];
    
    self.player = [[SPSoundPlayer alloc] init];
    
    if (self.song) {
        self.title = self.song.songDescription;
        self.feedbackLabel.text = @"Press the button to start!";
        
        [[[SPGetSongCall alloc] init] fetchSong:self.song completionBlock:^(SPSong *song, NSError *error) {
            self.song = song;
            self.gameManager = [[SPGameManager alloc] init];
            self.gameManager.song = self.song;
            self.gameManager.delegate = self;
        }];
    }else{
        self.playButton.hidden = YES;
    }
}

- (void)setupKeys
{
    NSArray *normalColors = @[[UIColor colorWithHex:0xa82748],[UIColor colorWithHex:0x20759c],[UIColor colorWithHex:0x4c9028],[UIColor colorWithHex:0xc7aa14],[UIColor colorWithHex:0x26a6b9],[UIColor colorWithHex:0x951475]];
    NSArray *lightColors = @[[UIColor colorWithHex:0xd9447c],[UIColor colorWithHex:0x209fcb],[UIColor colorWithHex:0x6fc043],[UIColor colorWithHex:0xfadc42],[UIColor colorWithHex:0x4cd5e9],[UIColor colorWithHex:0xb33483]];
    for (int i = 0; i<self.keys.count; i++) {
        SPKeyView *keyView = self.keys[i];
        keyView.keyId = i + 1;
        keyView.delegate = self;
        if (i < normalColors.count) {
            keyView.normalColor = normalColors[i];
            keyView.lightColor = lightColors[i];
        }
    }
}

- (IBAction)playPressed:(UIButton *)sender
{
    if (self.gameManager.isUserPlaying) {
        [self.gameManager stopGame];
        [sender setBackgroundImage:[UIImage imageNamed:@"play-button-white"] forState:UIControlStateNormal];
    }else{
        if (self.song.notes) {
            [sender setBackgroundImage:[UIImage imageNamed:@"play-button"] forState:UIControlStateNormal];
            self.backgroundImage.image = [UIImage imageNamed:@"bg-lightgray"];
            [self.gameManager startGame];
        }
    }
}

- (void)clearKeys
{
    for (SPKeyView *keyView in self.keys) {
        keyView.isKeyDepressed = NO;
    }
}

#pragma mark - key view delegate

- (BOOL)shouldAcknowledgePressForSPKeyView:(SPKeyView *)keyView
{
    BOOL result = !self.gameManager.isPlaying;
    if (!self.gameManager.isPlaying) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.player playSoundWithName:[NSString stringWithFormat:@"%i", keyView.keyId] withType:@"aif"];
        });
        [self.gameManager checkUserCorrectness:keyView.keyId];
    }
    return result;
}

#pragma mark - game delegate

- (void)willPlayNote:(NSString *)noteString
{
    [self.player playSoundWithName:noteString withType:@"aif"];
    
    [self clearKeys];
    
    int noteInt = [noteString intValue];
    ((SPKeyView *)self.keys[noteInt - 1]).isKeyDepressed = YES;
}

- (void)computersTurn
{
    self.feedbackLabel.text = @"Listen...";
    [self clearKeys];
    self.backgroundImage.image = [UIImage imageNamed:@"bg-light-purple"];
}

- (void)usersTurn
{
    self.feedbackLabel.text = @"Your turn!";
    [self clearKeys];
    self.backgroundImage.image = [UIImage imageNamed:@"bg-lightgreen"];
}

- (void)userWon
{
    self.feedbackLabel.text = @"Yay! You won!";
    [self playPressed:self.playButton];
    self.backgroundImage.image = [UIImage imageNamed:@"bg-lightgray"];
}

- (void)userLost
{
    self.feedbackLabel.text = @"Awww... Try again!";
    [self playPressed:self.playButton];
    self.backgroundImage.image = [UIImage imageNamed:@"bg-lightred"];
}

@end
