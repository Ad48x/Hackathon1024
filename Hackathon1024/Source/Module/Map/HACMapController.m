//
//  HACMapController.m
//  Hackathon1024
//
//  Created by cyan on 15/10/24.
//  Copyright © 2015年 cyan. All rights reserved.
//

#import "HACMapController.h"
#import "MANaviRoute.h"
#import "CommonUtility.h"
#import "LineDashPolyline.h"
#import "HACTypeController.h"

#define MapStrokeColor  RGB(21, 126, 251)
#define MapFillColor    RGBA(21, 126, 251, 0.3)
#define BOTTOM_HEIGHT       (128.0)

@interface HACMapController()<UINavigationBarDelegate, MAMapViewDelegate, AMapSearchDelegate>

@property (nonatomic, strong) MAMapView *mapView;
@property (nonatomic, strong) AMapSearchAPI *searchApi;
@property (nonatomic, strong) MAUserLocation *userLocation;
@property (nonatomic, strong) NSMutableArray *annotations;

@property (nonatomic, strong) AMapRoute *route;
@property (nonatomic, strong) MANaviRoute *naviRoute;

@property (nonatomic, strong) MAAnnotationView *userLocationAnnotationView;
@property (nonatomic, strong) FUISegmentedControl *segmentControl;
@property (nonatomic, assign) MANaviType naviType;

@end

@implementation HACMapController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Annotation
    self.annotations = [NSMutableArray array];
    MAPointAnnotation *annotation = [[MAPointAnnotation alloc] init];
    annotation.coordinate = self.destinationCoordinate;
    annotation.title = (self.destinationName.length > 0 ? self.destinationName : @"目标地点");
    [self.annotations addObject:annotation];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    self.title = @"路径规划";
    
    if (!self.disableRightBarButton) {
        @weakify(self);
        [self setRightBarButtonWithTitle:@"下一步" action:^(id sender) {
            @strongify(self)
            // save
            SharedData().userInfo[@"start_latitude"] = @(self.startCoordinate.latitude);
            SharedData().userInfo[@"start_longitude"] = @(self.startCoordinate.longitude);
            SharedData().userInfo[@"end_latitude"] = @(self.destinationCoordinate.latitude);
            SharedData().userInfo[@"end_longitude"] = @(self.destinationCoordinate.longitude);
            // choose type
            HACTypeController *controller = [[HACTypeController alloc] init];
            [self pushViewController:controller];
        }];
    }
    
    // ApiKey
    [MAMapServices sharedServices].apiKey = kHACMapApiKey;
    
    // View
    self.mapView = [[MAMapView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, self.view.height-BOTTOM_HEIGHT)];
    if (self.disableRightBarButton) {
        [self initBottomView];
    } else {
        [self addPathView];
    }
    
    self.mapView.delegate = self;
    self.mapView.showsUserLocation = YES;
    [self.mapView setUserTrackingMode:MAUserTrackingModeFollow animated:YES];
    
    [self.mapView setZoomLevel:14.1 animated:YES];
    [self.mapView addAnnotations:self.annotations];
    
    [self.view addSubview:self.mapView];
    
    // 路径规划
    self.naviType = MANaviType_Walking;
    self.searchApi = [[AMapSearchAPI alloc] initWithSearchKey:kHACMapApiKey Delegate:self];
    [self searchNaviWalking];
    
    self.segmentControl = [[FUISegmentedControl alloc] initWithItems:@[ @"步行", @"驾车", @"公交" ]];
    self.segmentControl.deselectedColor = [UIColor concreteColor];
    self.segmentControl.selectedColor = [UIColor asbestosColor];
    [self.segmentControl addTarget:self action:@selector(didSegmentControlChanged:) forControlEvents:UIControlEventValueChanged];
    [self.segmentControl setSelectedSegmentIndex:0];
    [self.view addSubview:self.segmentControl];
    [self.segmentControl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.equalTo(20 + FF_NAV_BAR_HEIGHT);
        make.size.equalTo(CGSizeMake(64*3, 32));
    }];
}



- (void)didSegmentControlChanged:(UISegmentedControl *)sender {
    if (sender.selectedSegmentIndex == 0) {
        [self searchNaviWalking];
    } else if (sender.selectedSegmentIndex == 1) {
        [self searchNaviDrive];
    } else {
        [self searchNaviBus];
    }
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    
    self.mapView.delegate = nil;
    [self.mapView removeFromSuperview];
    self.mapView = nil;
}

- (void)searchNaviType:(AMapSearchType)type {
    
    AMapNavigationSearchRequest *navi = [[AMapNavigationSearchRequest alloc] init];
    navi.searchType = type;
    navi.requireExtension = YES;
    navi.origin = [AMapGeoPoint locationWithLatitude:self.startCoordinate.latitude
                                           longitude:self.startCoordinate.longitude];
    navi.destination = [AMapGeoPoint locationWithLatitude:self.destinationCoordinate.latitude
                                                longitude:self.destinationCoordinate.longitude];
    
    [self.searchApi AMapNavigationSearch:navi];
}

- (void)searchNaviWalking {
    self.naviType = MANaviType_Walking;
    [self searchNaviType:AMapSearchType_NaviWalking];
}

- (void)searchNaviDrive {
    self.naviType = MANaviType_Drive;
    [self searchNaviType:AMapSearchType_NaviDrive];
}

- (void)searchNaviBus {
    self.naviType = MANaviType_Bus;
    [self searchNaviType:AMapSearchType_NaviBus];
}

#pragma mark - MapView Delegate

- (void)mapView:(MAMapView *)mapView didUpdateUserLocation:(MAUserLocation *)userLocation updatingLocation:(BOOL)updatingLocation {
    _userLocation = userLocation;
    
    if (!updatingLocation && self.userLocationAnnotationView != nil) {
        [UIView animateWithDuration:0.1 animations:^{
            double degree = userLocation.heading.trueHeading;
            self.userLocationAnnotationView.transform = CGAffineTransformMakeRotation(degree * M_PI / 180.f );
        }];
    }
}

- (MAOverlayRenderer *)mapView:(MAMapView *)mapView rendererForOverlay:(id<MAOverlay>)overlay {
    
    if ([overlay isKindOfClass:[MAPolyline class]]) {
        MAPolylineRenderer *polylineRenderer = [[MAPolylineRenderer alloc] initWithPolyline:overlay];
        
        polylineRenderer.lineWidth   = 8;
        polylineRenderer.strokeColor = MapStrokeColor;
        
        return polylineRenderer;
    }
    
    return nil;
}

- (MAAnnotationView *)mapView:(MAMapView *)mapView viewForAnnotation:(id<MAAnnotation>)annotation {
    if ([annotation isKindOfClass:[MAPointAnnotation class]]) {
        static NSString *pointReuseIndetifier = @"pointReuseIndetifier";
        MAPinAnnotationView *annotationView = (MAPinAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:pointReuseIndetifier];
        
        if (annotationView == nil) {
            annotationView = [[MAPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:pointReuseIndetifier];
        }
        
        annotationView.canShowCallout = YES;
        annotationView.animatesDrop = YES;
        annotationView.pinColor = MAPinAnnotationColorRed;
        return annotationView;
    }
    return nil;
}

- (void)mapView:(MAMapView *)mapView didAddAnnotationViews:(NSArray *)views {
    
    [views enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        if ([obj isKindOfClass:[MAAnnotationView class]]) {
            MAAnnotationView *view = (MAAnnotationView *)obj;
            
            if ([view.annotation isKindOfClass:[MAUserLocation class]]) {
                MAUserLocationRepresentation *pre = [[MAUserLocationRepresentation alloc] init];
                pre.fillColor = MapFillColor;
                pre.strokeColor = MapStrokeColor;
                pre.image = [UIImage imageNamed:@"userPosition"];
                pre.lineWidth = 1;

                [self.mapView updateUserLocationRepresentation:pre];
                
                view.calloutOffset = CGPointMake(0, 0);
                view.canShowCallout = NO;
                self.userLocationAnnotationView = view;
            }
        }
    }];
}

- (void)onNavigationSearchDone:(AMapNavigationSearchRequest *)request response:(AMapNavigationSearchResponse *)response {
    [self.naviRoute removeFromMapView];
    self.route = response.route;
    MANaviType type = self.naviType;
    self.naviRoute = [MANaviRoute naviRouteForPath:self.route.paths[0] withNaviType:type];
    [self.naviRoute setNaviAnnotationVisibility:NO];
    [self.naviRoute addToMapView:self.mapView];
    MAMapRect rect = [CommonUtility mapRectForOverlays:self.naviRoute.routePolylines];
    [self.mapView setVisibleMapRect:rect animated:YES];
    [self.mapView setZoomLevel:(int)(self.mapView.zoomLevel - 0.5) + 0.1];
}

- (void)initBottomView {
    UIView *bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, self.mapView.bottom, self.view.width, BOTTOM_HEIGHT)];
    bottomView.backgroundColor = [UIColor concreteColor];
    [self.view addSubview:bottomView];

    UILabel *label1 = [[UILabel alloc] init];
    label1.textColor = [UIColor whiteColor];
    label1.font = RegularFont(15);
    label1.text = [NSString stringWithFormat:@"时间区间: %@", self.timeText ?: @""];
    [bottomView addSubview:label1];
    [label1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(bottomView);
        make.left.equalTo(20);
        make.top.equalTo(0);
        make.height.equalTo(BOTTOM_HEIGHT/2);
    }];
    
    UILabel *label2 = [[UILabel alloc] init];
    label2.textColor = [UIColor whiteColor];
    label2.font = RegularFont(15);
    label2.text = [NSString stringWithFormat:@"交通方式: %@", self.vehicleText ?: @""];
    [bottomView addSubview:label2];
    [label2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(bottomView);
        make.left.equalTo(label1);
        make.top.equalTo(label1.mas_bottom);
        make.height.equalTo(label1);
    }];
    
    UIView *line = [[UIView alloc] init];
    line.backgroundColor = [UIColor asbestosColor];
    [bottomView addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(label1);
        make.right.equalTo(-20);
        make.height.equalTo(0.5);
        make.centerY.equalTo(label1.mas_bottom);
    }];
    
    UIView *line2 = [[UIView alloc] init];
    line2.backgroundColor = [UIColor asbestosColor];
    [bottomView addSubview:line2];
    [line2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(bottomView);
        make.height.equalTo(0.5);
        make.top.equalTo(bottomView);
    }];
}

- (void)addPathView {
    UIView *bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, self.mapView.bottom, self.view.width, BOTTOM_HEIGHT)];
    bottomView.backgroundColor = [UIColor concreteColor];
    [self.view addSubview:bottomView];
    UIView *line2 = [[UIView alloc] init];
    line2.backgroundColor = [UIColor asbestosColor];
    [bottomView addSubview:line2];
    [line2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(bottomView);
        make.height.equalTo(0.5);
        make.top.equalTo(bottomView);
    }];
    
    UILabel *label1 = [[UILabel alloc] init];
    label1.textColor = [UIColor whiteColor];
    label1.font = RegularFont(20);
    label1.textAlignment = NSTextAlignmentCenter;
    label1.text = [NSString stringWithFormat:@"时间区间: %@", self.timeText ?: @""];
    [bottomView addSubview:label1];
    [label1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(bottomView);
        make.left.equalTo(20);
        make.top.bottom.equalTo(bottomView);
    }];
    label1.text = [NSString stringWithFormat:@"%@ - %@", SharedData().userInfo[@"start_name"], SharedData().userInfo[@"end_name"]];
}

@end
