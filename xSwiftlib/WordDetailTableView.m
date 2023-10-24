#import "WordDetailTableView.h"
#import <YYKit/YYKit.h>

@implementation WordDetailTableView

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

@end
