//
//  MNavigationVC.h
//  DigitalSchool
//
//  Created by xiaohj on 15-3-9.
//  Copyright (c) 2015年 刘军林. All rights reserved.
//

#import "MBaseViewController.h"

@class PLNavsProcess;

@interface MNavigationVC : MBaseViewController<UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>

@property (nonatomic, assign) IBOutlet UICollectionView *collection;

@property (nonatomic, strong) NSArray *navs_list;

@property (nonatomic, strong) PLNavsProcess *navsProcess;

@end
