//
//  OBInitialCircleView.m
//  OBFilterMenu
//
//  Created by Ivan Golikov on 09.01.16.
//  Copyright © 2016 Ivan Golikov. All rights reserved.
//

#import "OBInitialCircleView.h"

@interface OBInitialCircleView ()

@property (nonatomic, readonly) UIView      *bigCircleView;

@property (nonatomic, readonly) UIButton    *circleButton;

@end

@implementation OBInitialCircleView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _circleButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        self.circleButton.backgroundColor = [UIColor colorWithRed:233.0/255.0 green:91.0/255.0 blue:114.0/255.0 alpha:0.3];
        self.circleButton.clipsToBounds = YES;
        [self.circleButton addTarget:self action:@selector(animateCircleAppearance) forControlEvents:UIControlEventTouchUpInside];
        
        [self addSubview:self.circleButton];
        
        
        _bigCircleView = [UIView new];
        self.bigCircleView.backgroundColor = [UIColor colorWithRed:238.0/255.0 green:87.0/255.0 blue:108.0/255.0 alpha:1.0];
        self.bigCircleView.clipsToBounds = YES;
        self.bigCircleView.layer.cornerRadius = 0;
        
        [self insertSubview:self.bigCircleView belowSubview:self.circleButton];
        
    }
    return self;
}



- (void)animateCircleAppearance {
    NSLog(@"yes!");
    self.circleButton.backgroundColor = [UIColor colorWithRed:207.0/255.0 green:84.0/255.0 blue:105.0/255.0 alpha:1.0];
    
    self.bigCircleView.frame = ({
        CGRect frame = CGRectZero;
        frame.origin.x = CGRectGetMidX(self.circleButton.frame);
        frame.origin.y = CGRectGetMidY(self.circleButton.frame);
        frame;
    });
    
    /*
     [UIView animateWithDuration:1.0f delay:0.0f options:UIViewAnimationOptionCurveLinear animations:^{
     CGRect bigCircleViewRect = self.bigCircleView.frame;
     bigCircleViewRect.size.width = self.circleButton.frame.size.width * 3.0;
     bigCircleViewRect.size.height = self.circleButton.frame.size.height * 3.0;
     self.bigCircleView.frame = bigCircleViewRect;
     } completion:nil];
     */
    CGFloat animationDuration = 3.0; // Your duration
    CGFloat animationDelay = 0.0; // Your delay (if any)
    
    CABasicAnimation *cornerRadiusAnimation = [CABasicAnimation animationWithKeyPath:@"cornerRadius"];
    [cornerRadiusAnimation setFromValue:[NSNumber numberWithFloat:0.0]]; // The current value
    [cornerRadiusAnimation setToValue:[NSNumber numberWithFloat:30.0]]; // The new value
    [cornerRadiusAnimation setDuration:animationDuration];
    [cornerRadiusAnimation setBeginTime:CACurrentMediaTime() + animationDelay];
    
    // If your UIView animation uses a timing funcition then your basic animation needs the same one
    [cornerRadiusAnimation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
    
    // This will keep make the animation look as the "from" and "to" values before and after the animation
    [cornerRadiusAnimation setFillMode:kCAFillModeBoth];
    [[self.bigCircleView layer] addAnimation:cornerRadiusAnimation forKey:@"keepAsCircle"];
    [[self.bigCircleView layer] setCornerRadius:30.0]; // Core Animation doesn't change the real value so we have to.
    
    [UIView animateWithDuration:animationDuration
                          delay:animationDelay
                        options:UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         
                         self.bigCircleView.layer.frame = ({
                             CGRect frame = self.bigCircleView.layer.frame;
                             frame.origin.x -= 30.0;
                             frame.origin.y -= 30.0;
                             frame.size.width = 60.0;
                             frame.size.height = 60.0;
                             frame;
                         });
                     } completion:^(BOOL finished) {
                         NSLog(@"Completed");
                     }];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGRect circleRect = self.circleButton.frame;
    circleRect.size.width = self.frame.size.width / 3.0;
    circleRect.size.height = self.frame.size.height / 3.0;
    self.circleButton.frame = circleRect;
    self.circleButton.layer.cornerRadius = self.circleButton.frame.size.width / 2.0;
    
    NSLog(@"%s", __PRETTY_FUNCTION__);
}



/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
