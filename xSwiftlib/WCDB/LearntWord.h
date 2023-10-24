#import <Foundation/Foundation.h>
#import "WordBase.h"
#import "Constants.h"


NS_ASSUME_NONNULL_BEGIN

/// 学过的单词。只有经过巩固流程的单词才是学过的单词，才能进复习表，所以也叫复习表单词
@interface LearntWord : WordBase

@property(nonatomic, assign) NSInteger aid;
@property(nonatomic, retain) NSDate *addDate;
/// 更新时间
@property(nonatomic, retain) NSDate *updateDate;

//  单词所属词书或词单
@property(nonatomic, retain) NSString *belongId;
@property(nonatomic, assign) WordBelong belongType;

// 上次复习时间，排序用
@property (nonatomic, strong) NSDate *knowLastDate;
// 下次复习时间，排序取词用
@property (nonatomic, strong, nullable) NSDate *knowNextDate;
// 遗忘速率
@property (nonatomic, assign) CGFloat dm;

/// 答题模式（单能、全能）
@property(nonatomic, assign) AbilityMode mode;

/// 总答错次数（累加）
@property(nonatomic, assign) NSInteger wrongTimes;
/// 认 答错次数（累加）
@property(nonatomic, assign) NSInteger knowWrongTimes;
/// 听 答错次数（累加）
@property(nonatomic, assign) NSInteger listenWrongTimes;
/// 说 答错次数（累加）
@property(nonatomic, assign) NSInteger speakWrongTimes;
/// 待测试能力维度
@property(nonatomic, assign) AbilityOption abilityOption;
/// 复习一轮里面的错次
@property(nonatomic, assign) NSInteger reviewWrongTimes;
/// 复习一轮里面的答次
@property(nonatomic, assign) NSInteger reviewAnswerTimes;
/// 记忆度分数 (实时计算)
@property(nonatomic, assign) CGFloat memoryScore;

/// v1.8.5 答题状态 二进制对应位为1则答过, 否则为未答
@property(nonatomic, assign) NSInteger examStatus;
/// v1.8.5 巩固答题是否完成, 数据库查询使用
@property(nonatomic, assign) BOOL examCompleted;
/// 标熟
@property(nonatomic, assign) MasterMarkOption masterOption;
/// 是否当前轮
@property(nonatomic, assign) BOOL isCurrentRound;
/// 主观题第一次选择结果
@property(nonatomic, assign) SubjectiveResult firstSubjectiveResult;
/// 精准复习答题状态
@property(nonatomic, assign) PreciseReviewExamState preciseReviewState;


@end

NS_ASSUME_NONNULL_END
