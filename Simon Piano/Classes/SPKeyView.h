//
//  SPKeyView.h
//  Simon Piano
//
//  Created by Elliot Schrock on 9/19/16.
//  Copyright © 2016 Triller. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SPKeyView;

@protocol SPKeyViewDelegate <NSObject>
- (BOOL)shouldAcknowledgePressForSPKeyView:(SPKeyView *)keyView;
@end

@interface SPKeyView : UIView
@property (nonatomic) int keyId;
@property (weak, nonatomic) NSObject<SPKeyViewDelegate> *delegate;
@property (nonatomic, strong) UIColor *normalColor;
@property (nonatomic, strong) UIColor *lightColor;
@property (nonatomic) BOOL isKeyDepressed;

@end
