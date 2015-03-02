//
//  MBaseViewController.h
//  DigitalScholl
//
//  Created by rachel on 15/1/6.
//  Copyright (c) 2015年 刘军林. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MBaseViewController : UIViewController
{
    
}
#pragma mark- Action
-(void)ScreenAction:(id)item;
-(void)timeAction:(id)item;
-(void)seachAction:(id)item;

-(void) checkUserLogin;
@property (assign) CGRect baseRect;

@end
