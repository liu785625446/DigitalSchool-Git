//
//  MNavigationVC.h
//  DigitalSchool
//
//  Created by xiaohj on 15-3-9.
//  Copyright (c) 2015年 刘军林. All rights reserved.
//

#import "MBaseViewController.h"


@interface MNavigationVC : MBaseViewController<UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>

@property (nonatomic, assign) IBOutlet UICollectionView *collection;

@property (nonatomic, strong) NSArray *titleArray;

@end
