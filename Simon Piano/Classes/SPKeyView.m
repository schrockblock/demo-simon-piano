//
//  SPKeyView.m
//  Simon Piano
//
//  Created by Elliot Schrock on 9/19/16.
//  Copyright © 2016 Triller. All rights reserved.
//

#import "SPKeyView.h"

@interface SPKeyView ()
@property (strong, nonatomic) IBOutlet UIView *view;
@property (weak, nonatomic) IBOutlet UILabel *capView;
@property (weak, nonatomic) IBOutlet UILabel *keyView;
@end

@implementation SPKeyView

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self setupNibNamed:@"SPKeyView"];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupNibNamed:@"SPKeyView"];
    }
    return self;
}

- (void)setupNibNamed:(NSString *)nibName
{
    [[NSBundle mainBundle] loadNibNamed:nibName owner:self options:nil];
    
    [self addSubview:self.view];
    
    self.translatesAutoresizingMaskIntoConstraints = NO;
    self.view.translatesAutoresizingMaskIntoConstraints = NO;
    
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0-[_view]-0-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_view)]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[_view]-0-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_view)]];
    
    self.clipsToBounds = YES;
    self.view.clipsToBounds = YES;
    
    self.view.layer.cornerRadius = 10;
    
    self.capView.layer.cornerRadius = 85;
    self.capView.clipsToBounds = YES;
}

- (IBAction)didTouchDown
{
    if ([self.delegate shouldAcknowledgePressForSPKeyView:self]) {
        self.isKeyDepressed = YES;
    }
}

- (IBAction)didTouchUp
{
    self.isKeyDepressed = NO;
}

- (IBAction)didTouchEnter
{
    if ([self.delegate shouldAcknowledgePressForSPKeyView:self]) {
        self.isKeyDepressed = YES;
    }
}

- (IBAction)didTouchExit
{
    self.isKeyDepressed = NO;
}

- (void)setNormalColor:(UIColor *)normalColor
{
    _normalColor = normalColor;
    self.capView.backgroundColor = normalColor;
}

- (void)setLightColor:(UIColor *)lightColor
{
    _lightColor = lightColor;
}

- (void)setIsKeyDepressed:(BOOL)isKeyDepressed
{
    _isKeyDepressed = isKeyDepressed;
    if (isKeyDepressed) {
        self.capView.backgroundColor = self.lightColor;
        self.keyView.backgroundColor = [UIColor lightGrayColor];
    }else{
        self.capView.backgroundColor = self.normalColor;
        self.keyView.backgroundColor = [UIColor whiteColor];
    }
}

@end
