//
//  HACTimeController.m
//  Hackathon1024
//
//  Created by cyan on 15/10/24.
//  Copyright © 2015年 cyan. All rights reserved.
//

#import "HACTimeController.h"
#import "HACTagController.h"

@interface HACTimeController ()

@property (nonatomic, strong) UIDatePicker *datePicker;
@property (nonatomic, strong) UILabel *tipsLabel;
@property (nonatomic, strong) NSDateFormatter *dateFormatter;

@property (nonatomic, strong) UIDatePicker *datePicker0;
@property (nonatomic, strong) UILabel *tipsLabel0;

@end

@implementation HACTimeController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self clearExtendedLayoutEdges];
    
    @weakify(self);
    [self setRightBarButtonWithTitle:@"下一步" action:^(id sender) {
        @strongify(self)
        [self pushViewController:[HACTagController new]];
    }];
    
    self.dateFormatter = [[NSDateFormatter alloc] init];
    self.dateFormatter.dateFormat = @"HH:mm";
    
    self.tipsLabel0 = [[UILabel alloc] init];
    self.tipsLabel0.textColor = [UIColor asbestosColor];
    self.tipsLabel0.font = MediumFont(18);
    self.tipsLabel0.textAlignment = NSTextAlignmentCenter;
    self.tipsLabel0.text = @"开始时间: 09:00";
    [self.view addSubview:self.tipsLabel0];
    [self.tipsLabel0 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(self.view);
        make.height.equalTo(64);
    }];
    
    self.datePicker0 = [[UIDatePicker alloc] init];
    self.datePicker0.datePickerMode = UIDatePickerModeTime;
    self.datePicker0.date = [NSDate date];
    [self.view addSubview:self.datePicker0];
    [self.datePicker0 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.equalTo(self.tipsLabel0.mas_bottom);
    }];
    [self.datePicker0 addTarget:self action:@selector(datePicker0Changed:) forControlEvents:UIControlEventValueChanged];

    self.datePicker = [[UIDatePicker alloc] init];
    self.datePicker.datePickerMode = UIDatePickerModeTime;
    self.datePicker.date = [NSDate date];
    [self.view addSubview:self.datePicker];
    [self.datePicker mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.left.right.equalTo(self.view);
    }];
    [self.datePicker addTarget:self action:@selector(datePickerChanged:) forControlEvents:UIControlEventValueChanged];

    self.tipsLabel = [[UILabel alloc] init];
    self.tipsLabel.textColor = [UIColor asbestosColor];
    self.tipsLabel.font = MediumFont(18);
    self.tipsLabel.textAlignment = NSTextAlignmentCenter;
    self.tipsLabel.text = @"结束时间: 09:30";
    [self.view addSubview:self.tipsLabel];
    [self.view addSubview:self.tipsLabel];
    [self.tipsLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.height.equalTo(64);
        make.bottom.equalTo(self.datePicker.mas_top);
    }];
    
    [self setDefaultValues];
}

- (void)setDefaultValues {
    NSString *start_time = @"09:00";
    SharedData().userInfo[@"start_time"] = start_time;
    NSString *end_time = @"09:30";
    SharedData().userInfo[@"end_time"] = end_time;
}

- (void)datePickerChanged:(UIDatePicker *)sender {
    NSString *time = [self.dateFormatter stringFromDate:sender.date];
    SharedData().userInfo[@"end_time"] = time;
    self.tipsLabel.text = [NSString stringWithFormat:@"结束时间: %@", time];
}

- (void)datePicker0Changed:(UIDatePicker *)sender {
    NSString *time = [self.dateFormatter stringFromDate:sender.date];
    SharedData().userInfo[@"start_time"] = time;
    self.tipsLabel0.text = [NSString stringWithFormat:@"开始时间: %@", time];
}

@end
