//
//  FFCollectionViewController.h
//  FFBase
//
//  Created by cyan on 15/7/24.
//  Copyright (c) 2015年 WDK. All rights reserved.
//

#import "FFDataRefreshController.h"

@interface FFCollectionViewController : FFDataRefreshController<UICollectionViewDelegate>

@property (nonatomic, strong) HACBaseCollectionView *collectionView;

- (void)initCollectionWithFrame:(CGRect)frame layout:(UICollectionViewLayout *)layout;

- (void)initCollectionWithFrame:(CGRect)frame layout:(UICollectionViewLayout *)layout refreshType:(FFDataRefreshMask)mask; // 刷新类型

@end
