//
//  AppStyles.h
//  Hackathon1024
//
//  Created by cyan on 15/2/18.
//  Copyright (c) 2015年 cyan. All rights reserved.
//

#ifndef HAC_AppStyles_h
#define HAC_AppStyles_h

#define HAC_Theme_Color         [UIColor cloudsColor]
#define HAC_Gray_Color          HexColor(0xdddddd)
#define HAC_LightGray_Color     HexColor(0xdedede)
#define HAC_DarkGray_Color      HexColor(0x6a6a6a)
#define HAC_Black_Color         [UIColor blackColor]
#define HAC_White_Color         [UIColor whiteColor]
#define HAC_Red_Color           [UIColor alizarinColor]

#define LightFont(_size)        (IS_OS_9_OR_LATER ? [UIFont systemFontOfSize:_size weight:UIFontWeightLight] : [UIFont fontWithName:@"HelveticaNeue-Light" size:_size])
#define ThinFont(_size)         (IS_OS_9_OR_LATER ? [UIFont systemFontOfSize:_size weight:UIFontWeightThin] : [UIFont fontWithName:@"HelveticaNeue-Thin" size:_size])
#define RegularFont(_size)      [UIFont fontWithName:@"AvenirNext-Regular" size:_size]
#define MediumFont(_size)       [UIFont fontWithName:@"AvenirNext-Medium" size:_size]

#define HAC_STATUS_BAR_HEIGHT   (20)
#define HAC_NAV_BAR_HEIGHT      (44+STATUS_BAR_HEIGHT)

#define HAC_FONT_SIZE_SMALL     (12)
#define HAC_FONT_SIZE_MEDIUM    (15)
#define HAC_FONT_SIZE_LARGE     (18)
#define HAC_M5                  (5)
#define HAC_M8                  (8)
#define HAC_M10                 (10)

#define HAC_Cell_Margin         ((IS_IPAD && IS_OS_9_OR_LATER)? 48 : (IS_IPHONE6_PLUS ? 20: 15))
#define HAC_Cell_Height         (44)

#endif
