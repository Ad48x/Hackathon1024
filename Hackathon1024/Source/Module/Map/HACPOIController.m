//
//  HACPOIController.m
//  LBSDemo
//
//  Created by cyan on 15/7/6.
//  Copyright (c) 2015年 cyan. All rights reserved.
//

#import "HACPOIController.h"

static CGFloat const kTextFieldHeight = 44;

typedef NS_ENUM(NSInteger, LBSRefreshType) {
    LBSRefreshTypeReload = 0,   // 重新加载
    LBSRefreshTypeLoadMore      // 加载更多
};

@interface HACPOIController ()<MAMapViewDelegate, AMapSearchDelegate, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate> {
    CLLocationManager *locationManager;
    MAMapView *_mapView;
    MAUserLocation *_userLocation;
    AMapSearchAPI *_searchApi;
    BOOL _hasPoi; // 是否有过信息
}

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataSource;

@property (nonatomic, strong) UITextField *textField;

@property (nonatomic, assign) LBSRefreshType refreshType;
@property (nonatomic, copy) NSString *keyword;

@property (nonatomic, assign) int page;

@end

@implementation HACPOIController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    locationManager = [[CLLocationManager alloc] init];
    
    // fix iOS 8 location issue
    if ([CLLocationManager authorizationStatus] == kCLAuthorizationStatusNotDetermined) {
#ifdef __IPHONE_8_0
        if ([locationManager respondsToSelector:@selector(requestWhenInUseAuthorization)]) {
            [locationManager performSelector:@selector(requestWhenInUseAuthorization)]; // 用这个方法，plist里要加字段NSLocationWhenInUseUsageDescription
        }
#endif
    }
    
    // 初始化检索对象
    [AMapSearchServices sharedServices].apiKey = kHACMapApiKey;
    _searchApi = [[AMapSearchAPI alloc] init];
    _searchApi.delegate = self;
    _searchApi.language = AMapSearchLanguageZhCN;
    [self resetSearchState];
    
    // 初始化TableView
    self.dataSource = [[NSMutableArray alloc] initWithCapacity:10];
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, self.view.bounds.size.height/2, self.view.bounds.size.width, self.view.bounds.size.height/2)];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    
    // 初始化textField
    self.textField = [[UITextField alloc] initWithFrame:CGRectMake(20, self.view.bounds.size.height/2-kTextFieldHeight, self.view.bounds.size.width-40, kTextFieldHeight)];
    self.textField.placeholder = @"输入搜索关键字";
    self.textField.delegate = self;
    self.textField.returnKeyType = UIReturnKeySearch;
    self.textField.clearButtonMode = UITextFieldViewModeWhileEditing;
    [self.view addSubview:self.textField];
    
    // 设置tableView上下拉事件
    [self setupDragEvents];
}

- (void)viewDidAppear:(BOOL)animated { // 官方文档指出2D地图需要初始化在didAppear
    [super viewDidAppear:animated];

    // 配置用户Key
    [MAMapServices sharedServices].apiKey = kHACMapApiKey;
    
    _mapView = [[MAMapView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.bounds), CGRectGetHeight(self.view.bounds)/2-kTextFieldHeight)];
    _mapView.delegate = self;
    [_mapView setZoomLevel:16.5 animated:YES];
    // 定位
    _mapView.showsUserLocation = YES;
    [_mapView setUserTrackingMode:MAUserTrackingModeFollow animated:YES];
    [self.view addSubview:_mapView];
}

#pragma mark - MapView Delegate

- (void)mapView:(MAMapView *)mapView didUpdateUserLocation:(MAUserLocation *)userLocation updatingLocation:(BOOL)updatingLocation {
    if (updatingLocation && !_hasPoi) {
        _userLocation = userLocation;
        [self resetSearchState];
        [self beginPoiSearch];
        _hasPoi = YES;
    }
}

#pragma mark - SearchApi Delegate

// 实现POI搜索对应的回调函数
- (void)onPOISearchDone:(AMapPOISearchBaseRequest *)request response:(AMapPOISearchResponse *)response {
    
    if (self.refreshType == LBSRefreshTypeReload) {
        [self.dataSource removeAllObjects];
    }
    
    [self.dataSource addObjectsFromArray:response.pois];
    
    // Reload
    [self.tableView reloadData];
    
    if (self.refreshType == LBSRefreshTypeReload) {
        [self.tableView.header endRefreshing];
    } else if (self.refreshType == LBSRefreshTypeLoadMore) {
        [self.tableView.footer endRefreshing];
    }
}

#pragma mark - UITableView Delegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"PoiCellId";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier];
    }

    AMapPOI *poi = self.dataSource[indexPath.row];
    cell.textLabel.text = poi.name;
    cell.detailTextLabel.text = poi.address;
    
    return cell;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    [self.textField resignFirstResponder];
}

#pragma mark - UITextField Deletate

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    if (![textField.text isEqualToString:@""]) {
        self.keyword = textField.text;
        self.refreshType = LBSRefreshTypeReload;
        self.tableView.contentOffset = CGPointZero;
        [self beginPoiSearch];
    }
    
    [textField resignFirstResponder];
    
    return YES;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    textField.text = @"";
    [self resetSearchState];
    [self beginPoiSearch];
}

#pragma mark - Private Methods

- (void)beginPoiSearch {
    // 构造AMapPlaceSearchRequest对象，配置关键字搜索参数
    AMapPOIAroundSearchRequest *poiRequest = [[AMapPOIAroundSearchRequest alloc] init];
    poiRequest.keywords = _keyword;
    poiRequest.location = [AMapGeoPoint locationWithLatitude:_userLocation.coordinate.latitude longitude:_userLocation.coordinate.longitude];
    poiRequest.requireExtension = YES;
    poiRequest.page = self.page;
    // 汽车服务|汽车销售|汽车维修|摩托车服务|餐饮服务|购物服务|生活服务|体育休闲服务|
    // 医疗保健服务|住宿服务|风景名胜|商务住宅|政府机构及社会团体|科教文化服务|
    // 交通设施服务|金融保险服务|公司企业|道路附属设施|地名地址信息|公共设施
    // poiRequest.types = @"餐饮服务|生活服务";
    [_searchApi AMapPOIAroundSearch:poiRequest];
}

- (void)setupDragEvents {
    // Header Refresh Logic
    self.tableView.header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        self.refreshType = LBSRefreshTypeReload;
        [self resetSearchState];
        [self beginPoiSearch];
    }];
    
    // Footer Refresh Logic
    self.tableView.footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        ++ self.page;
        self.refreshType = LBSRefreshTypeLoadMore;
        [self beginPoiSearch];
    }];
}

// 清空搜索状态 关键字设为空 页面从1开始
- (void)resetSearchState {
    self.keyword = @"";
    self.page = 1;
}

@end
