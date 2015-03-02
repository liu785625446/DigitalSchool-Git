//
//  Macro.h
//  DigitalScholl
//
//  Created by rachel on 15/1/8.
//  Copyright (c) 2015年 刘军林. All rights reserved.
//

#ifndef DigitalScholl_Macro_h
#define DigitalScholl_Macro_h

typedef enum{
    
    MPlayVideoTypeCourse = 0, //课程
    MPlayVideoTypeWorks,  //(作品)
    MPlayVideoTypeActivities //活动
    
}MPlayVideoType;

#define KDeviceVersion   [[[UIDevice currentDevice]systemVersion]floatValue]
#define kMainWindowBouns [[UIScreen mainScreen] bounds]

#define MRGBA_COLOR(R, G, B, A) [UIColor colorWithRed:((R) / 255.0f) green:((G) / 255.0f) blue:((B) / 255.0f) alpha:A]
#define MRGB_COLOR(R, G, B) [UIColor colorWithRed:((R) / 255.0f) green:((G) / 255.0f) blue:((B) / 255.0f) alpha:1.0f]

#define MViewBackGroudColor @"#FAFAFA"
#define MListBarkGroundColor @"#E7DFD9"
#define MNavBarBarkGroundColor @"06AC41"

#define MTitleColor @"#9AD6A2"


#define MPageSize 15


#endif
