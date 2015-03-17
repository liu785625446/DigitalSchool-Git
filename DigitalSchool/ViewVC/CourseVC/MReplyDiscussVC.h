//
//  MReplyDiscussVC.h
//  DigitalSchool
//
//  Created by rachel on 15/3/16.
//  Copyright (c) 2015年 刘军林. All rights reserved.
//
//  回复评论列表

#import "MBaseTableViewController.h"

@interface MReplyDiscussVC : MBaseTableViewController

@property(nonatomic,strong)NSString *discussId;
@property(nonatomic,assign)MPlayVideoType playType;


-(void)backAction:(id)sender;

@end
