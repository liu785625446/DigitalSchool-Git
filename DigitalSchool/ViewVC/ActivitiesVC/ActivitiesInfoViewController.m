//
//  ActivitiesInfoViewController.m
//  DigitalSchool
//
//  Created by 刘军林 on 15/1/17.
//  Copyright (c) 2015年 刘军林. All rights reserved.
//

#import "ActivitiesInfoViewController.h"
#import "ActivitiesInfoCellViewController.h"
#import "UrlImageView.h"
#import "PLActivityProcess.h"
#import "Toast+UIView.h"
#import "ActivityInfoCell.h"

@interface ActivitiesInfoViewController ()

@property (assign) CellStyle cellStyle;

@end

@implementation ActivitiesInfoViewController
@synthesize scrollview;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _activityProcess = [[PLActivityProcess alloc] init];
    
    CGRect rect = _tableTop.frame;
    rect.size.height = self.baseRect.size.width/2 + 36;
    rect.size.width = self.baseRect.size.width;
    _tableTop.frame = rect;

    NSArray *array = [NSArray array];
    if (_activity) {
        array = @[_activity.activityImg,_activity.activityImg,_activity.activityImg];
    }
    [self setScrollViewImg:array];
    
    // Do any additional setup after loading the view.
}

-(void) viewWillAppear:(BOOL)animated
{
    self.title = @"活动详情";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -
#pragma mark Action
-(void) setScrollViewImg:(NSArray *)array
{
    [self.scrollview setContentSize:CGSizeMake(self.baseRect.size.width * [array count], self.scrollview.frame.size.height)];
    for (int i=0 ; i<[array count] ; i++) {
        UrlImageView *image = [[UrlImageView alloc] initWithFrame:CGRectMake(i * self.baseRect.size.width, 0, self.baseRect.size.width, _tableTop.frame.size.height)];
        [image setImageWithURL:[NSURL URLWithString:array[i]] placeholderImage:nil];
        [self.scrollview addSubview:image];
     }
    _joinLabel.text = [NSString stringWithFormat:@"%@",_activity.activityJoinNum];
    _collectLabel.text = [NSString stringWithFormat:@"%@",_activity.activityCollectNum];
    [self.page setCurrentPage:0];
}

-(IBAction)uploadWorksAction:(id)sender
{
    if (![self checkUserLogin]) {
        return;
    }
    [self performSegueWithIdentifier:@"uploadWorksIdentifier" sender:nil];
}

-(IBAction)activityCollectAction:(id)sender
{
    if (![self checkUserLogin]) {
        return;
    }
    
    [_activityProcess activityCollect:_activity.activityId didUserID:@"1" didSuccess:^(NSMutableArray *array) {
        [self.view makeToast:@"收藏成功"];
    } didFail:^(NSString *error) {
        [self.view makeToast:@"收藏失败"];
    }];
}

#pragma mark -
#pragma mark UIScrollViewDelegate

-(void) scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    int off =  scrollView.contentOffset.x / self.baseRect.size.width;
    [self.page setCurrentPage:off];
}

#pragma mark -
#pragma mark UITableViewDelegate
-(NSInteger) numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 1;
    }else {
        return 5;
    }
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section == 1) {
        UIView *activitiesInfo = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 200, 20)];
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(20, 5, 200, 20)];
        label.text = @"活动详情";
        [activitiesInfo addSubview:label];
        return activitiesInfo;
    }else{
        return nil;
    }
}

-(CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 1) {
        return 30;
    }
    return 0.1;
}

-(CGFloat) tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.1;
}

-(CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 1 && indexPath.row == 0) {
//        UITableViewCell *cell = [self tableView:tableView cellForRowAtIndexPath:indexPath];
//        return cell.frame.size.height;
        return 135.f;
    }
    return 50.0f;
}

-(UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        static NSString *cellIdentifier = @"Cell";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
        
        cell.imageView.image = [UIImage imageNamed:@"ActivitiesInfoTime.png"];
        cell.textLabel.text = [NSString stringWithFormat:@"%@ - %@",_activity.activityStartTime, _activity.activityEndTime];
        cell.accessoryType = UITableViewCellAccessoryNone;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        return cell;
    }else{
        if (indexPath.row == 0) {
            static NSString *cellIdentifier = @"ActivitiesInfoCell";
            ActivityInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            [cell setActivity:_activity];
            return cell;
        }else{
            static NSString *cellIdentifier = @"Cell";
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            cell.textLabel.font = [UIFont systemFontOfSize:15.0f];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            if (indexPath.row == 1) {
                cell.textLabel.text = @"查看获奖作品";
                cell.textLabel.textColor = [UIColor colorWithHexString:MNavBarBarkGroundColor alpha:1];
            }else if(indexPath.row == 2) {
                cell.textLabel.text = @"查看全部作品";
                cell.textLabel.textColor = [UIColor colorWithHexString:MNavBarBarkGroundColor alpha:1];
            }else if (indexPath.row == 3) {
                cell.textLabel.text = @"查看全部评论";
                cell.textLabel.textColor = [UIColor colorWithHexString:MNavBarBarkGroundColor alpha:1];
            }else if (indexPath.row == 4) {
                cell.textLabel.text = @"对活动有疑问？请拨打010-123456咨询";
            }
            return cell;
        }
    }
}

-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 1) {
        if (indexPath.row == 1) {
            _cellStyle = WINNERWORKS;
            [self performSegueWithIdentifier:@"WorksOrComment" sender:nil];
        }else if (indexPath.row == 2) {
            _cellStyle = ALLWORKS;
            [self performSegueWithIdentifier:@"WorksOrComment" sender:nil];
        }else if (indexPath.row == 3) {
            _cellStyle = ALLCOMMENT;
            [self performSegueWithIdentifier:@"WorksOrComment" sender:nil];
        }else if (indexPath.row == 4) {
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"tel://18682048054"]];
        }
    }
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if ([segue.identifier isEqualToString:@"WorksOrComment"]) {
        ActivitiesInfoCellViewController *infoCell = segue.destinationViewController;
        infoCell.cellStyle = _cellStyle;
        infoCell.styleId = _activity.activityId;
    }
}


@end
