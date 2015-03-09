//
//  MUserInfoViewController.m
//  DigitalSchool
//
//  Created by 刘军林 on 15/3/9.
//  Copyright (c) 2015年 刘军林. All rights reserved.
//

#import "MUserInfoViewController.h"
#import "PLUser.h"
#import "MUserInfoCell.h"
#import "UrlImageView.h"
#import "PLUserProcess.h"
//#import "MPwdModifyView.h"
#import "MUpdatePwdTableViewController.h"

@interface MUserInfoViewController ()

@end

@implementation MUserInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _userProcess = [[PLUserProcess alloc] init];
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
    return 4;
}

-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

-(CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return 100.f;
    }else{
        return 50.0f;
    }
}

-(CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 5.0f;
}

-(CGFloat) tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 5.0f;
}

-(UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        static NSString *cellIdentifier = @"MUserInfoImgCellIdentifier";
        
        MUserInfoImgCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
        [cell.mUserInfoImg setImageWithURL:[NSURL URLWithString:_user_info.userImg] placeholderImage:[UIImage imageNamed:@"ActivitiesInfoHead1.png"]];
        
        return cell;
    }else if (indexPath.section == 1 ) {
        static NSString *cellIdentifier = @"MUserInfoCellIdentifier";
        MUserInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
        
        cell.mUserCellName.text = @"用户名";
        cell.mUserCellValue.text = _user_info.userName;
        cell.right.constant = 10;
        cell.accessoryType = UITableViewCellAccessoryNone;
        return cell;
    }else if (indexPath.section == 2) {
        static NSString *cellIdentifier = @"MUserInfoCellIdentifier";
        MUserInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
        cell.mUserCellName.text = @"昵称";
        cell.mUserCellValue.text = _user_info.userNickName;
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        return cell;
    }else{
        static NSString *cellIdentifier = @"MUserInfoCellIdentifier";
        MUserInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
        cell.mUserCellName.text = @"密码";
        cell.mUserCellValue.text = @"";
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        return cell;
    }
}

-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.section == 0) {
        UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:@"选择"
                                                           delegate:self
                                                  cancelButtonTitle:@"取消"
                                             destructiveButtonTitle:nil
                                                  otherButtonTitles:@"拍照",@"从相册中选择", nil];
        [sheet showInView:self.view];
    }else if (indexPath.section == 2) {
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"昵称修改" message:@"" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        alert.alertViewStyle = UIAlertViewStylePlainTextInput;
        [alert show];
        
    }else if (indexPath.section == 3) {
        
        [self performSegueWithIdentifier:@"UpdatePwdIdentifier" sender:nil];
//        MPwdModifyView *pwdmodify = [[MPwdModifyView alloc] initWithTitle:@"密码修改" message:nil delegate:self cancelButtonTitle:@"确定" otherButtonTitles:@"取消", nil];
//        [pwdmodify show];
    }
}

#pragma mark -
#pragma mark UIActionSheetDelegate
-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSUInteger sourceType = 0;
    if (buttonIndex == 0) {
        sourceType = UIImagePickerControllerSourceTypeCamera;
    }else if (buttonIndex == 1){
        sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    }else{
        return;
    }
    
    UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
    imagePicker.delegate = self;
    imagePicker.allowsEditing = YES;
    imagePicker.sourceType = sourceType;
    [self presentViewController:imagePicker animated:YES completion:nil];
}

#pragma mark -
#pragma mark UIImagePickerControllerDelegate
-(void) imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    [picker dismissViewControllerAnimated:YES completion:nil];
    UIImage *image = [info objectForKey:UIImagePickerControllerEditedImage];
    NSData *imageData = UIImageJPEGRepresentation(image, 0.5);
    
    [_userProcess uploadHeadImg:_user_info.userId didHeadImg:imageData didSuccess:^(NSMutableArray *array) {
        
    } didFail:^(NSString *error) {
        
    }];
}

#pragma mark -
#pragma mark UIAlertViewDelegate
-(void) alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1) {
        UITextField *textfielt = [alertView textFieldAtIndex:0];
        
        [self showMyHUD:@"修改中..."];
        [_userProcess modifyNickName:textfielt.text didUserId:_user_info.userId didSuccess:^(NSMutableArray *array) {
            _user_info.userNickName = textfielt.text;
            NSUserDefaults *users = [NSUserDefaults standardUserDefaults];
            NSData *userData = [NSKeyedArchiver archivedDataWithRootObject:_user_info];
            [users setObject:userData forKey:CURRENT_USER];
            [users synchronize];
            [self showSuccessHUD:@"修改成功"];
            [self.baseTableView reloadData];
        } didFail:^(NSString *error) {
            [self showFailHUD:error];
        }];
    }
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    
    if ([segue.identifier isEqualToString:@"UpdatePwdIdentifier"]) {
        MUpdatePwdTableViewController *updatePwd = segue.destinationViewController;
        updatePwd.current_user = _user_info;
    }
}


@end
