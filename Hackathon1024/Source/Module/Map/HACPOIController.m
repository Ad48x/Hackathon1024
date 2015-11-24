//
//  HACPOIController.m
//  LBSDemo
//
//  Created by cyan on 15/7/6.
//  Copyright (c) 2015年 cyan. All rights reserved.
//

#import "HACPOIController.h"
#import "HACMapController.h"

static CGFloat const kTextFieldHeight = 44;

typedef NS_ENUM(NSInteger, LBSRefreshType) {
    LBSRefreshTypeReload = 0,   // 重新加载
    LBSRefreshTypeLoadMore      // 加载更多
};

@interface HACPOIController ()<MAMapViewDelegate, AMapSearchDelegate, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate, UIGestureRecognizerDelegate> {
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
@property (nonatomic, assign) BOOL didSearched;

@property (nonatomic, assign) CLLocationCoordinate2D coordinate;
@property (nonatomic, strong) MAPointAnnotation *annotation;

@end

@implementation HACPOIController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = self.selectFrom ? @"选择起点": @"选择终点";
    
    @weakify(self);
    [self setLeftBarButtonWithTitle:@"取消" action:^(id sender) {
        @strongify(self)
        [self dismissViewControllerAnimated:YES completion:nil];
    }];
    [self clearExtendedLayoutEdges];
    
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
    _searchApi = [[AMapSearchAPI alloc] initWithSearchKey:kHACMapApiKey Delegate:self];
    _searchApi.language = AMapSearchLanguage_zh_CN;
    [self resetSearchState];
    
    // 初始化TableView
    CGFloat navHeight = 30;
    self.dataSource = [[NSMutableArray alloc] initWithCapacity:10];
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, self.view.bounds.size.height*0.5-navHeight, self.view.bounds.size.width, self.view.bounds.size.height*0.5-navHeight-4)];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.backgroundColor = HAC_Theme_Color;
    self.tableView.tableFooterView = [UIView new];
    [self.view addSubview:self.tableView];
    
    // 初始化textField
    self.textField = [[UITextField alloc] initWithFrame:CGRectMake(20, self.view.bounds.size.height*0.5-kTextFieldHeight-navHeight, self.view.bounds.size.width-40, kTextFieldHeight)];
    self.textField.font = RegularFont(14);
    self.textField.placeholder = @"搜索目的地";
    self.textField.delegate = self;
    self.textField.clearButtonMode = UITextFieldViewModeAlways;
    self.textField.returnKeyType = UIReturnKeySearch;
    self.textField.tintColor = [UIColor alizarinColor];
    [self.view addSubview:self.textField];
    
    [self.view addSubview:({
        UIView *line = [[UIView alloc] initWithFrame:CGRectMake(20, self.tableView.top, self.view.width-40, ONE_PIXEL)];
        line.backgroundColor = HAC_DarkGray_Color;
        line;
    })];
    
    // 设置tableView上下拉事件
    [self setupDragEvents];
}

- (void)viewDidAppear:(BOOL)animated { // 官方文档指出2D地图需要初始化在didAppear
    [super viewDidAppear:animated];
    
    // 配置用户Key
    [MAMapServices sharedServices].apiKey = kHACMapApiKey;
    
    _mapView = [[MAMapView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.bounds), CGRectGetHeight(self.view.bounds)/2-kTextFieldHeight)];
    _mapView.delegate = self;
    [_mapView setZoomLevel:14.1 animated:YES];
    // 定位
    _mapView.showsUserLocation = YES;
    [_mapView setUserTrackingMode:MAUserTrackingModeFollow animated:YES];
    [self.view addSubview:_mapView];
    
    [_mapView addSubview:({
        UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, _mapView.height-0.5, _mapView.width, 0.5)];
        line.backgroundColor = HAC_DarkGray_Color;
        line;
    })];
    
    //长按屏幕，添加大头针
    UILongPressGestureRecognizer *longPressGesture = [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(handleLongPress:)];
    longPressGesture.delegate = self;
    longPressGesture.minimumPressDuration = 0.3;
    longPressGesture.allowableMovement = 50.0;
    [_mapView addGestureRecognizer:longPressGesture];
}

#pragma mark - MapView Delegate

- (void)mapView:(MAMapView *)mapView didUpdateUserLocation:(MAUserLocation *)userLocation updatingLocation:(BOOL)updatingLocation {
    
    if (updatingLocation && !_hasPoi) {
        
        _userLocation = userLocation;
        _coordinate = userLocation.location.coordinate;
        
        [self updateAnnotation];
        [self resetSearchState];
        [self beginPoiSearch];
        
        _hasPoi = YES;
    }
}

#pragma mark - SearchApi Delegate

// 实现POI搜索对应的回调函数
- (void)onPlaceSearchDone:(AMapPlaceSearchRequest *)request response:(AMapPlaceSearchResponse *)response {
    
    self.didSearched = YES;
    
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
    static NSString *CellID = @"PoiCellId";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellID];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle
                                      reuseIdentifier:CellID];
    }
    
    AMapPOI *poi = self.dataSource[indexPath.row];
    
    cell.textLabel.text = poi.name;
    cell.detailTextLabel.text = poi.address;
    cell.detailTextLabel.textColor = HAC_DarkGray_Color;
    cell.backgroundColor = HAC_Theme_Color;
    cell.separatorInset = UIEdgeInsetsMake(0, 20, 0, 20);
    cell.layoutMargins = cell.separatorInset;
    cell.selectedBackgroundView = ({
        UIView *view = [UIView new];
        view.backgroundColor = HAC_LightGray_Color;
        view;
    });
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (self.selectFrom) {
        HACPOIController *controller = [[HACPOIController alloc] init];
        // save
        AMapPOI *poi = self.dataSource[indexPath.row];
        SharedData().userInfo[@"start_name"] = poi.name;
        SharedData().userInfo[@"start_poi"] = poi;
        [self pushViewController:controller];
    } else {
        HACMapController *controller = [[HACMapController alloc] init];
        controller.startCoordinate = [HACMapUtility coordinateWithPOI:SharedData().userInfo[@"start_poi"]];
        AMapPOI *poi = self.dataSource[indexPath.row];
        controller.destinationCoordinate = [HACMapUtility coordinateWithPOI:poi];
        controller.destinationName = poi.name;
        SharedData().userInfo[@"end_name"] = poi.name;
        [self pushViewController:controller];
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    [self.textField resignFirstResponder];
}

#pragma mark - UITextField Deletate

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    if (SIMULATOR) {
        HACMapController *controller = [[HACMapController alloc] init];
        [self pushViewController:controller];
        
        return YES;
    }
    
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
    AMapPlaceSearchRequest *poiRequest = [[AMapPlaceSearchRequest alloc] init];
    poiRequest.searchType = AMapSearchType_PlaceAround;
    poiRequest.keywords = _keyword;
    poiRequest.location = [AMapGeoPoint locationWithLatitude:_coordinate.latitude longitude:_coordinate.longitude];
    poiRequest.requireExtension = YES;
    poiRequest.page = self.page;
    // 发起POI搜索
    [_searchApi AMapPlaceSearch:poiRequest];
}

- (void)setupDragEvents {
    // Header Refresh Logic
    self.tableView.header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        self.refreshType = LBSRefreshTypeReload;
        [self resetSearchState];
        [self beginPoiSearch];
    }];
    self.tableView.header.backgroundColor = HAC_Theme_Color;
    
    // Footer Refresh Logic
    self.tableView.footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        ++ self.page;
        self.refreshType = LBSRefreshTypeLoadMore;
        [self beginPoiSearch];
    }];
    self.tableView.footer.backgroundColor = HAC_Theme_Color;
}

// 清空搜索状态 关键字设为空 页面从1开始
- (void)resetSearchState {
    self.keyword = @"";
    self.page = 1;
}

- (void)handleLongPress:(UIGestureRecognizer *)gesture {
    if (gesture.state == UIGestureRecognizerStateBegan) {
        CGPoint touchPoint = [gesture locationInView:_mapView];
        _coordinate = [_mapView convertPoint:touchPoint toCoordinateFromView:_mapView];
        [self updateAnnotation];
        [self resetSearchState];
        [self beginPoiSearch];
    }
}

- (void)updateAnnotation {
    [_mapView removeAnnotation:self.annotation];
    self.annotation = [[MAPointAnnotation alloc] init];;
    self.annotation.coordinate = _coordinate;
    [_mapView addAnnotation:self.annotation];
}

- (MAAnnotationView *)mapView:(MAMapView *)mapView viewForAnnotation:(id <MAAnnotation>)annotation {
    if ([annotation isKindOfClass:[MAPointAnnotation class]]) {
        static NSString *pointReuseIndentifier = @"pointReuseIndentifier";
        MAPinAnnotationView *annotationView = (MAPinAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:pointReuseIndentifier];
        if (annotationView == nil) {
            annotationView = [[MAPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:pointReuseIndentifier];
        }
        annotationView.animatesDrop = YES;        //设置标注动画显示，默认为NO
        annotationView.pinColor = MAPinAnnotationColorRed;
        return annotationView;
    }
    return nil;
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    return YES;
}

@end
