//
//  MNavigationVC.m
//  DigitalSchool
//
//  Created by xiaohj on 15-3-9.
//  Copyright (c) 2015年 刘军林. All rights reserved.
//

#import "MNavigationVC.h"
#import "MNavigationColl.h"
#import "MNavigationDetailsViewController.h"
#import "PLNavsProcess.h"
#import "PLNavs.h"

#import "YYAnimationIndicator.h"

@interface MNavigationVC ()<YYAnimationDelegate>
{
    YYAnimationIndicator *yyAnimation;
}
@end

@implementation MNavigationVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _navsProcess = [[PLNavsProcess alloc] init];
    
    CGRect animationR = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    yyAnimation = [[YYAnimationIndicator alloc]initWithFrame:animationR];
    yyAnimation.delegate = self;
    [yyAnimation setLoadText:@"正在加载中..."];
    [self.view addSubview:yyAnimation];
    
    [self getNavDatas];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
   
}

#pragma mark -
#pragma mark UICollectionViewDelegate
-(NSInteger) numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

-(NSInteger) collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [_navs_list count];
}

-(UICollectionViewCell *) collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"MNavIdentifier";
    MNavigationColl *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
    
    UIView *selectBackGroundView = [[UIView alloc] initWithFrame:cell.frame];
    selectBackGroundView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    cell.selectedBackgroundView = selectBackGroundView;
    cell.index = indexPath.row;
    PLNavs *navs = [_navs_list objectAtIndex:indexPath.row];
    [cell setNavs:navs];
    return cell;
}

-(CGSize) collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CGRect rect = self.view.frame;
    float width = rect.size.width/3;
    return CGSizeMake(width, width);
}

-(UIEdgeInsets) collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(0, 0, 0, 0);
}

-(void) collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    [collectionView deselectItemAtIndexPath:indexPath animated:YES];
    [self performSegueWithIdentifier:@"MNavDetailsIdentifier" sender:indexPath];
}

#pragma mark - Navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"MNavDetailsIdentifier"])
    {
        NSIndexPath *indexPath = (NSIndexPath *)sender;
        MNavigationDetailsViewController *navDetails = segue.destinationViewController;
        navDetails.navs = [_navs_list objectAtIndex:indexPath.row];
    }
}

#pragma mark- 
-(void)getNavDatas
{
    if (_navs_list.count<=0) {
        [yyAnimation startAnimation];
    }
    [_navsProcess getNavsList:^(NSMutableArray *array)
     {
        _navs_list = array;
        if (_navs_list.count<=0)
        {
            [yyAnimation stopAnimationWithLoadText:@"暂无相关数据,点击屏幕重现加载!" withType:NO loadType:MLoadTypeFail];
            
        }else
        {
            [yyAnimation stopAnimationWithLoadText:@"" withType:YES];
        }
        
        [self.collection reloadData];
        
    } didFail:^(NSString *error)
     {
         [yyAnimation stopAnimationWithLoadText:YYFailReloadText withType:NO loadType:MLoadTypeFail];
    }];
}

#pragma mark- YYAnimationDelegate
-(void)didReloadData:(YYAnimationIndicator *)animationView
{
    [self getNavDatas];
}

@end
