//
//  ComplicationController.m
//  WatchApp Extension
//
//  Created by cyan on 15/10/24.
//  Copyright © 2015年 cyan. All rights reserved.
//

#import "ComplicationController.h"
#import "NSDate+Extension.h"

@interface ComplicationController ()

@property (nonatomic, strong) NSArray *timelineData;
@property (nonatomic, assign) NSTimeInterval midnight;

@end

@implementation ComplicationController

- (NSTimeInterval)midnight {
    return [[[NSDate date] midnight] timeIntervalSince1970];
}

- (instancetype)init {
    if (self = [super init]) {
        _timelineData = @[
            @{ @"begin": @(32400), @"end": @(43200), @"name": @"梦想小镇" },
            @{ @"begin": @(43200), @"end": @(54000), @"name": @"梦想小镇" },
            @{ @"begin": @(54000), @"end": @(86400), @"name": @"梦想小镇 - 阿里" }
        ];
    }
    
    return self;
}

#pragma mark - Timeline Configuration

- (void)getTimelineAnimationBehaviorForComplication:(CLKComplication *)complication withHandler:(void (^)(CLKComplicationTimelineAnimationBehavior))handler {
    handler(CLKComplicationTimelineAnimationBehaviorAlways);
}

- (void)getSupportedTimeTravelDirectionsForComplication:(CLKComplication *)complication withHandler:(void(^)(CLKComplicationTimeTravelDirections directions))handler {
    handler(CLKComplicationTimeTravelDirectionForward|CLKComplicationTimeTravelDirectionBackward);
}

- (void)getTimelineStartDateForComplication:(CLKComplication *)complication withHandler:(void(^)(NSDate * __nullable date))handler {
    NSDate *now = [NSDate date];
    NSDate *date = [now dateByAddingDays:-1];
    handler(date);
}

- (void)getTimelineEndDateForComplication:(CLKComplication *)complication withHandler:(void(^)(NSDate * __nullable date))handler {
    NSDate *now = [NSDate date];
    NSDate *date = [now dateByAddingDays:1];
    handler(date);
}

- (void)getPrivacyBehaviorForComplication:(CLKComplication *)complication withHandler:(void(^)(CLKComplicationPrivacyBehavior privacyBehavior))handler {
    handler(CLKComplicationPrivacyBehaviorShowOnLockScreen);
}

#pragma mark - Timeline Population

- (void)getCurrentTimelineEntryForComplication:(CLKComplication *)complication withHandler:(void(^)(CLKComplicationTimelineEntry * __nullable))handler {
    
    CLKComplicationTemplate *template = nil;
    if (complication.family == CLKComplicationFamilyModularLarge) {
        template = ({
            CLKComplicationTemplateModularLargeStandardBody *template = [[CLKComplicationTemplateModularLargeStandardBody alloc] init];
            template.headerTextProvider = [CLKSimpleTextProvider textProviderWithText:@"12:00 - 15:00"];
            template.body1TextProvider = [CLKSimpleTextProvider textProviderWithText:@"梦想小镇"];
            template.body2TextProvider = [CLKSimpleTextProvider textProviderWithText:@"编码"];
            template;
        });
    }
    
    if (template) {
        CLKComplicationTimelineEntry *entry = [CLKComplicationTimelineEntry entryWithDate:[NSDate dateWithTimeIntervalSince1970:self.midnight+50400] complicationTemplate:template];
        handler(entry);
    } else {
        handler(nil);
    }
}

- (void)getTimelineEntriesForComplication:(CLKComplication *)complication beforeDate:(NSDate *)date limit:(NSUInteger)limit withHandler:(void(^)(NSArray<CLKComplicationTimelineEntry *> * __nullable entries))handler {
    
    CLKComplicationTemplate *template = nil;
    if (complication.family == CLKComplicationFamilyModularLarge) {
        template = ({
            CLKComplicationTemplateModularLargeStandardBody *template = [[CLKComplicationTemplateModularLargeStandardBody alloc] init];
            template.headerTextProvider = [CLKSimpleTextProvider textProviderWithText:@"00:00 - 12:00"];
            template.body1TextProvider = [CLKSimpleTextProvider textProviderWithText:@"梦想小镇"];
            template.body2TextProvider = [CLKSimpleTextProvider textProviderWithText:@"路演"];
            template;
        });
    }
    
    if (template) {
        CLKComplicationTimelineEntry *entry = [CLKComplicationTimelineEntry entryWithDate:[NSDate dateWithTimeIntervalSince1970:self.midnight + 32400] complicationTemplate:template];
        handler(@[entry]);
    } else {
        handler(nil);
    }
}

- (void)getTimelineEntriesForComplication:(CLKComplication *)complication afterDate:(NSDate *)date limit:(NSUInteger)limit withHandler:(void(^)(NSArray<CLKComplicationTimelineEntry *> * __nullable entries))handler {
    CLKComplicationTemplate *template = nil;
    if (complication.family == CLKComplicationFamilyModularLarge) {
        template = ({
            CLKComplicationTemplateModularLargeStandardBody *template = [[CLKComplicationTemplateModularLargeStandardBody alloc] init];
            template.headerTextProvider = [CLKSimpleTextProvider textProviderWithText:@"15:00 - 24:00"];
            template.body1TextProvider = [CLKSimpleTextProvider textProviderWithText:@"梦想小镇 - 阿里"];
            template.body2TextProvider = [CLKSimpleTextProvider textProviderWithText:@"回家"];
            template;
        });
    }
    
    if (template) {
        CLKComplicationTimelineEntry *entry = [CLKComplicationTimelineEntry entryWithDate:[NSDate dateWithTimeIntervalSince1970:self.midnight + 54000] complicationTemplate:template];
        handler(@[entry]);
    } else {
        handler(nil);
    }
}

#pragma mark Update Scheduling

- (void)getNextRequestedUpdateDateWithHandler:(void(^)(NSDate * __nullable updateDate))handler {
    // Call the handler with the date when you would next like to be given the opportunity to update your complication content
    handler(nil);
}

#pragma mark - Placeholder Templates

- (void)getPlaceholderTemplateForComplication:(CLKComplication *)complication withHandler:(void(^)(CLKComplicationTemplate * __nullable complicationTemplate))handler {
    // This method will be called once per supported complication, and the results will be cached
    handler(nil);
}

@end
