//
//  WZTransitionLabel.h
//  WZTransitionLabel
//
//  Created by Wenbin Zhang on 9/10/14.
//  Copyright (c) 2014 Wenbin Zhang. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^TransitionLabelTransitionCompleted)();

@interface WZTransitionLabel : UILabel

@property (nonatomic, copy) TransitionLabelTransitionCompleted completion;

- (void)transiteToAttributedString:(NSAttributedString *)toAttributedString animated:(BOOL)animated duration:(CGFloat)duration;
@end
