#import "LearntWord.h"
#import <WCDB/WCDB.h>

@interface LearntWord (WCTTableCoding) <WCTTableCoding>

WCDB_PROPERTY(aid)
WCDB_PROPERTY(wordId)
WCDB_PROPERTY(originId)
WCDB_PROPERTY(originType)
WCDB_PROPERTY(word)
WCDB_PROPERTY(tagId)
WCDB_PROPERTY(addDate)
WCDB_PROPERTY(updateDate)
WCDB_PROPERTY(wrongTimes)
WCDB_PROPERTY(abilityOption)

WCDB_PROPERTY(knowWrongTimes)
WCDB_PROPERTY(listenWrongTimes)
WCDB_PROPERTY(speakWrongTimes)

WCDB_PROPERTY(reviewWrongTimes)
WCDB_PROPERTY(reviewAnswerTimes)

WCDB_PROPERTY(belongId)
WCDB_PROPERTY(belongType)
WCDB_PROPERTY(mode)

WCDB_PROPERTY(examStatus)
WCDB_PROPERTY(examCompleted)
WCDB_PROPERTY(isCurrentRound)
WCDB_PROPERTY(firstSubjectiveResult)
WCDB_PROPERTY(preciseReviewState)
WCDB_PROPERTY(masterOption)

@end
