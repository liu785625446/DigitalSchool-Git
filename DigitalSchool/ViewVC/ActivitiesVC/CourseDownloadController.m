//
//  ViewController.m
//  UploadVideo
//
//  Created by 刘军林 on 15/1/6.
//  Copyright (c) 2015年 刘军林. All rights reserved.
//

#import "CourseDownloadController.h"
#import "MCourseDownloadCell.h"
#import "BLCourseDownloadProcess.h"
#import "PLCourseDownload.h"

@interface CourseDownloadController ()

@end

@implementation CourseDownloadController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _downloadQueue = [[NSArray alloc] init];
    _selectQueue = [[NSMutableArray alloc] initWithCapacity:0];
    _courseProcess = [BLCourseDownloadProcess shareCourseDownload];
    _courseProcess.delegate = self;
    
    _toolBar = [[VCustomToolBar alloc] initWithTitiles:@[@"全选",@"删除"]];
    _toolBar.delegate = self;
    [self.view addSubview:_toolBar];
    
    PLCourseDownload *course = [[PLCourseDownload alloc] init];
    _downloadQueue = [_courseProcess findAllCourseDownload];
    course.downloadName = [NSString stringWithFormat:@"课程%lu",(unsigned long)[_downloadQueue count]];
    course.downloadURL = @"http://edu.360fis.com/edu/xsyy/xsyy2.mp4";
    course = [self getCoursePath:course];
    
    [_courseProcess addCourseDownload:course];
    _downloadQueue = [_courseProcess findAllCourseDownload];
    [self.table reloadData];
    
    [_courseProcess startRequestData];
//    [_courseProcess requestDownloadTaskQueueNext:nil];
//    http://edu.360fis.com/edu/xsyy/xsyy2.mp4
    
//    NSArray *array = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
//    NSString *cachesDirectory = array[0];
//    NSString *downLoadPath = [cachesDirectory stringByAppendingPathComponent:@"xsyy2.mp4"];
//    
//    NSString *path = @"/edu/xsyy/xsyy2.mp4";
//    MKNetworkEngine *engine = [[MKNetworkEngine alloc] initWithHostName:@"edu.360fis.com" customHeaderFields:nil];
//    
//    MKNetworkOperation *downloadOperation = [engine operationWithPath:path params:nil httpMethod:@"POST"];
//    [downloadOperation addDownloadStream:[NSOutputStream outputStreamToFileAtPath:downLoadPath append:YES]];
//    
//    [downloadOperation onDownloadProgressChanged:^(double progress){
//        NSLog(@"progress:%f",progress);
//        
//        NSData *data = [[NSData alloc] initWithContentsOfFile:downLoadPath];
//        NSLog(@"data:%d",[data length]);
//    }];
//    
//    [downloadOperation addCompletionHandler:^(MKNetworkOperation *operation){
//        
//    }errorHandler:^(MKNetworkOperation *operation, NSError *error){
//        
//    }];
//    
//    [engine enqueueOperation:downloadOperation];
//    
//    [self uploadImg];
    
    // Do any additional setup after loading the view, typically from a nib.
}


-(IBAction)editAction:(id)sender
{
    if (_toolBar.isShow) {
        [_toolBar hideToolbarAction];
        _tableBottom.constant = 0;
    }else{
        [_toolBar showToolbarAction];
        _tableBottom.constant = _toolBar.frame.size.height;
    }
    [self.table reloadData];
}

-(void) uploadImg
{
//    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
//    NSString *cachesDirectory = paths[0];
//    NSString *uploadURL = [cachesDirectory stringByAppendingPathComponent:@"xsyy.png"];
    
//    上传图片
//    NSString *url = [[NSBundle mainBundle] pathForResource:@"icon120_smart" ofType:@"png"];
//    
//    NSString *path = @"Icon/save_icon";
//    
//    MKNetworkEngine *engine = [[MKNetworkEngine alloc] initWithHostName:@"cloud.360fis.com" customHeaderFields:nil];
//    
//    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:@"10012",@"user_id",@"dab15afc664b4d16338a09984119424f054ac8e1b",@"token", nil];
//    MKNetworkOperation *operation = [engine operationWithPath:path params:dic httpMethod:@"POST"];
//    
//    [operation addFile:url forKey:@"file"];
//    [operation setFreezable:YES];
//    
//    [operation onUploadProgressChanged:^(double progress){
//        NSLog(@"progress:%f",progress);
//    }];
//    
//    [operation addCompletionHandler:^(MKNetworkOperation *op){
//        
//    }errorHandler:^(MKNetworkOperation *op, NSError *error){
//        
//    }];
//    
//    [engine enqueueOperation:operation];
    
}

-(PLCourseDownload *) getCoursePath:(PLCourseDownload *)course{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString *cachesDirectory = [paths objectAtIndex:0];
    course.downloadPath = [cachesDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"%@%@",course.downloadName,@".mp4"]];
    return course;
}

#pragma mark -
#pragma mark VCustomToolBarDelegate
-(void) customToolBar:(VCustomToolBar *)customToolBar didSelectIndex:(NSInteger)index
{
    if (index == 0) {
        if ([_selectQueue count] == [_downloadQueue count]) {
            _selectQueue = [[NSMutableArray alloc] initWithCapacity:0];
            [customToolBar setTitleMethod:@"全选" didIndex:index];
            [self.table reloadData];
        }else{
            _selectQueue = [NSMutableArray arrayWithArray:_downloadQueue];
            [customToolBar setTitleMethod:@"取消全选" didIndex:index];
            [self.table reloadData];
        }
        if ([_selectQueue count] == 0) {
            [_toolBar setTitleMethod:@"删除" didIndex:1];
        }else{
            [_toolBar setTitleMethod:[NSString stringWithFormat:@"删除(%d)",[_selectQueue count]] didIndex:1];
        }
    }else{
        [_courseProcess deleteCourseDownloadTaskQueue:_selectQueue];
        _downloadQueue = [_courseProcess findAllCourseDownload];
        [self.table reloadData];
    }
}

#pragma mark -
#pragma mark Action
-(IBAction)addCourseTask:(id)sender
{

}

#pragma mark -
#pragma mark BLCourseDownloadDelegate
-(void) courseDownload:(PLCourseDownload *)courseDownload didTotalSize:(double)totalSize didDownloadSize:(double)downloadSize
{
    PLCourseDownload *currentCourse = nil;
    int row = -1;
    for (int i=0 ; i<[self.downloadQueue count] ; i++) {
        PLCourseDownload *temp = [self.downloadQueue objectAtIndex:i];
        if ([temp.downloadPath isEqualToString:courseDownload.downloadPath]) {
            currentCourse = temp;
            row = i;
            break;
        }
    }
    
    currentCourse.totalSize = totalSize;
    currentCourse.downloadSize = downloadSize;
    currentCourse.downloadStatus = courseDownload.downloadStatus;
    if (row>=0) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:row inSection:0];
        [self.table reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
    }
}

#pragma mark -
#pragma mark UITableViewDelegate
-(NSInteger) numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_downloadQueue count];
}

-(CGFloat) tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.1;
}

-(CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.1;
}

-(CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60.0f;
}

-(UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"MCourseDownloadCell";
    MCourseDownloadCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];

    PLCourseDownload *course = [self.downloadQueue objectAtIndex:indexPath.row];
    cell.courseName.text = course.downloadName;
    if (_toolBar.isShow) {
        cell.selectImgWidth.constant = 15;
    }else{
        cell.selectImgWidth.constant = 0;
    }
    
    if ([_selectQueue containsObject:course]) {
        cell.selectStatus.image = [UIImage imageNamed:@"downloadSelect.png"];
    }else{
        cell.selectStatus.image = [UIImage imageNamed:@"downloadNoSelect.png"];
    }
    
    if (course.downloadStatus == downloadComplete || (course.downloadSize == course.totalSize && course.totalSize > 0)) {
        cell.downloadInfo.text = @"下载成功";
        cell.courseProgress.progress = 1;
        cell.downloadStatus.image = [UIImage imageNamed:@"downloadSelect.png"];
    }else if (course.downloadStatus == downloadIng) {
        cell.courseProgress.progress = course.downloadSize / course.totalSize;
        cell.downloadInfo.text = [NSString stringWithFormat:@"%.1fM/%.1fM", course.downloadSize/1000000, course.totalSize/1000000];
        cell.downloadStatus.image = [UIImage imageNamed:@"downloadIng.png"];
        
    }else if (course.downloadStatus == downloadWait) {
        cell.downloadInfo.text = @"等待下载";
        if (course.downloadSize > 0) {
            cell.courseProgress.progress = course.downloadSize / course.totalSize;
        }else{
//            cell.courseProgress.progress = 0;
        }
        cell.downloadStatus.image = [UIImage imageNamed:@"downloadIng.png"];
    }else if (course.downloadStatus == downloadPause) {
        cell.downloadInfo.text = @"暂停";
        cell.downloadStatus.image = [UIImage imageNamed:@"downloadPause.png"];
        if (course.downloadSize > 0) {
            cell.courseProgress.progress = course.downloadSize / course.totalSize;
        }else{
            cell.courseProgress.progress = 0;
        }
    }

    return cell;
}

-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    PLCourseDownload *course = [_downloadQueue objectAtIndex:indexPath.row];
    if (_toolBar.isShow) {
        if ([_selectQueue containsObject:course]) {
            [_selectQueue removeObject:course];
        }else{
            [_selectQueue addObject:course];
        }
        
        if ([_selectQueue count] != [_downloadQueue count]) {
            [_toolBar setTitleMethod:@"全选" didIndex:0];
        }else{
            [_toolBar setTitleMethod:@"取消全选" didIndex:0];
        }
        [_toolBar setTitleMethod:[NSString stringWithFormat:@"删除(%d)",[_selectQueue count]] didIndex:1];
        [self.table reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
        
    }else{
        if (course.downloadStatus == downloadIng) {
            [_courseProcess pauseRequestDownloadTaskQueue:course];
        }else if (course.downloadStatus == downloadPause || course.downloadStatus == downloadWait){
            [_courseProcess priorityRequestDownloadTaskQueue:course];
        }
    }
//    if (_toolBar.isShow) {
//        if ([_selectQueue containsObject:course]) {
//            [_selectQueue removeObject:course];
//            [_toolBar setTitleMethod:@"全选" didIndex:0];
//        }else{
//            [_selectQueue addObject:course];
//        }
//        [self.table reloadData];
//    }else{
//        if (course.downloadStatus == downloadIng) {
//            [_courseProcess pauseRequestDownloadTaskQueue:course];
//        }else if(course.downloadStatus == downloadWait) {
//            [_courseProcess priorityRequestDownloadTaskQueue:course];
//        }else if (course.downloadStatus == downloadPause) {
//            [_courseProcess priorityRequestDownloadTaskQueue:course];
//        }
//    }
}

-(UITableViewCellEditingStyle) tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewCellEditingStyleDelete;
}

-(void) tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {

        [_courseProcess deleteCourseDownloadTaskQueue:@[[_downloadQueue objectAtIndex:indexPath.row]]];
        
        PLCourseDownload *course = [_downloadQueue objectAtIndex:indexPath.row];
        [_courseProcess removeCourseDownload:course];
        _downloadQueue = [_courseProcess findAllCourseDownload];
        
        [self.table deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
        [self.table reloadData];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
