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

@interface MNavigationVC ()

@end

@implementation MNavigationVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _titleArray = @[@"名师课程",@"直播课程",@"校园电视台",@"专题",@"活动专区",@"教育咨询",@"获奖作品",@"微课程"];
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
    return [_titleArray count];
}

-(UICollectionViewCell *) collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"MNavIdentifier";
    MNavigationColl *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
    
    //    设置边框和背景
    if (indexPath.row < 3) {
        UIImageView *imgback = [[UIImageView alloc] initWithFrame:cell.frame];
        [imgback setImage:[[UIImage imageNamed:@"boxbg_left_upline.png"] stretchableImageWithLeftCapWidth:1 topCapHeight:1]];
        cell.backgroundView = imgback;
        
        UIImageView *selectImg = [[UIImageView alloc] initWithFrame:cell.frame];
        [selectImg setImage:[[UIImage imageNamed:@"boxbg_left_upline_over.png"] stretchableImageWithLeftCapWidth:1 topCapHeight:1]];
        cell.selectedBackgroundView = selectImg;
    }else{
        UIImageView *imgback = [[UIImageView alloc] initWithFrame:cell.frame];
        [imgback setImage:[[UIImage imageNamed:@"boxbg_left.png"] stretchableImageWithLeftCapWidth:1 topCapHeight:1]];
        cell.backgroundView = imgback;
        
        UIImageView *selectImg = [[UIImageView alloc] initWithFrame:cell.frame];
        [selectImg setImage:[[UIImage imageNamed:@"boxbg_left_over.png"] stretchableImageWithLeftCapWidth:1 topCapHeight:1]];
        cell.selectedBackgroundView = selectImg;
    }
    cell.navTitle.text = [_titleArray objectAtIndex:indexPath.row];
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

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    
    if ([segue.identifier isEqualToString:@"MNavDetailsIdentifier"]) {
        NSIndexPath *indexPath = (NSIndexPath *)sender;
        MNavigationDetailsViewController *navDetails = segue.destinationViewController;
        navDetails.titleStr = [_titleArray objectAtIndex:indexPath.row];
    }
}

@end
