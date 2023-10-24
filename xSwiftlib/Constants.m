#import "Constants.h"
#import <Foundation/Foundation.h>

#pragma mark - URL routers

/*------------------------------------------------------学习页面-----------------------------------------------------------*/
// path
NSString *const WMLearningPage = @"LearningPage";
/* param */
// WordBase
NSString *const WMLearningPageParamWord = @"word";
// NSString
NSString *const WMLearningPageParamBelongId = @"belongId";
// NSNumber  影响底部来源数据的展示
NSString *const WMLearningPageParamBelongType = @"belongType";
// BOOL
NSString *const WMLearningPageParamCanSwitchToNextWord = @"canSwitchToNextWord";
// CloseOrNextWordButtonType
NSString *const WMLearningPageParamCloseOrNextWordButtonType = @"closeOrNextWordButtonType";
/// BOOL
NSString *const WMLearningPageParamNeedQueryCollectionStatus = @"needQueryCollectionStatus";
/// NSArray
NSString *const WMLearningPageParamCollectedList = @"collectedList";
/// WMLearningPageFromType
NSString *const WMLearningPageParamFromPage = @"fromPage";
/// 返回操作
NSString *const WMLearningPageParamShouldBackToHome = @"shouldBackToHome";
/// 毛玻璃背景图
// UIImage
NSString *const WMLearningPageParamBlurEffectImage = @"blurEffectImage";
/// 背景图片是否是默认图
NSString *const WMLearningPageParamIsDefaultImage = @"defaultImage";
/// 是否需要展示答错提示
NSString *const WMLearningPageParamShouldDisplayWrongTips = @"shouldDisplayWrongTips";
/// 是否隐藏下方关闭按钮  替换为展示在上方的nav中
NSString *const WMLearningPageParamShouldHideNextOperationButton = @"shouldHideNextOpertaionButton";
/// 是否隐藏更多菜单中的退出学习按钮
NSString *const WMLearningPageParamShouldHideMoreMenuExitLearnItem = @"shouldHideMoreExitLearnItem";
///  词义卡navLayout样式
NSString *const WMLearningPageParamNavLayoutType = @"navLayoutType";
/// disappear handle
NSString *const WMLearningPageParamDisappearHandle = @"disappearHandle";

NSString *const WMLearningPageParamShouldDisplayChangeToUSManTips = @"shouldDisplayChangeToUSManTips";

NSString *const WMLearningPageParamShouldUseSystemTheme = @"shouldUseSystemTheme";

/*-------------------------------------------------------复习页----------------------------------------------------------*/
// path
NSString *const WMReviewPage = @"ReviewPage";
/* param */
/// ReviewEngine
NSString *const WMReviewPageParamViewModel = @"ViewModel";

/*------------------------------------------------------助记页面-----------------------------------------------------------*/
// path
NSString *const WMMnemonicsPage = @"MnemonicsPage";
/* param */
// BookWord
NSString *const WMMnemonicsPageParamWord = @"word";
// NSString
NSString *const WMMnemonicsPageParamPageIndex = @"pageIndex";

/*------------------------------------------------------灵感视频预览页面-----------------------------------------------------------*/
// path
NSString *const WMInspirationVideoPreviewPage = @"InspirationVideoPreviewPage";
/* param */
// Inspiration
NSString *const WMInspirationVideoPreviewPageParamInspiration = @"inspiration";
// SuperPlayerView
NSString *const WMInspirationVideoPreviewPageParamVideoPlayer = @"videoPlayer";

/*------------------------------------------------------灵感图片预览页面-----------------------------------------------------------*/
// path
NSString *const WMInspirationPicPreviewPage = @"InspirationPicPreviewPage";
/* param */
// Inspiration
NSString *const WMInspirationPicPreviewPageParamInspiration = @"inspiration";

/*------------------------------------------------------灵感编辑页面-----------------------------------------------------------*/
// path
NSString *const WMEditInspirationPage = @"EditInspirationPage";
/* param */
// BookWord
NSString *const WMEditInspirationPageParamWord = @"word";
// Inspiration
NSString *const WMEditInspirationPageParamMyInspiration = @"myInspiration";

/*------------------------------------------------------真人单词发音页面-----------------------------------------------------------*/
/* param */
NSString *const WMPersonPronouncePageDelegateKey = @"PersonWordPronouncePageDelgate";
// path
NSString *const WMPersonWordPronouncePage = @"PersonWordPronouncePage";
/* param */
// WordResourceInfo
NSString *const WMPersonWordPronouncePageParamWordResourceInfo = @"wordResourceInfo";
NSString *const WMPersonWordPronouncePageParamWordBusinessSource = @"businessSource";

/*------------------------------------------------------真人例句发音页面-----------------------------------------------------------*/
// path
NSString *const WMPersonExamplePronouncePage = @"PersonExamplePronouncePage";
/* param */
// WordResourceInfo
NSString *const WMPersonExamplePronouncePageParamWordResourceInfo = @"wordResourceInfo";

/*------------------------------------------------------自由复习-----------------------------------------------------------*/
/// path
NSString *const WMFreeReviewPage = @"FreeReviewPage";
/// param
/// FreeReviewViewModel
NSString *const WMFreeReviewPageParamViewModel = @"FreeReviewViewModel";
NSString *const WMFreeReviewPageParamFeedbackSource = @"FreeReviewFeedbackSource";

/*-------------------------------------------------------预加载页----------------------------------------------------------*/
WMLearningPageFromType *const kWMLearningPageFromTypeStudy = @"study";
WMLearningPageFromType *const kWMLearningPageFromTypeReview = @"review";
WMLearningPageFromType *const kWMLearningPageFromTypeGYM = @"gym";
/// path
NSString *const WMLearningPreLoading = @"WMLearningPreLoading";
// param
/// delegate
NSString *const WMLearningPreLoadingDelegate = @"WMLearningPreLoadingDelegate";
/// type
NSString *const WMLearningPreLoadingType = @"WMLearningPreLoadingType";

/*-------------------------------------------------------复习预加载页----------------------------------------------------------*/
/// path
NSString *const WMReviewPreLoading = @"WMReviewPreLoading";
/// param
NSString *const WMReviewPreLoadingDelegate = @"WMReviewPreLoadingDelegate";

/*-------------------------------------------------------识记页----------------------------------------------------------*/
// path
NSString *const WMRememberPage = @"RememberPage";
/* param */
NSString *const WMRememberPageParamEngine = @"engine";

NSString *const WMRememberPageParamShowGuideAnimation = @"showGuideAnimation";

/*-------------------------------------------------------巩固页面----------------------------------------------------------*/
// path
NSString *const WMConsolidatePage = @"ConsolidatePage";

/* param */
// BOOL
NSString *const WMExamPageParamHidePreviousWord = @"hidePreviousWord";
// WordResourceDic
NSString *const WMExamPageParamWordResourceDic = @"wordResourceDic";
NSString *const WMExamPageParamViewModel = @"viewModel";
NSString *const WMExamPageParamShowGuideAnimation = @"showGuideAnimation";
NSString *const WMExamPageParamAdditionalRightWords = @"additionalRightWords";

/*------------------------------------------------------学习结果页面-----------------------------------------------------------*/
// path
NSString *const WMLearningResultPage = @"LearningResultPage";
NSString *const WMMemorizeConsolidateResultPage = @"MemorizeConsolidateResultPage";
/* param */
//老版本结果页数据
NSString *const WMLearningResultPageParamEngine = @"engine";
NSString *const WMLearningResultPageParamCumulativeWords = @"cumulativeWords";
NSString *const WMLearningResultPageParamCumulativeDays = @"cumulativeDays";

/*-----------------------------------------------------选择词书-----------------------------------------------------------*/
/// path
NSString *const WMWordBookListPage = @"wordBookListPage";
/// param
NSString *const WMWordBookListDelegate = @"wordBookListDelegate";

NSString *const WMWordBookListSource = @"wordBookListSource";

//新版本结果页参数

NSString *const WMExerciseRoomPage = @"/opengym";
/*-----------------------------------------------------口语课首页-----------------------------------------------------------*/
/// path
NSString *const WOCCourseListPage = @"videoCourse";
/// param
NSString *const WOCCourseListPageCourseId = @"courseId";
NSString *const WOCCourseListPageTab = @"tab";

/*-----------------------------------------------------反馈&报错-----------------------------------------------------------*/
/// path
NSString *const WOCWordFeedbackPage = @"openMessageDetail";
/// param
NSString *const WOCWordFeedbackPageFeedbackId = @"feedbackId";

#pragma mark -

/// 默认TagId
NSInteger const kDefaultTagId = 4;

/// 用户名长度限制
NSUInteger const kUserNameLimit = 10;

/// 词单的名称、简介长度
NSUInteger const kWordCollectionNameLimit = 20;
NSUInteger const kWordCollectionDescLimit = 100;

#pragma mark -

NSString *const kSceneModeResumePlayVideoNotification = @"kSceneModeResumePlayVideoNotification";
NSString *const WMExamPageDidAppearEventNotification = @"WMExamPageDidAppearEventNotification";
NSString *const WMExamPageDidDisappearEventNotification = @"WMExamPageDidDisappearEventNotification";
NSString *const WMExamPageWillDisappearEventNotification = @"WMExamPageWillDisappearEventNotification";

NSString *const WMExamPageSpellAddKeyboardEventNotification = @"WMExamPageSpellAddKeyboardEventNotification";
NSString *const WMExamPageSpellRemoveKeyboardEventNotification = @"WMExamPageSpellRemoveKeyboardEventNotification";

NSString *const ExamPageNeedHidePopupNotification = @"ExamPageNeedHidePopupNotification";

NSString *const ExerciseRoomResourceLoadingNotification = @"ExerciseRoomResourceLoadingNotification";
NSString *const ExerciseRoomResourceLoadedNotification = @"ExerciseRoomResourceLoadedNotification";

///  随身听开始加载资源
NSString *const ListenWordResourceLoadingNotification = @"ListenWordResourceLoadingNotification";
///  随身听资源加载完成
NSString *const ListenWordResourceLoadedNotification = @"ListenWordResourceLoadedNotification";

NSNotificationName const SwitchToNextWordNotification = @"SwitchToNextWordNotification";          
NSNotificationName const SpeakResultGuideDidShownNotification = @"SpeakResultGuideDidShownNotification";
NSNotificationName const SpeakResultGuideDidHideNotification = @"SpeakResultGuideDidHideNotification";
NSNotificationName const LeftWordListDidShownNotification = @"LeftWordListDidShownNotification";
NSNotificationName const LeftWordListDidHideNotification = @"LeftWordListDidHideNotification";
NSString *const DailyProgressDidResetNotification = @"DailyProgressDidResetNotification";

NSString *const LearningWordsImageDidFinishedPrepareNotification = @"LearningWordsImageDidFinishedPrepareNotification";
NSString *const ReviewWordsImageDidFinishedPrepareNotification = @"ReviewWordsImageDidFinishedPrepareNotification";

NSString *const LearningWordsMnemonicsDidFinishedPrepareNotification =
@"LearningWordsMnemonicsDidFinishedPrepareNotification";
NSString *const ReviewWordsMnemonicsDidFinishedPrepareNotification =
@"ReviewWordsMnemonicsDidFinishedPrepareNotification";

NSString *const ReadingDidTapWordNotification = @"ReadingDidTapWordNotification";
NSString *const ReadingDidNeedShowToolViewNotification = @"ReadingDidNeedShowToolViewNotification";
NSString *const ReadingDidFinishNotification = @"ReadingDidFinishNotification";
NSString *const ReadingPaginationDidFinishNotification = @"ReadingPaginationDidFinishNotification";

NSString *const LoginForTokenFailureNotification = @"LoginForTokenFailureNotification";

NSString *const LearningRootViewDidBecomeVisibleNotification = @"LearningRootViewDidBecomeVisibleNotification";
NSString *const PlanSyncDidFinishedNotification = @"PlanSyncDidFinishedNotification";    /// 计划同步完成
NSString *const PlanSyncNoPlanNeededNotification = @"PlanSyncNoPlanNeededNotification";  /// 没有计划需要同步
NSString *const DatabaseDidInitialNotification = @"DatabaseDidInitialNotification";

NSNotificationName const UserSettingDidNeedReportNotification = @"UserSettingDidNeedReportNotification";

NSNotificationName const ReviewLimitCountDidChangedNotification = @"ReviewLimitCountDidChangedNotification";

NSNotificationName const UserChangePraiseOfficialExampleNotification = @"UserChangePraiseOfficialExampleNotification";

NSNotificationName const LearningRootRefreshHotTagsNotification = @"LearningRootRefreshHotTagsNotification";

NSNotificationName const DeviceTokenDidRegisterNotification = @"DeviceTokenDidRegisterNotification";

NSNotificationName const WMFreeReviewDidAppearNotification = @"WMFreeReviewDidAppearNotification";

NSNotificationName const WMFreeReviewWillAppearNotification =
@"WMFreeReviewWillAppearNotification";  // note: 应该是即将消失, 手误写成了即将出现

NSNotificationName const WMReviewDidFinishGroupNotification = @"WMReviewDidFinishGroupNotification";

NSNotificationName const WCWRootFunctionActionUpdateNofication = @"WCWRootFunctionActionUpdateNofication";

/// 练功房资源更新通知
NSNotificationName const ExerciseWordsSourceDidChangedNotification = @"kExerciseWordsSourceDidChangedNotification";


BOOL IsWordSortByLetter(WordSortType type) {
    BOOL letterSort = WordSortTypeLetterAsc == type || WordSortTypeLetterDesc == type;
    return letterSort;
}

BOOL IsWordSortByTime(WordSortType type) {
    BOOL timeSort = WordSortTypeTimeAsc == type || WordSortTypeTimeDesc == type;
    return timeSort;
}

BOOL IsWordSortByWrongCount(WordSortType type) {
    BOOL result = WordSortTypeWrongCountAsc == type || WordSortTypeWrongCountDesc == type;
    return result;
}

BOOL IsWordSortByMasterRate(WordSortType type) {
    BOOL result = WordSortTypeMasterRateAsc == type || WordSortTypeMasterRateDesc == type;
    return result;
}

/// 根据掌握度返回 掌握度等级
/// [0, 0.25)       0
/// [0.25, 0.5)    1
/// [0.5, 0.75)    2
/// [0.75, 1]       3
/// @param masterRate 掌握度 [0, 1]
NSInteger LevelOfMasterRate(CGFloat masterRate) {
    NSInteger level = 0;
    if (masterRate < 0.25)
        level = 0;
    else if (masterRate < 0.5)
        level = 1;
    else if (masterRate < 0.75)
        level = 2;
    else
        level = 3;
    
    return level;
}

/// 单词的掌握度是否相似
BOOL IsMasterRateSimilar(CGFloat rate1, CGFloat rate2) {
    NSInteger l1 = LevelOfMasterRate(rate1);
    NSInteger l2 = LevelOfMasterRate(rate2);
    
    return l1 == l2;
}

/// 获取 HTTP 请求中的错误信息描述
NSString *getHttpErrorMessage(NSError *error) {
    NSString *tip = error.userInfo[ERROR_MESSAGE_KEY];
    if (!tip) {
        switch (error.code) {
            case NSURLErrorNotConnectedToInternet:
                tip = @"网络连接异常";
                break;
            default:
                tip = @"网络连接异常";
                break;
        }
    }
    return tip;
}

/// 根据 测试类型 返回该类型的描述信息
NSString *getDescriptionWithExamType(OptionExamType type) {
    NSString *ret = @"";
    
    switch (type) {
        case OptionExamTypeReadingEnZh:  // 看英文选中文
            ret = DESC_ExamTypeReadingEnZh;
            break;
        case OptionExamTypeReadingZhEn:
            ret = DESC_ExamTypeReadingZhEn;
            break;
        case OptionExamTypeListeningVoiceZh:  // 听发音选中文
            ret = DESC_ExamTypeListeningVoiceZh;
            break;
        case OptionExamTypeWritingZhEn:  // 看中文写英文
            ret = DESC_ExamTypeWritingZhEn;
            break;
        case OptionExamTypeSenceImageWord:
            ret = DESC_ExamTypeSenceImageWord;
            break;
        case OptionExamTypeSenceWordImage:  // 看单词选图片
            ret = DESC_ExamTypeSenceWordImage;
            break;
        case OptionExamTypeSenceSentence:
            ret = DESC_ExamTypeSenceSentence;
            break;
        case OptionExamTypeEnglishMeaningEn:  // 看英文释义选词
            ret = DESC_ExamTypeEnglishMeaningEn;
            break;
        case OptionExamTypeListeningEnWritingEn:  // 听英文写单词
            ret = DESC_ExamTypeListeningEnWritingEn;
            break;
        case OptionExamTypeReadingZhSpeakingEn:  // 看中文释义说单词
            ret = DESC_ExamTypeReadingZhSpeakingEn;
            break;
        default:
            break;
    }
    return ret;
}

/// 返回 V4版本测试7种题型
NSArray<NSNumber *> *getAllV4OptionExamTypes(void) {
    return @[
        @(OptionExamTypeReadingEnZh),       // 1 << 0
        @(OptionExamTypeReadingZhEn),       // 1 << 1
        @(OptionExamTypeEnglishMeaningEn),  // 1 << 7 看词典英文释义选单词
        @(OptionExamTypeWritingZhEn),       // 1 << 3 看中文写英文
        //      @(OptionExamTypeSenceImageWord), // 1 << 4 // 1看图片选单词
        @(OptionExamTypeListeningVoiceZh),  // 1 << 2
        //      @(OptionExamTypeSenceWordImage),
        //      @(OptionExamTypeListeningEnWritingEn)  // 听英文写单词
        @(OptionExamTypeReadingZhSpeakingEn)  // 1 << 9
    ];
}

/// 将 option 类型的 ExamType 转为 ExamType 数组
NSArray<NSNumber *> *convertOptionExamTypeToExamTypes(OptionExamType optionExamType) {
    NSMutableArray<NSNumber *> *array = [[NSMutableArray alloc] init];
    
    if (optionExamType & OptionExamTypeReadingEnZh) {  //
        [array addObject:@(ExamTypeReadingEnZh)];
    }
    if (optionExamType & OptionExamTypeReadingZhEn) {  //
        [array addObject:@(ExamTypeReadingZhEn)];
    }
    if (optionExamType & OptionExamTypeWritingZhEn) {  //
        [array addObject:@(ExamTypeWritingZhEn)];
    }
    if (optionExamType & OptionExamTypeSenceImageWord) {  //
        [array addObject:@(ExamTypeSenceImageWord)];
    }
    if (optionExamType & OptionExamTypeListeningVoiceZh) {  //
        [array addObject:@(ExamTypeListeningVoiceZh)];
    }
    if (optionExamType & OptionExamTypeEnglishMeaningEn) {
        [array addObject:@(ExamTypeEnglishMeaningEn)];
    }
    
    if (optionExamType & OptionExamTypeReadingZhSpeakingEn) {  //
        [array addObject:@(ExamTypeReadingZhSpeakingEn)];
    }
    
    if (optionExamType & OptionExamTypeReadingSentenceEn) {
        [array addObject:@(ExamTypeReadingSentenceEn)];
    }
    
    if (optionExamType & OptionExamTypeSpeakZhEn) {
        [array addObject:@(ExamTypeSpeakZhEn)];
    }
    
    if (optionExamType & OptionExamTypeSentenceWordChooseChineseMeaning) {
        [array addObject:@(ExamTypeSentenceWordChooseChineseMeaning)];
    }
    
    if (optionExamType & OptionExamTypeSentenceChineseMeaningChooseWord) {
        [array addObject:@(ExamTypeSentenceChineseMeaningChooseWord)];
    }
    
    return array;
}

NSString *examTypeLogString(OptionExamType optionExamType) {
    NSMutableString *string = [[NSMutableString alloc] init];
    
    if (optionExamType & OptionExamTypeReadingEnZh) {  //
        if (string && string.length > 0) {
            [string appendString:@", word_chose_chinese"];
        } else {
            [string appendString:@"word_chose_chinese"];
        }
    }
    if (optionExamType & OptionExamTypeReadingZhEn) {  //
        if (string && string.length > 0) {
            [string appendString:@", chinese_chose_word"];
        } else {
            [string appendString:@"chinese_chose_word"];
        }
    }
    if (optionExamType & OptionExamTypeWritingZhEn) {  //
        if (string && string.length > 0) {
            [string appendString:@", spell"];
        } else {
            [string appendString:@"spell"];
        }
    }
    if (optionExamType & OptionExamTypeListeningVoiceZh) {  //
        if (string && string.length > 0) {
            [string appendString:@", listen"];
        } else {
            [string appendString:@"listen"];
        }
    }
    if (optionExamType & OptionExamTypeEnglishMeaningEn) {
        if (string && string.length > 0) {
            [string appendString:@", english_chose_word"];
        } else {
            [string appendString:@"english_chose_word"];
        }
    }
    if (optionExamType & OptionExamTypeReadingZhSpeakingEn) {  //
        if (string && string.length > 0) {
            [string appendString:@", speak_word"];
        } else {
            [string appendString:@"speak_word"];
        }
    }
    if (optionExamType & OptionExamTypeReadingSentenceEn) {  //
        if (string && string.length > 0) {
            [string appendString:@", speak"];
        } else {
            [string appendString:@"speak"];
        }
    }
    
    return string;
}

/// 将 ExamType 类型转化为 OptionExamType 类型。
OptionExamType convertExamTypeToOptionType(ExamType examType) { return 1 << examType; }

/// 真题例句练习：ExamType ->  SentenceExamType
SentenceExamType examTypeToSentenceExamType(ExamType examType) {
    
    if (examType == ExamTypeSentenceChineseMeaningChooseWord) {
        return SentenceExamChineseMeaningChooseWord;
    } else if (examType == ExamTypeSentenceWordChooseChineseMeaning) {
        return SentenceExamWordChooseChineseMeaning;
    }
    
    return SentenceExamWordChooseChineseMeaning;
}

ExamType sentenceExamTypeToExamType(SentenceExamType sentenceExamType) {
    
    if (sentenceExamType == SentenceExamWordChooseChineseMeaning) {
        return ExamTypeSentenceWordChooseChineseMeaning;
    } else if (sentenceExamType == SentenceExamChineseMeaningChooseWord) {
        return ExamTypeSentenceChineseMeaningChooseWord;
    }
    
    return ExamTypeSentenceWordChooseChineseMeaning;
}

/// 真题例句练习：ExamType默认题型替换
ExamType replaceExamTypeForSentenceExam(ExamType examType) {
    
    if (examType == ExamTypeSentenceWordChooseChineseMeaning) {
        return ExamTypeReadingEnZh;
    } else if (examType == ExamTypeSentenceChineseMeaningChooseWord) {
        return ExamTypeReadingZhEn;
    }
    
    return ExamTypeReadingEnZh;
}

/// 是否是例句练习
BOOL isSentenceExam(ExamType examType) {
    
    return (examType == ExamTypeSentenceWordChooseChineseMeaning ||
            examType == ExamTypeSentenceChineseMeaningChooseWord);
}

NSString *exampleTypeName(ExampleType exampleType) {
    NSString *typeName = @"";
    switch (exampleType) {
        case ExampleShort:
            typeName = @"万词王短例句";
            break;
        case ExampleReal:
            typeName = @"真题例句";
            break;
        case ExampleLexicon:
            typeName = @"例句";
            break;
        case ExampleChoiceness:
            typeName = @"精选例句";
            break;
        case ExampleVideo:
            typeName = @"视频例句";
            break;
        case ExamplePracticalScene:
            typeName = @"实用场景例句";
            break;
        case ExampleColinsDerivative:
            typeName = @"例句";
            break;
        default:
            typeName = @"例句";
            break;
    }
    return typeName;
}

/// ExamType 所属能力类型
AbilityType abilityTypeWithExamType(ExamType examType) {
    AbilityType ability = AbilityTypeKnow;
    
    if (examType == ExamTypeReadingEnZh || examType == ExamTypeReadingZhEn || examType == ExamTypeSenceImageWord ||
        examType == ExamTypeEnglishMeaningEn || examType == ExamTypeWritingZhEn || isSentenceExam(examType) || examType == ExamTypeSubjectiveItem) {
        ability = AbilityTypeKnow;
    } else if (examType == ExamTypeListeningVoiceZh) {
        ability = AbilityTypeListen;
    } else if (examType == ExamTypeReadingZhSpeakingEn || examType == ExamTypeReadingSentenceEn ||
               examType == ExamTypeSpeakZhEn) {
        ability = AbilityTypeSpeak;
    }
    
    return ability;
}

/// 埋点
NSString * statisticSourcePage(ExamPageType pageType) {
    
    NSString *source = @"";
    
    switch (pageType) {
        case ExamPageTypeConsolidate:
            source = @"consolidate";
            break;
        case ExamPageTypeReview:
            source = @"review";
            break;
        case ExamPageTypeFreeReview:
            source = @"gym";
            break;
    }
    
    return source;
}

NSInteger statisticNumberOfExam(ExamType examType) {
    
    NSInteger number = 1;
    switch (examType) {
        case ExamTypeReadingEnZh:
            number = 1;
            break;
        case ExamTypeReadingZhEn:
            number = 2;
            break;
        case ExamTypeListeningVoiceZh:
            number = 3;
            break;
        case ExamTypeEnglishMeaningEn:
            number = 4;
            break;
        case ExamTypeWritingZhEn:
            number = 5;
            break;
        case ExamTypeReadingZhSpeakingEn:
            number = 6;
            break;
        case ExamTypeReadingSentenceEn:
            number = 7;
            break;
        case ExamTypeSpeakZhEn:
            number = 8;
            break;
        default:
            number = 1;
            break;
    }
    
    return number;
}




/**
 * 词义卡可以滚动
 */
NSNotificationName const WordDetailShouldScrollNotification = @"kWordDetailShouldScrollNotification";
