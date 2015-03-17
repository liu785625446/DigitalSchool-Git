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

@interface MNavigationVC ()

@end

@implementation MNavigationVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _navsProcess = [[PLNavsProcess alloc] init];
    
    [_navsProcess getNavsList:^(NSMutableArray *array) {
        _navs_list = array;
        
        [self.collection reloadData];
    } didFail:^(NSString *error) {
        
    }];
    
//    _titleArray = @[@"名师课程",@"直播课程",@"校园电视台",@"专题",@"活动专区",@"教育咨询",@"获奖作品",@"微课程"];
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
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    
    if ([segue.identifier isEqualToString:@"MNavDetailsIdentifier"]) {
        NSIndexPath *indexPath = (NSIndexPath *)sender;
        MNavigationDetailsViewController *navDetails = segue.destinationViewController;
        navDetails.navs = [_navs_list objectAtIndex:indexPath.row];
    }
}

@end
