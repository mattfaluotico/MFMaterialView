//
//  MFMaterialView.m
//  MFMaterialView
//
//  Created by Matthew Faluotico on 11/18/14.
//  Copyright (c) 2014 mf. All rights reserved.
//

#import "MFMaterialView.h"
#import "POP/pop.h"

#pragma mark - default values

CGFloat DEF_DURATION = 0.66;
CGFloat DEF_RADIUS = 150;
BOOL DEF_FIT_TO_SUPER_VIEW = YES;

// ----------------------------------------------

NSString *const kMFMGRadius = @"radius";
NSString *const kMFMGDuration = @"duration";
NSString *const kMFMGColor = @"color";
NSString *const kMFMGClipBounds = @"clip";

// ----------------------------------------------

@interface MFMaterialView ()

@property CGFloat glowRadius;
@property UIColor *glowColor;
@property CGFloat glowDuration;
@property CALayer* circleGlow;

@end

// ----------------------------------------------

@implementation MFMaterialView

- (id) initWithOptions: (NSDictionary *) options {
    self = [super init];
    
    self.options = options;
    [self setupFromOptions];
    return self;
}

- (id) init {
    self = [super init];
    [self setupFromOptions];
    return self;
}

- (id) initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    [self setupFromOptions];
    return self;
}

- (void) setupFromOptions {

    NSLog(@"setting up...");
    
    self.userInteractionEnabled = NO;
    self.layer.masksToBounds = YES;
    
    NSNumber *n = [self.options objectForKey:kMFMGRadius];
    self.glowRadius = (n) ? [n floatValue] : DEF_RADIUS;
    
    n = [self.options objectForKey:kMFMGDuration];
    self.glowDuration = (n) ? [n floatValue] : DEF_DURATION;
    
    UIColor *c = [self.options objectForKey:kMFMGColor];
    self.glowColor = (c) ?: [UIColor colorWithWhite:0.33 alpha:0.2];
    
}

#pragma mark - Building components

- (void) buildGlowPoint: (CGPoint) point {
    CGRect circlerect = CGRectMake(point.x - self.glowRadius /2, point.y - self.glowRadius/2, self.glowRadius, self.glowRadius);
    
    _circleGlow = [CAShapeLayer layer];
    _circleGlow.frame = circlerect;
    _circleGlow.backgroundColor = [self.glowColor CGColor];
    _circleGlow.cornerRadius = _glowRadius / 2;
    
    [self.layer addSublayer:_circleGlow];
    
    // now animate
    [self animateGlow];
};

- (void) removeGlow {
    [_circleGlow removeFromSuperlayer];
    _circleGlow = nil;
}

- (void) willMoveToSuperview:(UIView *)newSuperview {
    self.frame = CGRectMake(0, 0, newSuperview.frame.size.width, newSuperview.frame.size.height);
}

#pragma mark - Managing Hit

- (UIView*) hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    
    id hitView = [super hitTest:point withEvent:event];
    [self buildGlowPoint:point];
    
    if (hitView == self)
        return nil;
    else
        return hitView;
    
}

#pragma mark - performing animations

- (void) animateGlow {
    POPBasicAnimation *grow = [POPBasicAnimation new];
    grow.property = [POPAnimatableProperty propertyWithName:kPOPLayerScaleXY];
    grow.fromValue = [NSValue valueWithCGSize:CGSizeMake(0, 0)];
    grow.toValue = [NSValue valueWithCGSize:CGSizeMake(1, 1)];
    grow.duration = 0.5;
    POPBasicAnimation *fadeOut = [POPBasicAnimation new];
    fadeOut.property = [POPAnimatableProperty propertyWithName:kPOPLayerBackgroundColor];
    fadeOut.toValue = (id)[[UIColor clearColor] CGColor];
    fadeOut.duration = 0.5;
    fadeOut.beginTime = CACurrentMediaTime() + 0.1;

    [fadeOut setCompletionBlock:^(POPAnimation *an, BOOL comp) {
        [self removeGlow];
    }];
    
    [_circleGlow pop_addAnimation:fadeOut forKey:@"fadeOut"];
    [_circleGlow pop_addAnimation:grow forKey:@"grow"];
}

@end
