#import "LearntWord+WCTTableCoding.h"

@implementation LearntWord

WCDB_IMPLEMENTATION(LearntWord)
WCDB_SYNTHESIZE(LearntWord, aid)
WCDB_SYNTHESIZE_COLUMN(LearntWord, wordId, "word_id")
WCDB_SYNTHESIZE(LearntWord, originId)
WCDB_SYNTHESIZE(LearntWord, originType)
WCDB_SYNTHESIZE(LearntWord, word)
WCDB_SYNTHESIZE_COLUMN_DEFAULT(LearntWord, tagId, "tag_id", 4)
WCDB_SYNTHESIZE(LearntWord, addDate)
WCDB_SYNTHESIZE(LearntWord, updateDate)
WCDB_SYNTHESIZE(LearntWord, wrongTimes)
WCDB_SYNTHESIZE(LearntWord, knowWrongTimes)
WCDB_SYNTHESIZE(LearntWord, listenWrongTimes)
WCDB_SYNTHESIZE(LearntWord, speakWrongTimes)

WCDB_SYNTHESIZE(LearntWord, reviewAnswerTimes)
WCDB_SYNTHESIZE(LearntWord, reviewWrongTimes)

WCDB_SYNTHESIZE(LearntWord, belongId)
WCDB_SYNTHESIZE(LearntWord, belongType)
WCDB_SYNTHESIZE(LearntWord, mode)

/// 增加存储待测试能力字段，用于再复习一遍时，确定是否已经回答正确。
WCDB_SYNTHESIZE(LearntWord, abilityOption)

WCDB_SYNTHESIZE_COLUMN(LearntWord, examStatus, "exam_status")
WCDB_SYNTHESIZE_COLUMN(LearntWord, examCompleted, "exam_completed")
WCDB_SYNTHESIZE(LearntWord, isCurrentRound)
WCDB_SYNTHESIZE(LearntWord, firstSubjectiveResult)
WCDB_SYNTHESIZE(LearntWord, preciseReviewState)
WCDB_SYNTHESIZE(LearntWord, masterOption)

WCDB_PRIMARY_ASC_AUTO_INCREMENT(LearntWord, aid)
WCDB_NOT_NULL(LearntWord, word)

- (NSString *)wordbookId {
    return self.originId;
}

- (void)setWordbookId:(NSString *)wordbookId {
    self.originId = wordbookId;
    self.originType = WordOriginWordBook;
}

- (BOOL)isEqual:(id)object {
    if (![object isKindOfClass:[LearntWord class]]) {
        return NO;
    }

    if (object == nil) {
        return NO;
    }

    LearntWord *word = (LearntWord *)object;
    return [word.word isEqualToString:self.word];
}

#pragma mark - YYModel

/**
 All the properties in blacklist will be ignored in model transform process.
 Returns nil to ignore this feature.

 @return An array of property's name.
 */
+ (nullable NSArray<NSString *> *)modelPropertyBlacklist {
    return @[ @"addDate", @"nextDate", @"lastLearn", @"updateDate" ];
}

+ (NSDictionary<NSString *, id> *)modelCustomPropertyMapper {
    return @{
        @"originType" : @"origin_type",
        @"originId" : @"origin_id",
        @"belongType" : @"belong_type",
        @"belongId" : @"belong_id",
        @"mode" : @"ab_model",
        @"wrongTimes" : @"wrong_count",
    };
}

- (BOOL)modelCustomTransformFromDictionary:(NSDictionary *)dic {
    NSString *createTime = [dic valueForKey:@"create_time"];
    _addDate = [NSDate dateWithTimeIntervalSince1970:[createTime doubleValue] / 1000.0];
    NSString *updateTime = [dic valueForKey:@"update_time"];
    _updateDate = [NSDate dateWithTimeIntervalSince1970:[updateTime doubleValue] / 1000.0];
    return YES;
}

@end
