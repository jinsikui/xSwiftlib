#import "WordDetailScrollView.h"
#import <YYKit/YYKit.h>

@implementation WordDetailScrollView

#pragma mark - UIGestureRecognizerDelegate

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
    if (self.contentOffset.y <= - self.contentInset.top) {
        CGFloat yVelocity = [self.panGestureRecognizer velocityInView:self].y;
        if (yVelocity > 0) {
            NSLog(@"tabscroll: gestureRecognizerShouldBegin gesture.view.class: %@ yVelocity: %@, will post WordDetailShouldScrollNotification", gestureRecognizer.view.class, @(yVelocity));
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

@end
