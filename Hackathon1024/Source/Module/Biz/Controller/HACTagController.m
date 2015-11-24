//
//  HACTagController.m
//  Hackathon1024
//
//  Created by cyan on 15/10/24.
//  Copyright © 2015年 cyan. All rights reserved.
//

#import "HACTagController.h"
#import "SKTagView.h"

@interface HACTagController ()

@property (nonatomic, strong) SKTagView *tagView;
@property (nonatomic, strong) NSArray *colors;
@property (nonatomic, strong) HACFlatButton *doneButton;

@end

@implementation HACTagController

@synthesize doneButton;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"选择你感兴趣的";
    
    self.colors = @[
        [UIColor turquoiseColor],
        [UIColor greenSeaColor],
        [UIColor emerlandColor],
        [UIColor nephritisColor],
        [UIColor belizeHoleColor],
        [UIColor amethystColor],
        [UIColor wisteriaColor],
        [UIColor wetAsphaltColor],
        [UIColor midnightBlueColor],
        [UIColor sunflowerColor],
        [UIColor tangerineColor],
        [UIColor carrotColor],
        [UIColor pumpkinColor],
        [UIColor alizarinColor],
        [UIColor pomegranateColor],
        [UIColor cloudsColor],
        [UIColor silverColor],
        [UIColor concreteColor],
        [UIColor asbestosColor],
        [UIColor aw_pinkColor],
        [UIColor aw_purpleColor],
        [UIColor aw_blueColor],
        [UIColor aw_greenColor],
        [UIColor aw_yellowColor],
        [UIColor aw_orangeColor],
        [UIColor aw_redColor],
        [UIColor aw_whiteColor]
    ];
    
    self.tagView = ({
        SKTagView *view = [SKTagView new];
        view.padding = UIEdgeInsetsMake(10, 20, 10, 20);
        view.insets = 5;
        view.lineSpace = 5;
        view.didClickTagAtIndex = ^(NSUInteger index, NSString *text, BOOL checked) {
            // save
            NSMutableSet *tags = SharedData().tags;
            if (checked) {
                [tags addObject:text];
            } else {
                [tags removeObject:text];
            }
        };
        view;
    });
    [self.view addSubview:self.tagView];
    [self.tagView mas_makeConstraints:^(MASConstraintMaker *make) {
        UIView *superView = self.view;
        make.center.equalTo(superView);
        make.leading.equalTo(superView.mas_leading);
        make.trailing.equalTo(superView.mas_trailing);
    }];
    
    doneButton = [[HACFlatButton alloc] init];
    [doneButton setTitle:@"完成设置" forState:UIControlStateNormal];
    doneButton.center = CGPointMake(self.view.width/2, self.view.height-20-doneButton.height/2);
    [self.view addSubview:doneButton];
    
    @weakify(self);
    [doneButton bk_addEventHandler:^(id sender) {
        @strongify(self)
        [self doneSetting];
    } forControlEvents:UIControlEventTouchUpInside];
    
    [self loadTagsFromRemote];
}

- (void)doneSetting {
    
    if ([self.tagView selectedCount] == 0) {
        [PINToast showMessage:@"至少选 1 个啊喂"];
        return ;
    }
    // query network
    [SharedData() translateTags];
    
    @weakify(self);
    [[HACNetworkManager manager] post:API(@"add_point") params:SharedData().userInfo complete:^(HACNetworkRetCode code, NSDictionary *resp) {
        @strongify(self)
        SharedData().recommendData = resp;
        SharedData().showRecommend = YES;
        [self dismissViewControllerAnimated:YES completion:nil];
    }];
}

- (void)addText:(NSString *)text onTag:(SKTagView *)tagView {
    SKTag *tag = [SKTag tagWithText:text];
    tag.bgColor = self.colors[arc4random() % self.colors.count];
    tag.textColor = tag.bgColor.diffColor;
    tag.cornerRadius = 3;
    tag.fontSize = 15;
    tag.padding = UIEdgeInsetsMake(13.5, 12.5, 13.5, 12.5);
    [self.tagView addTag:tag];
}

- (void)loadTagsFromRemote {
    [[HACNetworkManager manager] get:API(@"get_tags") complete:^(HACNetworkRetCode code, NSDictionary *resp) {
        NSArray *tags = resp[@"tags"];
//        @[@"Python", @"Javascript", @"HTML", @"Go", @"Objective-C",@"C", @"PHP"]
        [tags enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            [self addText:obj onTag:self.tagView];
        }];
    }];
}

@end
