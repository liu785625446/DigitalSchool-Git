//
//  MUpdatePwdTableViewController.m
//  DigitalSchool
//
//  Created by 刘军林 on 15/3/9.
//  Copyright (c) 2015年 刘军林. All rights reserved.
//

#import "MUpdatePwdTableViewController.h"

@interface MUpdatePwdTableViewController ()

@end

static BOOL isHud1 = NO;

@implementation MUpdatePwdTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _pwd1.clearButtonMode = UITextFieldViewModeWhileEditing;
    _pwd2.clearButtonMode = UITextFieldViewModeWhileEditing;
    _pwd3.clearButtonMode = UITextFieldViewModeWhileEditing;
    
    _userProcess = [[PLUserProcess alloc] init];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) showMyHUD:(NSString *)msg
{
    isHud1 = YES;
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        sleep(10);
        dispatch_async(dispatch_get_main_queue(), ^{
            if (isHud1) {
                [self showFailHUD:@"连接失败!"];
            }
        });
    });
    [SVProgressHUD showWithStatus:msg maskType:SVProgressHUDMaskTypeBlack];
}

-(void) showSuccessHUD:(NSString *)msg
{
    isHud1 = NO;
    [SVProgressHUD dismissWithSuccess:msg afterDelay:1.0];
}

-(void) showFailHUD:(NSString *)msg
{
    isHud1 = NO;
    [SVProgressHUD dismissWithError:msg afterDelay:1.0];
}

-(void) hideMyHUD
{
    isHud1 = NO;
    [SVProgressHUD dismiss];
}


-(IBAction)updatePwdAction:(id)sender
{
    if ([_pwd1.text length] < 6 || [_pwd2.text length] < 6 || [_pwd3.text length] < 6) {
        [self.tableView makeToast:@"请输入不少于六位数密码"];
        return;
    }

    if (![_pwd2.text isEqualToString:_pwd3.text]) {
        [self.tableView makeToast:@"确认密码输入不匹配"];
        return;
    }
    
    [self showMyHUD:@"修改中..."];
    [_userProcess modifyPassword:_current_user.userId didOldPassword:_pwd1.text didNewPassword:_pwd2.text didSuccess:^(NSMutableArray *array) {
        [self showSuccessHUD:@"修改成功"];
        [self.navigationController popViewControllerAnimated:YES];
    } didFail:^(NSString *error) {
        [self showFailHUD:error];
    }];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return 3;
}

-(CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10.0f;
}

/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}
*/

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
