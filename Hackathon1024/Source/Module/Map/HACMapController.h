//
//  HACMapController.h
//  Hackathon1024
//
//  Created by cyan on 15/10/24.
//  Copyright © 2015年 cyan. All rights reserved.
//

#import "HACBaseController.h"
#import "HACMapUtility.h"

@interface HACMapController : HACBaseController

@property (nonatomic, assign) BOOL disableRightBarButton;
@property (nonatomic, copy) NSString *destinationName;
@property (nonatomic, assign) CLLocationCoordinate2D startCoordinate;
@property (nonatomic, assign) CLLocationCoordinate2D destinationCoordinate;
@property (nonatomic, copy) NSString *vehicleText;
@property (nonatomic, copy) NSString *timeText;

@end
