#import "WordDetailCollectionView.h"


@implementation WordDetailCollectionView

#pragma mark -

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
    if (self.contentOffset.y <= - self.contentInset.top) {
        CGFloat yVelocity = [self.panGestureRecognizer velocityInView:self].y;
        if (yVelocity > 0) {
            QBPostNotification(WordDetailShouldScrollNotification);
            return NO;
        } else {
            return YES;
        }
    }
    return YES;
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch {
    return YES;
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveEvent:(UIEvent *)event {
    return YES;
}

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    return [super hitTest:point withEvent:event];
}

- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event {
    return [super pointInside:point withEvent:event];
}

@end
