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
        self.circleButton.backgroundColor = [UIColor colorWithRed:233.0/255.0 green:91.0/255.0 blue:114.0/255.0 alpha:1.0];
        self.circleButton.clipsToBounds = YES;
        [self.circleButton addTarget:self action:@selector(animateEnlargingCircleAppearance) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:self.circleButton];
        
        _bigCircleView = [UIView new];
        self.bigCircleView.backgroundColor = [UIColor colorWithRed:238.0/255.0 green:87.0/255.0 blue:108.0/255.0 alpha:1.0];
        self.bigCircleView.clipsToBounds = YES;
        
        [self insertSubview:self.bigCircleView belowSubview:self.circleButton];
    }
    return self;
}
/*
- (void)calling {
    [self performSelector:@selector(animateEnlargingCircleAppearanceToSize:)withObject:[NSNumber numberWithFloat:self.circleButton.frame.size.width * 2.0f]];
}
*/

- (void)animateEnlargingCircleAppearance {
    self.circleButton.backgroundColor = [UIColor colorWithRed:207.0/255.0 green:84.0/255.0 blue:105.0/255.0 alpha:1.0];
    /*
    self.bigCircleView.frame = ({
        CGRect frame   = CGRectZero;
        frame.origin.x = CGRectGetMidX(self.circleButton.frame);
        frame.origin.y = CGRectGetMidY(self.circleButton.frame);
        frame;
    });
     */
    self.bigCircleView.layer.frame = self.circleButton.layer.frame;
    self.bigCircleView.layer.cornerRadius = self.circleButton.layer.cornerRadius;
    CGFloat size = self.circleButton.frame.size.width * 2.0;
    CGFloat animationDuration = 3.0;
    
    CABasicAnimation *cornerRadiusAnimation = [CABasicAnimation animationWithKeyPath:@"cornerRadius"];
    [cornerRadiusAnimation setFromValue:[NSNumber numberWithFloat:self.circleButton.layer.cornerRadius]];
    [cornerRadiusAnimation setToValue:[NSNumber numberWithFloat:size / 2.0]];
    [cornerRadiusAnimation setDuration:animationDuration];
    [cornerRadiusAnimation setBeginTime:CACurrentMediaTime()];
    
    [cornerRadiusAnimation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
    
    [cornerRadiusAnimation setFillMode:kCAFillModeBoth];
    [[self.bigCircleView layer] addAnimation:cornerRadiusAnimation forKey:@"keepAsCircle"];
    [[self.bigCircleView layer] setCornerRadius:size / 2.0];
    
    [UIView animateWithDuration:animationDuration
                          delay:0.0
                        options:UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         
                         self.bigCircleView.layer.frame = ({
                             CGRect frame = self.bigCircleView.layer.frame;
                             frame.origin.x -= size / 4.0;
                             frame.origin.y -= size / 4.0;
                             frame.size.width = size;
                             frame.size.height = size;
                             frame;
                         });
                     } completion:nil];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.circleButton.frame = ({
        CGRect frame      = CGRectZero;
        frame.size.width  = self.frame.size.width / 3.0;
        frame.size.height = self.frame.size.height / 3.0;
        frame;
    });
    self.circleButton.layer.cornerRadius = self.circleButton.frame.size.width / 2.0;
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
