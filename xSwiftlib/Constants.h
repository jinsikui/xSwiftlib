#import <UIKit/UIKit.h>


#ifndef Constants_h
#define Constants_h

#define __abstract __attribute__((unavailable("abstract method")))

#pragma mark - Image url

#ifdef DEBUG

#define CONSOLE_LOG(frmt, ...) [QMUIConsole log:frmt, ##__VA_ARGS__];

#else

#define CONSOLE_LOG(frmt, ...) ;

#endif

#pragma mark - Constants

#if DEVELOP || STAGING
#define WM_APP_ID @"10008"
#define WM_LOGIN_CLIENT_ID @"wmzh880e7e4e317bec59"
#else
#define WM_APP_ID @"10006"
#define WM_LOGIN_CLIENT_ID @"wmzhfc227bfeed9e5c76"
#endif

#define WM_LOGIN_APP_ID @"2ab4d2a9097d4580a3e2921adc7e1682"
#define WM_LOGIN_KEY @"4f06425d04bc4633"

#define APP_STORE_APP_ID @"1464643633"

#define APP_Slogan_En @"THE Perfect Way to 10000"
//@"Perfect Word, Perfect World."

#define WECHAT_APP_ID @"wx9f636f1376e75862"

#define QQ_APP_ID @"101927018"

#define APP_Share_Scheme @"wanmeiwcw"

/// 发版时需要注意视频是否需要更新及更新名称
#define LAUNCH_INTRODUCTION_VIDEO @"introduce_video_2.0"

// 声通SDK key
#define ST_APP_KEY @"16311783350000a7"
#define ST_SECRET_KEY @"29323a705b2771c9837a3bf3b4cc8380"

/// 用户名长度限制
FOUNDATION_EXPORT NSUInteger const kUserNameLimit;

/// 词单的名称、简介长度
FOUNDATION_EXPORT NSUInteger const kWordCollectionNameLimit;
FOUNDATION_EXPORT NSUInteger const kWordCollectionDescLimit;

/*!
 * WCDB error code, 项目中已知用到的
 * 参考连接:
 * https://github.com/Tencent/wcdb/wiki/%E5%85%A8%E5%B1%80%E7%9B%91%E6%8E%A7%E4%B8%8E%E9%94%99%E8%AF%AF%E5%A4%84%E7%90%86
 */
#define WCDB_ERROR_CODE_DEAL_SQLITE_UNIQUE_CONSTRAINT 19

#pragma mark - Switch

#define SHOULD_PRELOAD_EXAMPLE_VIDEO NO

#pragma mark - key

#define LEXICON_WORD_MEAN @"means"
#define LEXICON_EXAMPLE_SENTENCE @"example_en"
#define LEXICON_EXAMPLE_TRANSLATE @"example_cn"
#define LEXICONV4_CNMEANING @"meaning_cn"
#define LEXICONV4_ENMEANING @"meaning_en"
#define LEXICONV4_PICURL @"pic_url"

#define Example_Type @"exampleType"

#define ACCOUNT_UUID @"uid"
#define ACCOUNT_TICKET @"ticket"

#pragma mark - 测试题型描述

#define DESC_ExamTypeReadingEnZh @"看单词选中文释义"
#define DESC_ExamTypeReadingZhEn @"看中文释义选单词"
#define DESC_ExamTypeListeningVoiceZh @"听音选中文释义"
#define DESC_ExamTypeWritingZhEn @"拼写单词"  // @"看中文写英文"
#define DESC_ExamTypeSenceImageWord @"看图选单词"
#define DESC_ExamTypeSenceWordImage @"看单词选图片"
#define DESC_ExamTypeSenceSentence @"拼写补全句子"
#define DESC_ExamTypeEnglishMeaningEn @"看词典英文释义选单词"
#define DESC_ExamTypeListeningEnWritingEn @"听写单词"
#define DESC_ExamTypeReadingZhSpeakingEn @"看中文释义说单词"

#define WORD_COLLECTION_DEFAULT_COVER @"word_collection_cover_001"

#define GUEST_MODE_USERDEFAULT @"guest_mode_userdefault"
#define WMLevelMarkStatusKey @"WMLevelMarkStatusKey"
#define WMReadingAssistantLevelMarkStatusKey \
    @"WMReadingAssistantLevelMarkStatusKey"  //助读器和阅读的点亮数据格式不同

#pragma mark -
#define FEEDBACK_PROBLEM_SUGGEST @"提个建议"
#define FEEDBACK_PROBLEM_FUNCTION @"功能异常"
#define FEEDBACK_PROBLEM_CONTENT @"内容反馈"
#define FEEDBACK_PROBLEM_OTHER @"其他反馈"

#pragma mark -
#define WMShareSlogan (@"好莱坞演员陪你背单词")

#pragma mark -

@class Inspiration;
@class SuperPlayerView;


#pragma mark - URL routers

/*-------------------------------------------------------预加载页----------------------------------------------------------*/
typedef NSString WMLearningPageFromType;
extern WMLearningPageFromType *const kWMLearningPageFromTypeStudy;
extern WMLearningPageFromType *const kWMLearningPageFromTypeReview;
extern WMLearningPageFromType *const kWMLearningPageFromTypeGYM;
/// path
extern NSString *const WMLearningPreLoading;
/// param
extern NSString *const WMLearningPreLoadingDelegate;
/// type  WMLearningPageFromType
extern NSString *const WMLearningPreLoadingType;

/*-------------------------------------------------------复习预加载页----------------------------------------------------------*/
/// path
extern NSString *const WMReviewPreLoading;
/// param
extern NSString *const WMReviewPreLoadingDelegate;

/*-------------------------------------------------------识记页----------------------------------------------------------*/
// path
extern NSString *const WMRememberPage;
/* param */
extern NSString *const WMRememberPageParamEngine;

extern NSString *const WMRememberPageParamShowGuideAnimation;

/*-------------------------------------------------------巩固页面----------------------------------------------------------*/
// path
extern NSString *const WMConsolidatePage;

/* param */
// BOOL
extern NSString *const WMExamPageParamHidePreviousWord;
// WordResourceDic
extern NSString *const WMExamPageParamWordResourceDic;
extern NSString *const WMExamPageParamViewModel;
extern NSString *const WMExamPageParamShowGuideAnimation;
extern NSString *const WMExamPageParamAdditionalRightWords;

/*------------------------------------------------------学习结果页面-----------------------------------------------------------*/
// path
extern NSString *const WMLearningResultPage;
extern NSString *const WMMemorizeConsolidateResultPage;
/* param */
//老版本结果页数据
extern NSString *const WMLearningResultPageParamEngine;
extern NSString *const WMLearningResultPageParamCumulativeWords;
extern NSString *const WMLearningResultPageParamCumulativeDays;

/*-------------------------------------------------------复习页----------------------------------------------------------*/
// path
extern NSString *const WMReviewPage;
/* param */
extern NSString *const WMReviewPageParamViewModel;

/*------------------------------------------------------练功房页面-----------------------------------------------------------*/
// path
extern NSString *const WMExerciseRoomPage;

/*------------------------------------------------------学习页面-----------------------------------------------------------*/
// path
extern NSString *const WMLearningPage;
/* param */
// WordBase
extern NSString *const WMLearningPageParamWord;
// NSString
extern NSString *const WMLearningPageParamBelongId;
// NSNumber
extern NSString *const WMLearningPageParamBelongType;
// BOOL
extern NSString *const WMLearningPageParamCanSwitchToNextWord;
// CloseOrNextWordButtonType
extern NSString *const WMLearningPageParamCloseOrNextWordButtonType;
/// BOOL needQueryCollectionStatus
extern NSString *const WMLearningPageParamNeedQueryCollectionStatus;
/// NSArray collectedList
extern NSString *const WMLearningPageParamCollectedList;
/// NSString
extern NSString *const WMLearningPageParamFromPage;
/// 学习页返回操作
extern NSString *const WMLearningPageParamShouldBackToHome;
/// 毛玻璃背景图
// UIImage
extern NSString *const WMLearningPageParamBlurEffectImage;
/// 背景图片是否是默认图
extern NSString *const WMLearningPageParamIsDefaultImage;
/// 是否需要展示答错提示
extern NSString *const WMLearningPageParamShouldDisplayWrongTips;
/// 是否隐藏下方关闭按钮  替换为展示在上方的nav中
extern NSString *const WMLearningPageParamShouldHideNextOperationButton;
/// 是否隐藏更多菜单中的退出学习按钮
extern NSString *const WMLearningPageParamShouldHideMoreMenuExitLearnItem;
///  词义卡navLayout样式
extern NSString *const WMLearningPageParamNavLayoutType;
/// disappear handle
extern NSString *const WMLearningPageParamDisappearHandle;
/// 是否需要展示切换美音男声提示
extern NSString *const WMLearningPageParamShouldDisplayChangeToUSManTips;
/// 是否使用系统/用户设定的主题
extern NSString *const WMLearningPageParamShouldUseSystemTheme;

/*------------------------------------------------------助记页面-----------------------------------------------------------*/
// path
extern NSString *const WMMnemonicsPage;
/* param */
// BookWord
extern NSString *const WMMnemonicsPageParamWord;
// NSString
extern NSString *const WMMnemonicsPageParamPageIndex;

/*------------------------------------------------------灵感视频预览页面-----------------------------------------------------------*/
// path
extern NSString *const WMInspirationVideoPreviewPage;
/* param */
// Inspiration
extern NSString *const WMInspirationVideoPreviewPageParamInspiration;
// SuperPlayerView
extern NSString *const WMInspirationVideoPreviewPageParamVideoPlayer;

/*------------------------------------------------------灵感图片预览页面-----------------------------------------------------------*/
// path
extern NSString *const WMInspirationPicPreviewPage;
/* param */
// Inspiration
extern NSString *const WMInspirationPicPreviewPageParamInspiration;

/*------------------------------------------------------灵感编辑页面-----------------------------------------------------------*/
// path
extern NSString *const WMEditInspirationPage;
/* param */
// BookWord
extern NSString *const WMEditInspirationPageParamWord;
// Inspiration
extern NSString *const WMEditInspirationPageParamMyInspiration;

/*------------------------------------------------------真人单词发音页面-----------------------------------------------------------*/
extern NSString *const WMPersonPronouncePageDelegateKey;
// path
extern NSString *const WMPersonWordPronouncePage;
/* param */
// WordResourceInfo
extern NSString *const WMPersonWordPronouncePageParamWordResourceInfo;
// BusinessSource
extern NSString *const WMPersonWordPronouncePageParamWordBusinessSource;

/*------------------------------------------------------真人例句发音页面-----------------------------------------------------------*/
// path
extern NSString *const WMPersonExamplePronouncePage;
/* param */
// WordResourceInfo
extern NSString *const WMPersonExamplePronouncePageParamWordResourceInfo;

/*------------------------------------------------------自由复习-----------------------------------------------------------*/
/// path
extern NSString *const  WMFreeReviewPage;
/// param
/// FreeReviewViewModel
extern NSString *const WMFreeReviewPageParamViewModel;
/// Ability
extern NSString *const WMFreeReviewPageParamFeedbackSource;

/*-----------------------------------------------------选择词书-----------------------------------------------------------*/

/*-----------------------------------------------------口语课-----------------------------------------------------------*/
/// 口语课首页
extern NSString *const WOCCourseListPage;
/// 口语课id
extern NSString *const WOCCourseListPageCourseId;
/// 指定跳转的tab
extern NSString *const WOCCourseListPageTab;

/*-----------------------------------------------------反馈&报错-----------------------------------------------------------*/
/// path
extern NSString *const WOCWordFeedbackPage;
/// param
extern NSString *const WOCWordFeedbackPageFeedbackId;

/// path
UIKIT_EXTERN NSString *const WMWordBookListPage;
/// param
UIKIT_EXTERN NSString *const WMWordBookListDelegate;
///  练功房 or 随身听 (``ExerciseRoomResourceSource``)
UIKIT_EXTERN NSString *const WMWordBookListSource;

#pragma mark - Notification

/// 获取视频权益后发送通知恢复视频播放
extern NSString *const kSceneModeResumePlayVideoNotification;
extern NSString *const WMExamPageDidAppearEventNotification;
extern NSString *const WMExamPageDidDisappearEventNotification;
extern NSString *const WMExamPageWillDisappearEventNotification;
extern NSString *const WMExamPageSpellAddKeyboardEventNotification;
extern NSString *const WMExamPageSpellRemoveKeyboardEventNotification;
extern NSString *const ExamPageNeedHidePopupNotification;
extern NSString *const ExerciseRoomResourceLoadingNotification;
extern NSString *const ExerciseRoomResourceLoadedNotification;
///  随身听开始加载资源
extern NSString *const ListenWordResourceLoadingNotification;
///  随身听资源加载完成
extern NSString *const ListenWordResourceLoadedNotification;

extern NSNotificationName const SwitchToNextWordNotification;                 /// 跳转到下一词
extern NSNotificationName const SpeakResultGuideDidShownNotification;
extern NSNotificationName const SpeakResultGuideDidHideNotification;
extern NSNotificationName const LeftWordListDidShownNotification;
extern NSNotificationName const LeftWordListDidHideNotification;

extern NSString *const DailyProgressDidResetNotification;
extern NSString *const LearningWordsImageDidFinishedPrepareNotification;      /// 准备图片
extern NSString *const ReviewWordsImageDidFinishedPrepareNotification;        /// 准备图片
extern NSString *const LearningWordsMnemonicsDidFinishedPrepareNotification;  /// 准备助记
extern NSString *const ReviewWordsMnemonicsDidFinishedPrepareNotification;    /// 准备助记

extern NSString *const ReadingDidTapWordNotification;
extern NSString *const ReadingDidNeedShowToolViewNotification;
extern NSString *const ReadingDidFinishNotification;
extern NSString *const ReadingPaginationDidFinishNotification;

extern NSString *const LoginForTokenFailureNotification;

extern NSString *const LearningRootViewDidBecomeVisibleNotification;  // 进入首页

extern NSString *const PlanSyncDidFinishedNotification;      // 计划同步完成通知
extern NSString *const PreloadResourceDidReadyNotification;  // 预装资源处理
extern NSString *const PlanSyncNoPlanNeededNotification;     // 没有计划需要同步
extern NSString *const DatabaseDidInitialNotification;

extern NSNotificationName const UserSettingDidNeedReportNotification;  // 上报用户设置

extern NSNotificationName const ReviewLimitCountDidChangedNotification; // 每轮复习词量改变

extern NSNotificationName const UserChangePraiseOfficialExampleNotification;  // 用户标记有用/取消标记有用PGC例句

extern NSNotificationName const
    LearningRootRefreshHotTagsNotification;  // 学习首页刷新“HOT” “NEW”标签通知
extern NSNotificationName const DeviceTokenDidRegisterNotification;  // 友盟注册设备token

extern NSNotificationName const WMFreeReviewDidAppearNotification;

extern NSNotificationName const WMFreeReviewWillAppearNotification;

extern NSNotificationName const WMReviewDidFinishGroupNotification;

/// 首页金刚区需要更新通知
extern NSNotificationName const WCWRootFunctionActionUpdateNofication;

/// 练功房资源更新通知
extern NSNotificationName const ExerciseWordsSourceDidChangedNotification;

#pragma mark - Typedef

/// 获取当前组可复习词为空时处理策略
typedef NS_ENUM(NSUInteger, ReviewGroupEmptyStrategy) {
    ReviewGroupEmptyStrategyReturn = 0,             // 反悔空数组
    ReviewGroupEmptyStrategyAutoNextGroup = 1,      // 自动加载当前轮的下一组
    ReviewGroupEmptyStrategyAutoNextGroupOrRound    // 自动加载当前轮或下一轮（如果当前轮已完成）的下一组
};

/// 速记卡事件
typedef NS_ENUM(NSUInteger, WordCardViewEvent) {
    WordCardViewEventGoNext = 0,        // 下一词
    WordCardViewEventRememberWrong = 1, // 记错了
};

/// 复习模式
typedef NS_ENUM(NSUInteger, ReviewMode) {
    ReviewModeNoDecision = 0,    // 旧版本 = 自由模式
    ReviewModeFreedom = 1,     // 自由模式
    ReviewModePrecise = 2,      // 精准复习
};

/// 复习流程类型
typedef NS_ENUM(NSUInteger, ReviewType) {
    ReviewTypeNormal,      // 正常复习
    ReviewTypeChallenge,   // 挑战
    ReviewTypeAhead,       // 提前复习
    ReviewTypeAgain,       // 再复习一遍
};

/// 复习阶段
typedef NS_ENUM(NSUInteger, ReviewStage) {
    ReviewStageNormal,      // 正常复习
    ReviewStageAhead,       // 提前复习/挑战
    ReviewStageEmpty,       // 复习表无数据
};

/// 精准复习答题状态
typedef NS_ENUM(NSUInteger, PreciseReviewExamState) {
    PreciseReviewExamStateFirstSubjectiveExam,  // 第一次做主观题
    PreciseReviewExamStateNotSureExam,          // 选择模糊后出第一题
    PreciseReviewExamStateForgottenFirstExam,   // 选择忘记后第一题
    PreciseReviewExamStateForgottenSecondExam,  // 选择忘记后第二题
    PreciseReviewExamStateLastSubjective,       // 第二次做主观题
    PreciseReviewExamStateFinished,             // 第二次做主观题选认识
};

/// 主观题选择的结果
typedef NS_ENUM(NSUInteger, SubjectiveResult) {
    SubjectiveResultNone,       // 未选
    SubjectiveResultKnown,      // 认识
    SubjectiveResultNotSure,    // 模糊
    SubjectiveResultForgotten,  // 忘记
    SubjectiveResultKnownToForgotten,     // 认识 -> 记错了
    SubjectiveResultNotSureToForgotten,   // 模糊 -> 记错了
};


typedef NS_ENUM(NSUInteger, CloseOrNextWordButtonType) {
  CloseOrNextWordButtonTypeClose,
  CloseOrNextWordButtonTypeNext,
};

typedef NS_ENUM(NSUInteger, WordDetailNavigationLayoutType) {
  WordDetailNavigationLayoutTypeNormal,                 // 正常词义卡
  WordDetailNavigationLayoutTypeReplaceDictionaryPage,  // 替换词典详情页的词义卡，上方带有返回按钮
};

typedef NS_ENUM(NSUInteger, ExamSettingEnumType) {
  ExamSettingEnumTypeObfuscated = 0,
  ExamSettingEnumTypeThinkMode,
  ExamSettingEnumTypeQuestionTypeSetting,
  ExamSettingEnumTypeReviewSetting,
};

// 是否开启左滑列表功能
typedef NS_ENUM(NSUInteger, WordListFunctionDecision) {
    ///  还未确定是否开启左滑列表
    WordListFunctionDecisionNone,
    ///  开启左滑列表
    WordListFunctionDecisionEnabled,
    ///  关闭左滑列表
    WordListFunctionDecisionDisabled
};


// 单词列表显示模式
typedef NS_ENUM(NSUInteger, SummaryWordDisplayType) {
    ///  只展示英文
    SummaryWordDisplayEn,
    ///  只展示中文
    SummaryWordDisplayCHS,
    ///  中英文都展示
    SummaryWordDisplayAll
};

///  单词显示格式图标类型
typedef enum : NSUInteger {
    ///  普通的, 用于在PopMenuView中展示
    LearningSummaryIconNormal,
    ///  选中的, 用于在PopMenuView中展示
    LearningSummaryIconSelected,
    ///  加粗的, 用于 NavigationBar 展示
    LearningSummaryIconBold,
} LearningSummaryIconType;

typedef enum : NSUInteger {
    RootViewTabTypeOfLearning,         // 学习tab
    RootViewTabTypeOfSpokenTraning,    // 练口语tab
    RootViewTabTypeOfClass,            // 课程tab
    RootViewTabTypeOfReadningLearning, // 英美镇tab
    
    RootViewTabHome = RootViewTabTypeOfLearning, // 首页
} RootViewTabType;

FOUNDATION_EXTERN NSInteger const kDefaultTagId;

typedef void (^CommonCompletion)(void);

/// 新用户进入首页的状态
typedef NS_ENUM(NSUInteger, NewUserEnterStatus) {
    NewUserEnterStatusPlanSuccess,  /// 制定计划成功
    NewUserEnterStatusPlanFail,     /// 制定计划失败
    NewUserEnterStatusServerError,  /// 服务器错误,误认为是新用户
    NewUserEnterStatusIgnore,       /// 忽略新用户状态不需要处理
};

typedef NS_ENUM(NSUInteger, WordSortType) {
    WordSortTypeDefault,
    WordSortTypeLetterAsc,
    WordSortTypeLetterDesc,
    WordSortTypeTimeAsc,
    WordSortTypeTimeDesc,
    WordSortTypeStarAsc,
    WordSortTypeStarDesc,
    /// 掌握度
    WordSortTypeMasterRateAsc,
    WordSortTypeMasterRateDesc,
    /// 错误次数
    WordSortTypeWrongCountAsc,
    WordSortTypeWrongCountDesc,
    WordSortTypeCollectionTimeDes,
};

extern BOOL IsWordSortByLetter(WordSortType type);
extern BOOL IsWordSortByTime(WordSortType type);
BOOL IsWordSortByWrongCount(WordSortType type);
BOOL IsWordSortByMasterRate(WordSortType type);

/// 首页计划数量
typedef NS_ENUM(NSUInteger, LearningPlanStyle) {
    LearningPlanSingle,
    LearningPlanMulti,
    LearningPlanNone
};

/// 首页无计划情况
typedef NS_ENUM(NSUInteger, NoPlanType) {
    NoPlanTypeNoData,
    NoPlanTypeNoPlan,
    NoPlanTypeNoBookPlan,
};

/// 根据掌握度返回 掌握度等级
/// [0, 0.25)       0
/// [0.25, 0.5)    1
/// [0.5, 0.75)    2
/// [0.75, 1]       3
/// @param masterRate 掌握度 [0, 1]
NSInteger LevelOfMasterRate(CGFloat masterRate);

/// 单词的掌握度是否相似
BOOL IsMasterRateSimilar(CGFloat rate1, CGFloat rate2);

/// 训练模式
typedef NS_ENUM(NSUInteger, AbilityMode) {
    AbilityModeSingle = 1,  // 单一模式
    AbilityModeAll = 4,     // 全能模式
};

typedef NS_ENUM(NSInteger, AbilityModeScope) {
    /// 未学单词
    AbilityModeScopeNotLearn,
    /// 全部单词
    AbilityModeScopeAllWords
};

typedef NS_ENUM(NSInteger, MasteredFilterScope) {
    /// 过滤认掌握
    MasteredFilterScopeKnowAbility = 1,
    /// 过滤全掌握
    MasteredFilterScopeAllAbility = 2,
};

/// 能力类型
typedef NS_ENUM(NSUInteger, AbilityType) {
    AbilityTypeKnow = 0,    // 认
    AbilityTypeListen = 1,  // 听
    AbilityTypeSpeak = 2,   // 说
};

typedef NS_OPTIONS(NSUInteger, AbilityOption) {
    AbilityOptionNone = 0,
    AbilityOptionKnow = 1 << AbilityTypeKnow,
    AbilityOptionListen = 1 << AbilityTypeListen,
    AbilityOptionSpeak = 1 << AbilityTypeSpeak,
    AbilityOptionAll = AbilityOptionKnow | AbilityOptionListen | AbilityOptionSpeak,
};

/// 标熟类型
typedef NS_OPTIONS(NSUInteger, MasterMarkOption) {
    MasterMarkNone = 0,
    MasterMarkKnown = 1 << 0,                                             // 认熟
    MasterMarkListen = 1 << 1,                                            // 听熟
    MasterMarkSpeak = 1 << 2,                                             // 说熟
    MasterMarkAll = MasterMarkKnown | MasterMarkListen | MasterMarkSpeak  // 全熟
};

typedef NS_ENUM(NSUInteger, ExamType) {
    ExamTypeReadingEnZh,           // 看英文选中文
    ExamTypeReadingZhEn,           // 看中文选英文
    ExamTypeListeningVoiceZh,      // 听发音选中文
    ExamTypeWritingZhEn,           // 看中文写英文
    ExamTypeSenceImageWord,        // 看图片选单词
    ExamTypeSenceWordImage,        // 看单词选图片
    ExamTypeSenceSentence,         // 拼写补全句子
    ExamTypeEnglishMeaningEn,      // 看词典英文释义选单词
    ExamTypeListeningEnWritingEn,  // 听英文写单词
    ExamTypeReadingZhSpeakingEn,   // 看中文说英文(跟读单词)
    ExamTypeReadingSentenceEn,     // 跟读句子
    ExamTypeSpeakZhEn,             // 看中文释义说单词
    ExamTypeSentenceWordChooseChineseMeaning, // 例句训练：英选中
    ExamTypeSentenceChineseMeaningChooseWord, // 例句训练：中选英
    ExamTypeSubjectiveItem         // 主观题(精准复习)
};

typedef NS_OPTIONS(NSUInteger, OptionExamType) {
    OptionExamTypeReadingEnZh = 1 << ExamTypeReadingEnZh,            // 看单词选中文
    OptionExamTypeReadingZhEn = 1 << ExamTypeReadingZhEn,            // 看中文选单词
    OptionExamTypeListeningVoiceZh = 1 << ExamTypeListeningVoiceZh,  // 听发音选中文
    OptionExamTypeWritingZhEn = 1 << ExamTypeWritingZhEn,            // 看中文写英文
    OptionExamTypeSenceImageWord = 1 << ExamTypeSenceImageWord,      // 看图片选单词
    OptionExamTypeSenceWordImage = 1 << ExamTypeSenceWordImage,      // 看单词选图片
    OptionExamTypeSenceSentence = 1 << ExamTypeSenceSentence,        // 拼写补全句子
    OptionExamTypeEnglishMeaningEn = 1 << ExamTypeEnglishMeaningEn,  // 看词典英文释义选单词 -> 完形填空
    OptionExamTypeListeningEnWritingEn = 1 << ExamTypeListeningEnWritingEn,  // 听英文写单词
    OptionExamTypeReadingZhSpeakingEn = 1 << ExamTypeReadingZhSpeakingEn,  // 看中文说英文 -> 跟读单词
    OptionExamTypeReadingSentenceEn = 1 << ExamTypeReadingSentenceEn,  // 跟读句子
    OptionExamTypeSpeakZhEn = 1 << ExamTypeSpeakZhEn,                  // 看中文释义说单词
    OptionExamTypeSentenceWordChooseChineseMeaning = 1 << ExamTypeSentenceWordChooseChineseMeaning,
    OptionExamTypeSentenceChineseMeaningChooseWord = 1 << ExamTypeSentenceChineseMeaningChooseWord,

    OptionExamTypeAll = OptionExamTypeReadingEnZh |          // 看单词选中文
                        OptionExamTypeReadingZhEn |          // 看中文选单词
                        OptionExamTypeListeningVoiceZh |     // 听发音选中文
                        OptionExamTypeEnglishMeaningEn |     // 看词典英文释义选单词
                        OptionExamTypeReadingZhSpeakingEn |  // 看中文说英文
                        OptionExamTypeWritingZhEn |          // 看中文写英文
                        OptionExamTypeReadingSentenceEn,     // 跟读句子
};

typedef NS_ENUM(NSUInteger, SentenceExamType) {
    SentenceExamWordChooseChineseMeaning = 10,
    SentenceExamChineseMeaningChooseWord = 20,
};

typedef NS_ENUM(NSUInteger, QuestionModeType) {
    QuestionModeNone = 0,
    QuestionModeDefault = 1,  // 全做已选题模式（默认）
    QuestionModeAll = QuestionModeDefault,
    QuestionModeRandom = 2,  // 随机一道题模式
};

typedef NS_ENUM(NSInteger, ExamPageType) {
    ExamPageTypeConsolidate,
    ExamPageTypeReview,
    ExamPageTypeFreeReview
};

typedef NS_ENUM(NSInteger, PronounceType) {
    PronounceTypeUSAMale = 0,
    PronounceTypeUSAFemale = 1,
    PronounceTypeUKMale = 2,
    PronounceTypeUKFemale = 3
};

typedef NS_ENUM(NSInteger, AutoPronounceStatus) {
    AutoPronounceStatusOpen = 1,
    AutoPronounceStatusClose = 2
};

typedef NS_ENUM(NSInteger, JustReviewCurrentPlanStatus) {
    JustReviewCurrentPlanStatusOpen = 1,
    JustReviewCurrentPlanStatusClose = 2
};

typedef NS_ENUM(NSUInteger, PronunciationType) {
    ENPronunciation,  // 英式发音
    USPronunciation,  // 美式发音
    CNPronunciation,  // 中文发音
};

typedef NS_ENUM(NSUInteger, TaskSource) { TaskSourceLearning, TaskSourceReview };

typedef NS_ENUM(NSUInteger, ExamSource) { ExamSourceLearning, ExamSourceReview };

typedef NS_ENUM(NSUInteger, PrepareSource) { PrepareSourceLearning, PrepareSourceReview };

typedef NS_ENUM(NSUInteger, TaskResult) { TaskResultUnknow, TaskResultSuccess, TaskResultFailed };

typedef NS_ENUM(NSUInteger, AccountBookStatus) {
    AccountBookStatusUnparsed,  // 未解析
    AccountBookStatusParsing,   // 正在解析
    AccountBookStatusParsed,    // 已解析
    AccountBookStatusPaused,    // 解析暂停
};

typedef NS_ENUM(NSUInteger, AccountBookDownLoadStatus) {
    AccountBookUnDownLoad,      // 未下载
    AccountBookDownLoading,     // 正在下载
    AccountBookDownLoaded,      // 已下载
    AccountBookDownLoadPaused,  // 暂停下载
};

/**
 ["ʃ","̃","ʊ","​","ʌ","，","ʒ"," "," ","\"","ʤ","\u0027","ʧ","(",")",",","̬","-",".","/","0","1","2","3","ʳ","4","5","6","7","8","θ","9",":","ˈ","ŋ","ˌ","ː","ɑ","ɒ","ɔ","ə","ә","ɚ","[","ɛ","ɜ","]","ɝ","a","ɡ","b","c","d","e","f","æ","g","h","i","ɪ","j","k","l","m","n","o","p","ð","r","s","t","u","v","w","x","y","z","{","}"]
 */

typedef NS_OPTIONS(NSInteger, OptionWordFilterType) {

    OptionWordFilterNone = 0,
    OptionWordFilterMaster = 1 << 0,      // 已掌握
    OptionWordFilterStudy = 1 << 1,       // 要学习
    OptionWordFilterReview = 1 << 2,      // 要复习
    OptionWordFilterMarkMaster = 1 << 3,  // 已标熟
    OptionWordFilterTotal = 1 << 8,       // 全部

    OptionWordFilterAll = OptionWordFilterMaster | OptionWordFilterStudy | OptionWordFilterReview |
                          OptionWordFilterMarkMaster,
    // 今日回顾过滤条件
    OptionWordFilterTodayLearning = 1 << 9,   // 今日已学
    OptionWordFilterTodayReviewed = 1 << 10,  // 今日已复习
};

typedef NS_OPTIONS(NSInteger, OptionWordFilterMemoryScoreType) {
  OptionWordFilterMemoryScoreTypeNone = 0,
  /// 基本认识
  OptionWordFilterMemoryScoreTypeKnow = 1 << 0,
  /// 即将遗忘
  OptionWordFilterMemoryScoreTypeWillForget = 1 << 1,
  /// 复习逾期
  OptionWordFilterMemoryScoreTypeReviewOverdue = 1 << 2,
  /// 经常出错
  OptionWordFilterMemoryScoreTypeMistakesOften = 1 << 3,
  /// 未学单词
  OptionWordFilterMemoryScoreTypeUnlearn = 1 << 4,
  
  OptionWordFilterMemoryScoreTypeAll = OptionWordFilterMemoryScoreTypeKnow | OptionWordFilterMemoryScoreTypeWillForget|
                                       OptionWordFilterMemoryScoreTypeReviewOverdue |
                                       OptionWordFilterMemoryScoreTypeMistakesOften |
                                       OptionWordFilterMemoryScoreTypeUnlearn,
};

typedef NS_OPTIONS(NSInteger, OptionWordFilterMasterType) {
  OptionWordFilterMasterTypeNone = 0,
  /// 标熟
  OptionWordFilterMasterTypeMarkMaster = 1 << 0,
  /// 学熟
  OptionWordFilterMasterTypeLearnMaster = 1 << 1,
};

typedef NS_OPTIONS(NSInteger, WordMemoryScoreType) {
  WordMemoryScoreTypeNone,
  WordMemoryScoreTypeUnlearn,
  WordMemoryScoreTypeMistakesOften,
  WordMemoryScoreTypeReviewOverdue,
  WordMemoryScoreTypeWillForget,
  WordMemoryScoreTypeKnow,
};

/// 单词星标等级
typedef NS_OPTIONS(NSInteger, OptionWordStarLevelType) {
    OptionWordStarLevelNone = 1 << 0,   // 0    1
    OptionWordStarLevelOne = 1 << 1,    // 1    2
    OptionWordStarLevelTwo = 1 << 2,    // 2    4
    OptionWordStarLevelThree = 1 << 3,  // 3    8
    OptionWordStarLevelFour = 1 << 4,   // 4    16
    OptionWordStarLevelFive = 1 << 5,   // 5    24

    OptionWordStarLevelAll = OptionWordStarLevelNone | OptionWordStarLevelOne |
                             OptionWordStarLevelTwo | OptionWordStarLevelThree |
                             OptionWordStarLevelFour | OptionWordStarLevelFive,
};

/// 词单类型
typedef NS_ENUM(NSInteger, WordCollectionType) {
    /// 用户创建词单
    WordCollectionUserCreate = 1,
    /// 生词本
    WordCollectionNewWord = 2,
    /// 星标词单 3
    WordCollectionStar = 3,
    /// 不背词单
    WordCollectionNotStudy = 4,
};

typedef NS_ENUM(NSUInteger, WordCollectionOperationType) {
    /// 无任何操作
    WordCollectionOperationNone,
    /// 导入单词
    WordCollectionOperationImport,
    /// 筛除单词
    WordCollectionOperationMinus,
    /// 复制单词到指定词单
    WordCollectionOperationCopy,
    /// 批量操作
    WordCollectionOperationBatch,
    /// 单词留重
    WordCollectionOperationSaveIntersect,
    /// 单词添加为熟词
    WordOperationAddToMasterLibrary,
    /// 极速刷词
    WordOperationImmersedExercise,
};

/// 识记学习的顺序
// typedef NS_ENUM(NSUInteger, LearningOrder) {
//    LearningOrderAlphabetASC,
//    LearningOrderAlphabetDESC,
//    LearningOrderTimeASC,
//    LearningOrderTimeDESC,
//    LearningOrderRandom,
//    LearningOrderDefault
//};

/// 当前识记的类型词书或词单
typedef NS_ENUM(NSUInteger, LearningType) {
    LearningTypeWordBook,
    LearningTypeWordCollection,
    LearningTypeWordMore,
};

typedef NS_ENUM(NSUInteger, LearningStage) {

    LearningStageRemember,
    LearningStageExam,
    LearningStageFinished,
};

/// 下载任务类型
typedef NS_ENUM(NSUInteger, DownloadTaskType) {
    DownloadTaskWordBook = 1,
    DownloadTaskWordAudio = 2,
    DownloadTaskLexiconPatch = 3,
};

typedef NS_ENUM(NSUInteger, UserGenderType) {
    UserGenderUnknown = 0,
    UserGenderMale = 1,
    UserGenderFemale = 2,
    UserGenderSecret = 3,
};

typedef NS_ENUM(NSInteger, PersonalEditCellPlaceholderType) {

    PersonalEditCellPlaceholderTypeNoSet,
    PersonalEditCellPlaceholderTypeOptional,
    PersonalEditCellPlaceholderTypeOptionalEmail,
    PersonalEditCellPlaceholderTypeDeclaration,
};

typedef NS_ENUM(NSInteger, PersonalEditRspCodeType) {
    PersonalEditRspCodeSuccess = 0,                //保存成功
    PersonalEditRspCodeTypeNickNonUniqueness = 7,  //昵称不唯一 已存在
    PersonalEditRspCodeNickSensitive = 8,          //昵称有违禁字符
    PersonalEditRspCodeCarerrSensitive = 84,       //职业 敏感词
    PersonalEditRspCodeNickCarerrSensitive = 9,    //职业和昵称同时都敏感
};

typedef NS_ENUM(NSInteger, GuestModeType) {
    GuestModeUseable = 1,    //游客模式可用
    GuestModeUnuseable = 2,  //游客模式不可用
};

//阅读详情页点亮界面枚举
typedef NS_ENUM(NSInteger, WMLevelMarkStatus) {
    WMLevelMarkStatus_seniorHigh = 1,  // 高中按钮选中情况  0 未选中
    WMLevelMarkStatus_cet4 = 1 << 1,   // 四级按钮选中情况
    WMLevelMarkStatus_cet6 = 1 << 2,
    WMLevelMarkStatus_postgraduate = 1 << 3,
    WMLevelMarkStatus_goAbroad = 1 << 4,
    WMLevelMarkStatus_familiar = 1 << 5,
    WMLevelMarkStatus_recite = 1 << 6,
    WMLevelMarkStatus_guessNotFamiliar = 1 << 7,
    WMLevelMarkStatus_translate = 1 << 8,
    WMLevelMarkStatus_frequency = 1 << 9,
};

typedef NS_ENUM(NSInteger, ReadingLearningBottomToolsState) {
    ReadingLearningBottomToolsStateOrigin,   //初始状态 (不带有动画)
    ReadingLearningBottomToolsStateDefautl,  //默认状态 （带有动画）
    ReadingLearningBottomToolsStateFull,     //逻辑最全状态
    ReadingLearningBottomToolsStateDetail,   //详细状态
    ReadingLearningBottomToolsStateHidden    //全隐藏状态
};

typedef NS_ENUM(NSUInteger, ReadingLearningPanDerection) {
    ReadingLearningPanDerectionHorizontal = 1 << 0,  // 水平
    ReadingLearningPanDerectionVertical = 1 << 1,    // 竖直
};

typedef NS_ENUM(NSUInteger, PersonalInformationEditType) {
    PersonalInformationEditTypeNickName,     //昵称
    PersonalInformationEditTypeProfession,   //职业
    PersonalInformationEditTypeDeclaration,  //宣言
};

typedef NS_ENUM(NSUInteger, PersonalUserDataConfigEditType) {
    PersonalUserDataConfigEditeMoreStudy,       //加量学习
    PersonalUserDataConfigEditReviewLimit,      //复习上限
    PersonalUserDataConfigEditFreeReviewLimit,  //自由复习上限
    PersonalUserDataConfigEditPushOnOff         //背词提醒开关
};

typedef NS_ENUM(NSUInteger, LearningResultPageType) {
    LearningResultPageTypeLearn = 1,  //学习结果页
    LearningResultPageTypeReview,  //复习结果页
    LearningResultPageTypeOralReport, //口语报告结果页
};

typedef NS_ENUM(NSInteger, FloatingStatus) {
    FloatingStatusRight,
    FloatingStatusLeft,
    FloatingStatusDraging,
    FloatingStatusMoving,
    FloatingStatusStatic  //静止
};

// FIXME: 枚举的名字叫的不准确
/// 结果页 按钮样式
typedef NS_ENUM(NSInteger, ResultPageReviewBtnType) {
    ResultPageReviewBtnTypeBeginReview,  //开始复习
    ResultPageReviewBtnTypeMoreReview,   //更多复习
    ResultPageReviewBtnTypeDoneReview,   //完成复习
    ResultPageReviewBtnTypeBeginStudy    //开始学习
};

/// LifelongWordLogTrackController列表页数据源类型
typedef NS_ENUM(NSInteger, AnkiLogSourceType) {
    AnkiLogSourceTypeService,          // log数据来自服务器
    AnkiLogSourceTypeLocalAndService,  // log数据来自本地和服务器集合
};

// 结果页继续操作类型
typedef NS_ENUM(NSInteger, ResultPageContinueOperationType) {
    ResultPageContinueOperationTypeToReview,  //开始复习，继续学习操作
    ResultPageContinueOperationTypeToStudy,   //开始学习操作
};

// URL助读器服务器操作结果
typedef NS_ENUM(NSInteger, ReadingAssistantURLSerivceDealResultType) {
    ReadingAssistantURLSerivceDealResultTypSuccess = 1,        //解析成功
    ReadingAssistantURLSerivceDealResultTypeFailure = 2,       //解析失败
    ReadingAssistantURLSerivceDealResultTypeTimeOut = 3,       //解析超时
    ReadingAssistantURLSerivceDealResultTypeRequestError = 4,  //请求错误
};

/// 用户意见反馈图片cell类型
typedef NS_ENUM(NSUInteger, FeedbackImageCellType) {
    FeedbackImageTypeImage,
    FeedbackImageTypeAdd,
};

typedef NS_ENUM(NSInteger, MemorizeWordMasterOperationType) {
    MemorizeWordMaster,      // 熟
    MemorizeWordknowMaster,  // 认熟
};

typedef NS_ENUM(NSUInteger, SpeakLevelType) {
    SpeakLevelStandard,
    SpeakLevelMiddle,
    SpeakLevelAdvanced,
    SpeakLevelRandom
};

typedef NS_ENUM(NSUInteger, ReadingArticleLevel) {
    ReadingAritcleLevelL1,
    ReadingAritcleLevelL2,
    ReadingAritcleLevelL3,
    ReadingAritcleLevelL4,
    ReadingAritcleLevelL5,
    ReadingAritcleLevelL6,
    ReadingAritcleLevelL7,
    ReadingAritcleLevelL8,
    ReadingAritcleLevelL9,
    ReadingAritcleLevelL10,
};

typedef NS_ENUM(NSUInteger, MarkMasterOperationType) {
    MarkMasterOperation,
    MarkKnwonMasterOperation,
    CancelMarkMasterOperation,
    CancelMarkKnwonMasterOperation,
};

typedef NS_ENUM(NSUInteger, MemorizeSceneModeType) {
    MemorizeSceneModeTypeScene,  // 实景学
    MemorizeSceneModeTypeFast,   // 极速学
};

typedef NS_ENUM(NSUInteger, AdviceFeedBackType) {
    AdviceFeedBackTypeSuggest = 1,  // 提个建议
    AdviceFeedBackTypeFunction,     // 功能异常
    AdviceFeedBackTypeContent,      // 内容反馈
    AdviceFeedBackTypeOther,        // 其他反馈
};

typedef NS_ENUM(NSUInteger, FeedbackContentSource) {

    FeedbackContentSourceWordPage = 1,         //词义卡
    FeedbackContentSourceDicPage = 2,          //词典详情页
    FeedbackContentSourceTestPage = 3,         //入门测
    FeedbackContentSourceReviewPage = 4,       //复习答题页
    FeedbackContentSourceListenPage = 5,       //听单词
    FeedbackContentSourcePersonCenter = 6,     //个人中心
    FeedbackContentSourceGYMKnowPage = 7,      //练功房认题型
    FeedbackContentSourceGYMListenPage = 8,    //练功房听题型
    FeedbackContentSourceGYMSpeakingPage = 9,  //练功房说题型
    FeedbackContentSourceGYMSpellPage = 10,    //练功房拼写题
    FeedbackContentSourceGYMAllPage = 11,      //练功房所有题型
    FeedbackContentSourceVideoRightRecommend = 12,     // 种草
    FeedbackContentSourceGYMCorrectPronunciation = 13, // 练功房 跟读纠音
    // v208题型对应
    FeedbackContentSourceGYMCnEn = 14,    // 练功房看中文选单词
    FeedbackContentSourceGYMEnCn = 15,    // 练功房看单词选中文
    FeedbackContentSourceGYMEnMeanEn = 16,// 练功房柯林斯释义选单词
    FeedbackContentSourceGYMSpell = 17,   // 练功房拼写单词
    FeedbackContentSourceGYMListen = 18,  // 练功房听单词选中文
    FeedbackContentSourceGYMSpeak = 19,   // 练功房看中文说单词
    FeedbackContentSourceGYMRealExam = 20,   // 练功房看真题例句
};

/// 单词详情页
typedef NS_ENUM(NSUInteger, WordMeaningSectionType) {
    WordMeaningSectionTypeBasic,
    WordMeaningSectionTypeTransform,
    WordMeaningSectionTypeMnemonics,
    WordMeaningSectionTypeExplain,
    WordMeaningSectionTypeWordBelong,
    WordMeaningSectionTypeTags,
    WordMeaningSectionTypeRelevanceWallHeader,
    WordMeaningSectionTypeRelevance,
    WordMeaningSectionTypeRelevanceNull,
    WordMeaningSectionTypeNetworkWarning,
};

/// 例句类型
// (int32,required)例句类型: 短例句(1), 真题例句(2),  经典例句(4), 实用场景例句(6), 图配文-20 (离线数据，暂时没有接口返回)，视频-21(视频例句接口返回)
typedef NS_ENUM(NSUInteger, ExampleType) {
    ExampleShort = 1,       // 短例句
    ExampleReal = 2,        // 真题例句
    ExampleLexicon = 3,     // 词典例句
    ExampleChoiceness = 4,  // 精选例句
    ExampleVideo = 5,       // 视频例句
    ExamplePracticalScene = 6, // 实用场景例句
    ExampleImage = 20,      // 图配文例句
    ExampleColinsDerivative = 999,  //柯林斯派生词例句——客户端本地使用，非服务器定义
};


typedef NS_ENUM (NSInteger, MemoryScopeNameTag){
    MemoryScopeNameTagRed,
    MemoryScopeNameTagYellow,
    MemoryScopeNameTagGreen
};

typedef struct MemoryValueMapInfo{
    MemoryScopeNameTag tag;
    NSString *colorHex;
} MemoryValueMapItem;

typedef enum : NSUInteger {
  CorrectPronunciationContentTypeWord,
  CorrectPronunciationContentTypeSentence,
} CorrectPronunciationContentType;

#pragma mark - method
#ifdef __cplusplus
extern "C" {
#endif
/// 获取 HTTP 请求中的错误信息描述
NSString *getHttpErrorMessage(NSError *error);

/// 根据 测试类型 返回该类型的描述信息
NSString *getDescriptionWithExamType(OptionExamType type);

/// 返回 V4版本测试7种题型
NSArray<NSNumber *> *getAllV4OptionExamTypes(void);

/// 题型日志上报
NSString *examTypeLogString(OptionExamType optionExamType);

/// 将 option 类型的 ExamType 转为 ExamType 数组
NSArray<NSNumber *> *convertOptionExamTypeToExamTypes(OptionExamType optionExamType);

/// 将 ExamType 类型转化为 OptionExamType 类型。
OptionExamType convertExamTypeToOptionType(ExamType examType);

/// 真题例句练习：ExamType ->  SentenceExamType
SentenceExamType examTypeToSentenceExamType(ExamType examType);
/// 真题例句练习：SentenceExamType ->  ExamType
ExamType sentenceExamTypeToExamType(SentenceExamType sentenceExamType);
/// 真题例句练习：ExamType默认题型替换
ExamType replaceExamTypeForSentenceExam(ExamType examType);

/// 是否是例句练习
BOOL isSentenceExam(ExamType examType);

/// 例句类型 不带“#”
NSString *exampleTypeName(ExampleType exampleType);

/// ExamType 所属能力类型
AbilityType abilityTypeWithExamType(ExamType examType);
#ifdef __cplusplus
}
#endif


/// 埋点
NSString * statisticSourcePage(ExamPageType pageType);
NSInteger statisticNumberOfExam(ExamType examType);


#pragma mark - WordConstants.h

typedef NS_ENUM(NSUInteger, LearningWordOperation) {
  LearningWordUnlearn = 0,      // 初始状态，还未学习
  LearningWordMaster = 1,       // 熟
  LearningWordKnownMaster = 2,  // 认熟
  LearningWordKnown = 3,        // 认识
  LearningWordUnKnown = 4,      // 陌生
};

/// 学习、巩固、复习 标识上一次的操作状态
typedef NS_ENUM(NSUInteger, WordLastOperation) {
  WordLastOperationUnlearn = LearningWordUnlearn,          // 初始状态，还未学习
  WordLastOperationMaster = LearningWordMaster,            // 熟
  WordLastOperationKnownMaster = LearningWordKnownMaster,  // 认熟
  WordLastOperationKnown = LearningWordKnown,              // 认识
  WordLastOperationUnKnown = LearningWordUnKnown,          // 陌生
  WordLastOperationRight = 5,
  WordLastOperationWrong = 6,
};

NSString* previousWordOperationDesctiption(WordLastOperation operation);

typedef NS_ENUM(NSUInteger, ExamResult) { ExamResultUndone = 0, ExamResultRight = 1, ExamResultWrong = 2 };

/// 字典类型的来源 id，目前没有用到，写死为 “1”
#define DICTIONARY_ORIGIN_ID @"1"

typedef NS_ENUM(NSUInteger, WordOriginType) {
  WordOriginWordBook = 1,
  WordOriginAccountReading = 2,
  WordOriginDictionary = 5,
};

/// 正在学习中的单词属于词书还是生词表，影响单词计数
typedef NS_ENUM(NSUInteger, WordBelong) {

  WordBelongMastered = 0,
  WordBelongWordBook = WordOriginWordBook,  // 词书
  WordBelongWordCollection = 3,             // 词单
  WordBelongNil = 9999,  // 未知
};

typedef NS_ENUM(NSUInteger, LearningOrder) {
  LearningOrderDefault = 0,
  LearningOrderTimeDESC = 1,
  LearningOrderTimeASC = 2,
  LearningOrderAlphabetDESC = 3,
  LearningOrderAlphabetASC = 4,
  LearningOrderRandom = 5,
};

/// 记录学习记录来自每日计划还是再学一组
typedef NS_ENUM(NSUInteger, LearningRecordType) {
  LearningRecordDailyPlan,
  LearningRecordDailyMore,
};

typedef NS_ENUM(NSUInteger, LearningDailyStatus) {
  LearningDailyGoing,
  LearningDailyFinished,
};


#pragma mark - NotificationConstant.h
/**
 * 词义卡可以滚动
 */
FOUNDATION_EXPORT NSNotificationName const WordDetailShouldScrollNotification;

#pragma mark - NetworkConstants.h

#define ERROR_MESSAGE_KEY                         @"errorMessage"


#endif /* Constants_h */
