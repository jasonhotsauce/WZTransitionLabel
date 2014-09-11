//
//  WZTransitionLabel.m
//  WZTransitionLabel
//
//  Created by Wenbin Zhang on 9/10/14.
//  Copyright (c) 2014 Wenbin Zhang. All rights reserved.
//

#import "WZTransitionLabel.h"

@interface WZTransitionLabel ()

@property (nonatomic, strong) CADisplayLink *displayLink;
@property (nonatomic) BOOL fadingOut;
@property (nonatomic, strong) NSMutableArray *characterAnimationDelays;
@property (nonatomic, strong) NSMutableArray *characterAnimationDuration;
@property (nonatomic, strong) NSMutableAttributedString *mutableAttributedString;
@property (nonatomic) CFTimeInterval beginTime;
@property (nonatomic) CGFloat transitionDuration;
@property (nonatomic) CGFloat animationDuration;

@end

@implementation WZTransitionLabel

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super initWithCoder:aDecoder]) {
        [self commonInit];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self commonInit];
    }
    return self;
}

- (void)commonInit
{
    _characterAnimationDelays = [[NSMutableArray alloc] init];
    _characterAnimationDuration = [[NSMutableArray alloc] init];
    _displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(updateAttributedString)];
    _displayLink.paused = YES;
    [_displayLink addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];
}

- (void)updateAttributedString
{
    CFTimeInterval now = CACurrentMediaTime();
    if (now > self.beginTime + self.animationDuration) {
        [self stopAnimation];
        return;
    }
    for (NSInteger i = 0; i < self.mutableAttributedString.length; i++) {
        [self.mutableAttributedString enumerateAttribute:NSForegroundColorAttributeName inRange:NSMakeRange(i, 1) options:NSAttributedStringEnumerationLongestEffectiveRangeNotRequired usingBlock:^(id value, NSRange range, BOOL *stop) {
            if (now - self.beginTime < [self.characterAnimationDelays[i] floatValue]) {
                *stop = YES;
            }
            CGFloat alphaPercent = (now - self.beginTime - [self.characterAnimationDelays[i] floatValue]) / [self.characterAnimationDuration[i] floatValue];
            if (self.fadingOut) {
                alphaPercent = 1- alphaPercent;
            }
            UIColor *color = [(UIColor *)value colorWithAlphaComponent:alphaPercent];
            [self.mutableAttributedString addAttribute:NSForegroundColorAttributeName value:color range:range];
        }];
    }
    self.attributedText = self.mutableAttributedString;
}

-(void)setAttributedText:(NSAttributedString *)attributedText
{
    [super setAttributedText:attributedText];
    self.mutableAttributedString = [attributedText mutableCopy];
    [self setupCharacterAnimationProperties];
}

- (void)setupCharacterAnimationProperties
{
    for (NSUInteger i = 0; i < self.attributedText.length; i++) {
        self.characterAnimationDelays[i] = @(arc4random_uniform(self.animationDuration / 100) / 100);
        CGFloat remain = self.animationDuration - [self.characterAnimationDelays[i] floatValue];
        self.characterAnimationDuration[i] = @(arc4random_uniform(remain * 100) / 100.0);
    }
}

- (void)fadeOutWithCompletion:(void(^)())completion
{
    self.fadingOut = YES;
    self.completion = completion;
    [self startAnimation];
}

- (void)fadeInWithCompletion:(void(^)())completion
{
    self.fadingOut = NO;
    self.completion = completion;
    [self startAnimation];
}

- (void)startAnimation
{
    if (self.displayLink.paused) {
        self.beginTime = CACurrentMediaTime();
        self.displayLink.paused = NO;
    }
}

- (void)stopAnimation
{
    if (self.displayLink.paused == NO) {
        self.displayLink.paused = YES;
    }
    self.beginTime = 0;
    if (self.completion) {
        self.completion();
    }
}

- (void)transiteToAttributedString:(NSAttributedString *)toAttributedString animated:(BOOL)animated duration:(CGFloat)duration
{
    self.transitionDuration = duration;
    self.animationDuration = self.transitionDuration/2;
    if (animated) {
        
        if (self.attributedText) {
            __weak typeof(self) weakSelf = self;
            [self fadeOutWithCompletion:^{
                [weakSelf prepareAttributedStringForTransition:toAttributedString];
                [weakSelf fadeInWithCompletion:nil];
            }];
        } else {
            [self prepareAttributedStringForTransition:toAttributedString];
            [self fadeInWithCompletion:nil];
        }
    } else {
        self.attributedText = toAttributedString;
    }
    
}

- (void)prepareAttributedStringForTransition:(NSAttributedString *)attributedString
{
    NSMutableAttributedString *mutableString = [attributedString mutableCopy];
    [attributedString enumerateAttribute:NSForegroundColorAttributeName inRange:NSMakeRange(0, attributedString.length) options:NSAttributedStringEnumerationLongestEffectiveRangeNotRequired usingBlock:^(id value, NSRange range, BOOL *stop) {
        UIColor *foregroundColor = (UIColor *)value;
        UIColor *modifedColor = [foregroundColor colorWithAlphaComponent:0];
        [mutableString addAttribute:NSForegroundColorAttributeName value:modifedColor range:range];
    }];
    self.attributedText = mutableString;
}


@end
