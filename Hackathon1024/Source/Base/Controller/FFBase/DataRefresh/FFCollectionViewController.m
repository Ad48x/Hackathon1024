//
//  FFCollectionViewController.m
//  FFBase
//
//  Created by cyan on 15/7/24.
//  Copyright (c) 2015年 WDK. All rights reserved.
//

#import "FFCollectionViewController.h"

@interface FFCollectionViewController ()

@end

@implementation FFCollectionViewController

- (void)initCollectionWithFrame:(CGRect)frame layout:(UICollectionViewLayout *)layout {
    [self initCollectionWithFrame:frame layout:layout refreshType:FFDataRefreshMaskAll];
}

- (void)initCollectionWithFrame:(CGRect)frame layout:(UICollectionViewLayout *)layout refreshType:(FFDataRefreshMask)mask {
    self.collectionView = [[HACBaseCollectionView alloc] initWithFrame:frame collectionViewLayout:layout];
    
    if (mask & FFDataRefreshMaskHeader) {
        self.collectionView.header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(didBeginRefreshData)];
    }
    
    if (mask & FFDataRefreshMaskFooter) {
        self.collectionView.footer = ({
            MJRefreshAutoFooter *footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(didBeginLoadMoreData)];
            footer.automaticallyRefresh = NO;
            footer;
        });
    }
    
    self.baseScrollView = self.collectionView;
    [self.view addSubview:self.collectionView];
}

@end
