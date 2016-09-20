//
//  SPPianoViewController.h
//  Simon Piano
//
//  Created by Elliot Schrock on 9/19/16.
//  Copyright © 2016 Triller. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SPKeyView;
@class SPSong;

@interface SPPianoViewController : UIViewController
@property (nonatomic, strong) SPSong *song;
@end
