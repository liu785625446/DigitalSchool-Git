//
//  MCommentViewController.m
//  DigitalSchool
//
//  Created by luc on 15-2-3.
//  Copyright (c) 2015年 刘军林. All rights reserved.
//

#import "MCommentViewController.h"
#import "PLDiscussProcess.h"
#import "PLNotesProcess.h"


@interface MCommentViewController ()

@property(nonatomic,strong)PLDiscussProcess *discussProcess;
@property(nonatomic,strong)PLNotesProcess *notesProcess;
@end

@implementation MCommentViewController
@synthesize comment = _comment;
@synthesize sizeLabel = _sizeLabel;

- (void)viewDidLoad
{
    [super viewDidLoad];
    textSize = 250;
    self.discussProcess = [[PLDiscussProcess alloc]init];
    self.notesProcess = [[PLNotesProcess alloc]init];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.comment resignFirstResponder];
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.comment becomeFirstResponder];
}
#pragma mark- UITextViewDelegate
- (void)textViewDidChange:(UITextView *)textView
{
    
}
- (void)textViewDidChangeSelection:(UITextView *)textView
{
    NSLog(@"==================%d",textView.text.length);
    NSInteger length = textSize - textView.text.length;
    [self setLabelSize:length];
}
-(void)setLabelSize:(NSInteger)length
{
    self.sizeLabel.text = [NSString stringWithFormat:@"%d",length];
}

-(IBAction)sendComment:(id)sender
{
    if ([self.sizeLabel.text intValue]>0)
    {
        [SVProgressHUD showWithStatus:@"正在发送中..."
                             maskType:SVProgressHUDMaskTypeBlack];
        
        if ([self.title isEqualToString:@"发评论"])
        {
            
            if (self.playVideoType == MPlayVideoTypeCourse)
            {
                //课程
                [self.discussProcess launchCourseDiscuss:self.courseId
                                               didUserId:@"1"
                                              didContent:self.comment.text
                                              didSuccess:^(NSMutableArray *array)
                 {
                     [self commentSuccess:@"评论成功"];
                     
                 } didFail:^(NSString *error) {
                     [self commentFail:@"评论失败"];
                 }];
                
            }else if(self.playVideoType == MPlayVideoTypeWorks)
            {
                //作品
                [self.discussProcess launchWorksDiscuss:self.courseId
                                              didUserId:@"1"
                                             didContent:self.comment.text
                                             didSuccess:^(NSMutableArray *array)
                {
                    [self commentSuccess:@"评论成功"];
                    
                } didFail:^(NSString *error) {
                    
                    [self commentFail:@"评论失败"];
                }];
                
            }else
            {
                //活动评论
                [self.discussProcess commentActivityDiscuss:self.courseId
                                                  didUserId:@"1"
                                                 didContent:self.comment.text
                                                 didSuccess:^(NSMutableArray *array)
                {
                    [self commentSuccess:@"评论成功"];
                    
                } didFail:^(NSString *error) {
                    
                    [self commentFail:@"评论失败"];
                }];
            }
            
        }else if([self.title isEqualToString:@"记笔记"])
        {//发表笔记
            
            [self.notesProcess noteWrite:@"1"
                             didCourseId:self.courseId
                              didContent:self.comment.text
                              didSuccess:^(NSMutableArray *array)
            {
                
                [self commentSuccess:@"记笔记成功"];
                
            } didFail:^(NSString *error) {
                
                [self commentFail:@"记笔记失败"];
                
            }];
        }else
        {
            //回复评论
            if (self.playVideoType == MPlayVideoTypeCourse)
            {
                //课程
                [self.discussProcess replyDiscuss:@"1"
                                       didDiscuss:self.courseId
                                       didContent:self.comment.text
                                       didSuccess:^(NSMutableArray *array)
                 {
                     
                     [self commentSuccess:@"回复评论成功"];
                     
                 } didFail:^(NSString *error) {
                     
                     [self commentFail:@"回复评论失败"];
                 }];
                
            }else
            {
                //作品
                [self.discussProcess replyWorks:@"1"
                                     didDiscuss:self.courseId
                                     didContent:self.comment.text
                                     didSuccess:^(NSMutableArray *array) {
                                         
                     [self commentSuccess:@"回复评论成功"];
                    
                } didFail:^(NSString *error) {
                    
                    [self commentFail:@"回复评论失败"];
                    
                }];
            }
        }
    }else
    {
        [self.view makeToast:[NSString stringWithFormat:@"最多只能输入%d字",textSize]];
    }
    
}
-(IBAction)cancel:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark- 操作(评论，记笔记，回复评论)成功
-(void)commentSuccess:(NSString*)messge
{
    [SVProgressHUD dismissWithSuccess:messge];
    [self dismissViewControllerAnimated:YES completion:nil];
}
#pragma mark- 操作(评论，记笔记，回复评论)失败
-(void)commentFail:(NSString*)messge
{
    [SVProgressHUD dismissWithError:messge];
}
@end
