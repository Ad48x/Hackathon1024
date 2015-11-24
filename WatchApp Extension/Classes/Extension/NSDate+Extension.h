//
//  NSDate+Extension.h
//  HourDay
//
//  Created by cyan on 15/3/27.
//  Copyright (c) 2015年 cyan. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum
{
    ChineseDateFieldYear = 0,
    ChineseDateFieldMonth,
    ChineseDateFieldDay,
    ChineseDateFieldAll,
    ChineseDateFieldYearMonth,
    ChineseDateFieldMonthDay
}ChineseDateField;

@interface NSDateDayEntry : NSObject

@property (nonatomic, assign) int year;
@property (nonatomic, assign) int month;
@property (nonatomic, assign) int day;
@property (nonatomic, strong, readonly) NSMutableDictionary *dictionaryRepresentation;

@end

@interface NSDate (Extension)

// current
- (NSUInteger)currentHour;
- (NSUInteger)currentMinute;
- (NSUInteger)currentSecond;
- (NSUInteger)currentYear;
- (NSUInteger)currentMonth;
- (NSUInteger)currentDay;

- (NSInteger)year;
- (NSInteger)month;
- (NSInteger)day;
- (NSInteger)week;
- (NSInteger)weekOfYear;
- (NSInteger)daysOfYear;

- (NSURL *)calshowURL;

- (NSDate *)dateByAddingDays:(int)days;
- (NSDateDayEntry *)dayEntry;
- (NSDateDayEntry *)dayEntryByAddingDays:(int)days;

- (BOOL)isEarlierThan:(NSDate *)aDate;
- (BOOL)isLaterThan:(NSDate *)aDate;

- (NSDate *)midnight; // 午夜时间

@end
