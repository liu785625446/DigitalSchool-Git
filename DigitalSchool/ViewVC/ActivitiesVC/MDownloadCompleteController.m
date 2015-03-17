//
//  MDownloadCompleteController.m
//  DigitalSchool
//
//  Created by 刘军林 on 15/3/16.
//  Copyright (c) 2015年 刘军林. All rights reserved.
//

#import "MDownloadCompleteController.h"
#import "PLCourseDownload.h"

@interface MDownloadCompleteController ()

@end

@implementation MDownloadCompleteController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -
#pragma mark UITableViewDelegate
-(NSInteger) numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_download_list count];
}

-(UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DownloadIdentifier" forIndexPath:indexPath];
    PLCourseDownload *courseDownload = [_download_list objectAtIndex:indexPath.row];
    cell.textLabel.text = courseDownload.downloadName;
    return cell;
}

-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
