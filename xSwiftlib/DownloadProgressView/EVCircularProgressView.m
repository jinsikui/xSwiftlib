//
//  EVCircularProgressView.m
//  Test
//
//  Created by Ethan Vaughan on 8/18/13.
//  Copyright (c) 2013 Ethan James Vaughan. All rights reserved.
//

#import "EVCircularProgressView.h"
#import <QuartzCore/QuartzCore.h>

#define DEGREES_TO_RADIANS(x) (x)/180.0*M_PI
#define RADIANS_TO_DEGREES(x) (x)/M_PI*180.0

@interface EVCircularProgressViewBackgroundLayer : CALayer <CALayerDelegate>

@property (nonatomic, strong) Color *tintColor;
@property (nonatomic, strong) Color *bgTintColor;
@property (nonatomic, assign) ProgressLayerType layerType;

@end

@implementation EVCircularProgressViewBackgroundLayer

- (id)init
{
    self = [super init];
    
    if (self) {
#if TARGET_OS_IPHONE
        self.contentsScale = [UIScreen mainScreen].scale;
#else
        self.delegate = self;
#endif
    }
    
    return self;
}

- (void)setTintColor:(Color *)tintColor
{
    _tintColor = tintColor;
    
    [self setNeedsDisplay];
}

- (void)setLayerType:(ProgressLayerType)layerType {
    _layerType = layerType;
    
    [self setNeedsLayout];
}

- (void)setBgTintColor:(UIColor *)bgTintColor {
    _bgTintColor = bgTintColor;
    
    [self setNeedsLayout];
}

- (void)drawInContext:(CGContextRef)ctx
{
    CGContextSetStrokeColorWithColor(ctx, self.bgTintColor.CGColor);
    CGContextSetLineWidth(ctx, 2.0f);
    CGContextStrokeEllipseInRect(ctx, CGRectInset(self.bounds, 1, 1));
    
    CGContextSetFillColorWithColor(ctx, self.tintColor.CGColor);
    if (_layerType == ProgressLayerTypeSquare) {
        CGContextFillRect(ctx, CGRectMake(CGRectGetMidX(self.bounds) - 4, CGRectGetMidY(self.bounds) - 4, 8, 8));
    } else {
        CGContextFillRect(ctx, CGRectMake(CGRectGetMidX(self.bounds) - 4, CGRectGetMidY(self.bounds) - 4, 3, 8));
        CGContextFillRect(ctx, CGRectMake(CGRectGetMidX(self.bounds) + 1, CGRectGetMidY(self.bounds) - 4, 3, 8));
    }
}

#if TARGET_OS_OSX
- (BOOL)layer:(CALayer *)layer shouldInheritContentsScale:(CGFloat)newScale fromWindow:(NSWindow *)UIWindow
{
    return YES;
}
#endif

@end



@interface EVCircularProgressView ()

@property (nonatomic, strong) EVCircularProgressViewBackgroundLayer *backgroundLayer;
@property (nonatomic, strong) CAShapeLayer *shapeLayer;

@end

@implementation EVCircularProgressView {
    Color *_progressTintColor;
    Color *_progressBgTintColor;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self) {
        [self commonInit];
    }
    
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    
    if (self) {
        [self commonInit];
    }
    
    return self;
}

- (void)commonInit
{
    _progressTintColor = [Color blackColor];
    _progressTintColor = [Color blackColor];
    
#if TARGET_OS_OSX
    self.wantsLayer = YES;
#endif
    
    // Set up the background layer
    EVCircularProgressViewBackgroundLayer *backgroundLayer = [[EVCircularProgressViewBackgroundLayer alloc] init];
    backgroundLayer.frame = self.bounds;
    backgroundLayer.tintColor = self.progressTintColor;
    backgroundLayer.bgTintColor = self.progressBgTintColor;
    [self.layer addSublayer:backgroundLayer];
    self.backgroundLayer = backgroundLayer;
    
    // Set up the shape layer
    CAShapeLayer *shapeLayer = [[CAShapeLayer alloc] init];
    shapeLayer.frame = self.bounds;
    shapeLayer.fillColor = nil;
    shapeLayer.strokeColor = self.progressTintColor.CGColor;

    [self.layer addSublayer:shapeLayer];
    self.shapeLayer = shapeLayer;

    [self startIndeterminateAnimation];
}

#pragma mark - Accessors

- (void)setProgress:(float)progress animated:(BOOL)animated
{
    _progress = progress;
    if (progress > 0) {
        BOOL startingFromIndeterminateState = [self.shapeLayer animationForKey:@"indeterminateAnimation"] != nil;

        [self stopIndeterminateAnimation];

        self.shapeLayer.lineWidth = 2;

        CGMutablePathRef path = CGPathCreateMutable();
        CGPathAddArc(path, NULL, CGRectGetMidX(self.bounds), CGRectGetMidY(self.bounds), self.bounds.size.width/2 - 1, -M_PI_2, 3 * M_PI_2, NO);
        self.shapeLayer.path = path;
        CGPathRelease(path);

        if (animated) {
            CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
            animation.fromValue = (startingFromIndeterminateState) ? @0 : @(self.shapeLayer.presentationLayer.strokeEnd);
            animation.toValue = [NSNumber numberWithFloat:progress];
            animation.duration = 0.5;
            self.shapeLayer.strokeEnd = progress;

            [self.shapeLayer addAnimation:animation forKey:@"animation"];
        } else {
            [CATransaction begin];
            [CATransaction setDisableActions:YES];
            self.shapeLayer.strokeEnd = progress;
            [CATransaction commit];
        }
    } else {
        // If progress is zero, then add the indeterminate animation
        [self.shapeLayer removeAnimationForKey:@"animation"];

        [self startIndeterminateAnimation];
    }
}

- (void)setProgress:(float)progress
{
    [self setProgress:progress animated:NO];
}

- (void)setProgressTintColor:(Color *)progressTintColor
{
    if ([self respondsToSelector:@selector(setTintColor:)]) {
        [self setValue:progressTintColor forKey:@"tintColor"];
    } else {
        _progressTintColor = progressTintColor;
        [self tintColorDidChange];
    }
}

- (Color *)progressTintColor
{
    if ([self respondsToSelector:@selector(tintColor)]) {
        return [self valueForKey:@"tintColor"];
    } else {
        return _progressTintColor;
    }
}

- (void)setProgressType:(ProgressLayerType)progressType {
    _progressType = progressType;
    [self tintColorDidChange];
}

#pragma mark - UIControl overrides

#if TARGET_OS_IPHONE
- (void)sendAction:(SEL)action to:(id)target forEvent:(UIEvent *)event
{
    // Ignore touches that occur before progress initiates
    if (self.progress > 0) {
        [super sendAction:action to:target forEvent:event];
    }
}
#else
- (void)mouseUp:(NSEvent *)event
{
    // Ignore touches that occur before progress initiates
    if (self.progress > 0) {
        [self sendAction:self.action to:self.target];
    }
}

- (BOOL)isFlipped
{
    return YES;
}
#endif

#pragma mark - Other methods

- (void)tintColorDidChange
{
    self.backgroundLayer.tintColor = self.progressTintColor;
    self.backgroundLayer.bgTintColor = self.progressBgTintColor;
    self.backgroundLayer.layerType = self.progressType;
    self.shapeLayer.strokeColor = self.progressTintColor.CGColor;
    
}

- (void)startIndeterminateAnimation
{
    [CATransaction begin];
    [CATransaction setDisableActions:YES];
    
    self.backgroundLayer.hidden = YES;
    
    self.shapeLayer.lineWidth = 1;
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathAddArc(path, NULL, CGRectGetMidX(self.bounds), CGRectGetMidY(self.bounds), self.bounds.size.width/2 - 1, DEGREES_TO_RADIANS(12), DEGREES_TO_RADIANS(348), NO);
    self.shapeLayer.path = path;
    CGPathRelease(path);
    
    self.shapeLayer.strokeEnd = 1;
    
    [CATransaction commit];
    
    CABasicAnimation *rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    rotationAnimation.fromValue = [NSNumber numberWithFloat:0.0f];
    rotationAnimation.toValue = [NSNumber numberWithFloat:2*M_PI];
    rotationAnimation.duration = 1.0;
    rotationAnimation.repeatCount = HUGE_VALF;
    
    [self.shapeLayer addAnimation:rotationAnimation forKey:@"indeterminateAnimation"];
}

- (void)stopIndeterminateAnimation
{
    [self.shapeLayer removeAnimationForKey:@"indeterminateAnimation"];
    
    [CATransaction begin];
    [CATransaction setDisableActions:YES];
    self.backgroundLayer.hidden = NO;
    [CATransaction commit];
}

@end
