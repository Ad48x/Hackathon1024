//
//  AppNotifications.h
//  Hackathon1024
//
//  Created by cyan on 15/1/21.
//  Copyright (c) 2015年 FunCube. All rights reserved.
//  通知

#ifndef HAC_AppNotifications_h
#define HAC_AppNotifications_h

#define HACAddNotification(funSelector, notificationName)   [[NSNotificationCenter defaultCenter] addObserver:self selector:funSelector name:notificationName object:nil]

#define HACPostNotification(name)                           [[NSNotificationCenter defaultCenter] postNotificationName:name object:nil]

#define HACPostNotifcationWithObj(name, obj)                [[NSNotificationCenter defaultCenter] postNotificationName:name object:obj]

#define HACRemoveNotification(name)                         [[NSNotificationCenter defaultCenter] removeObserver:self name:name object:nil]

#define HACRemoveAllNotifications()                         [[NSNotificationCenter defaultCenter] removeObserver:self]

#define DELETE_CELL         @"DELETE_CELL"

#endif
