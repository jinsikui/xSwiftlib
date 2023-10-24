#import "WordBase.h"


@implementation WordBase

- (BOOL)isEqual:(id)object {
    if (object == nil || [object isKindOfClass:[NSNull class]]) {
        return NO;
    }
    if ([object isKindOfClass:[WordBase class]] == NO) return NO;

    WordBase *word = (WordBase *)object;

    return [self.word isEqualToString:word.word] && [self.originId isEqualToString:word.originId] &&
           self.originType == word.originType;
}

- (NSUInteger)hash {
    return [self.word hash] ^ [self.originId hash] ^ [@(self.originType) hash];
    return [self modelHash];
}

@end
