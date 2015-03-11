//
//  MUploadWorksViewController.m
//  DigitalSchool
//
//  Created by 刘军林 on 15/1/19.
//  Copyright (c) 2015年 刘军林. All rights reserved.
//

#import "MUploadWorksViewController.h"
#import <MobileCoreServices/UTCoreTypes.h>
#import <AssetsLibrary/AssetsLibrary.h>
#import <AVFoundation/AVFoundation.h>

#import "PLWorkProcess.h"

@interface MUploadWorksViewController ()
<UIImagePickerControllerDelegate,UINavigationControllerDelegate>

@end

@implementation MUploadWorksViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.worksName becomeFirstResponder];
    _keyboard = [[UIKeyboardViewController alloc] initWithControllerDelegate:self];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark -Action
-(IBAction)uploadComplete:(id)sender
{
    [self checkUserLogin];
//    [self dismissViewControllerAnimated:YES completion:nil];
    
    if (self.worksName.text.length<=0)
    {
        [self.view makeToast:@"请输入作品名称"];
        
    }else if (self.infoTextView.text.length<=0)
    {
        [self.view makeToast:@"请输入作品简介"];
        
    }else if (self.mp4Path.length<=0 && self.mImage == nil)
    {
        [self.view makeToast:@"请选择视频或者照片"];
        
    }else
    {
        if (self.mp4Path !=nil)
        {
            if (self.mp4Path.length>0)
            {
                [SVProgressHUD showWithStatus:@"正在上传作品..." maskType:SVProgressHUDMaskTypeBlack];
                
                NSData *vidoData = [NSData dataWithContentsOfFile:self.mp4Path];
                PLWorkProcess *workProce = [[PLWorkProcess alloc]init];
                [workProce uploadWorksWithActivityId:self.activityId
                                          withUserId:[self getUserId]
                                         withMovData:vidoData
                                         withImgData:UIImagePNGRepresentation(self.mImage)
                                            workName:self.worksName.text
                                           workIntro:self.infoTextView.text
                                          didSuccess:^(NSMutableArray *array) {
                                              
                                              [SVProgressHUD dismissWithSuccess:@"上传成功"];
                                              
                                          } didFail:^(NSString *error) {
                                              NSString *er = [NSString stringWithFormat:@"上传失败,%@",error];
                                              [SVProgressHUD dismissWithError:er];
                                          }];
            }else
            {
                [self encodeIsUpload:YES];
            }
        }else
        {
            [self encodeIsUpload:YES];
        }
        
    }
}

-(IBAction)cancelUploadComplete:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(IBAction)uploadImage:(id)sender
{
    [self presentImagePicke:NO];
}
-(IBAction)uploadVido:(id)sender
{
    [self presentImagePicke:YES];
}

-(void)presentImagePicke:(BOOL)isVideo
{
    UIImagePickerController *imagePicke = [[UIImagePickerController alloc]init];
    if (isVideo)
    {
        imagePicke.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
        imagePicke.mediaTypes = @[(NSString *)kUTTypeMovie];
    }else
    {
        imagePicke.allowsEditing = YES;
    }
    imagePicke.delegate = self;
    [self presentViewController:imagePicke animated:YES completion:nil];
}

#pragma mark- UIImagePickerControllerDelegate
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    NSURL *object = [info objectForKey:UIImagePickerControllerReferenceURL];
    NSString *type =[info objectForKey:UIImagePickerControllerMediaType];
    
    if ([type isEqualToString:(NSString*)kUTTypeImage])
    {
        self.mImage = [info objectForKey:UIImagePickerControllerEditedImage];
        
    }else if ([type isEqualToString:(NSString*)kUTTypeMovie])
    {
        self.vidoUrl = [info objectForKey:UIImagePickerControllerMediaURL];
        [self encodeIsUpload:NO];
    }
    
    ALAssetsLibrary *library = [[ALAssetsLibrary alloc] init];
    
    [library assetForURL:object
             resultBlock:^(ALAsset *asset) {
                 
                 UIImage *image = [UIImage imageWithCGImage:asset.thumbnail];
                
                 if (image)
                 {
                     dispatch_async(dispatch_get_main_queue(), ^{
                         
                         if ([type isEqualToString:(NSString*)kUTTypeImage])
                         {
                             //照片选取
                             [self.uploadImage setBackgroundImage:image forState:UIControlStateNormal];
                             
                         }else if ([type isEqualToString:(NSString*)kUTTypeMovie])
                         {
                             //视频选取
                             [self.uploadVideo setBackgroundImage:image forState:UIControlStateNormal];
                         }
                         
                     });
                     
                 }else
                 {
                     [self.view makeToast:@"显示缩略图失败"];
                 }
                 
                 
             } failureBlock:^(NSError *error) {
                 
                 [self.view makeToast:@"显示缩略图失败"];
             }];
    
    [picker dismissViewControllerAnimated:YES completion:nil];
    
}
-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [picker dismissViewControllerAnimated:YES completion:nil];
}

-(void)encodeIsUpload:(BOOL)isUpload
{
    AVURLAsset *avAsset = [AVURLAsset URLAssetWithURL:self.vidoUrl options:nil];
    NSArray *compatiblePresets = [AVAssetExportSession exportPresetsCompatibleWithAsset:avAsset];
    
    if ([compatiblePresets containsObject:AVAssetExportPresetMediumQuality])
        
    {
        
        
        AVAssetExportSession *exportSession = [[AVAssetExportSession alloc]initWithAsset:avAsset
                                                                              presetName:AVAssetExportPresetMediumQuality];
        NSDateFormatter* formater = [[NSDateFormatter alloc] init];
        [formater setDateFormat:@"yyyy-MM-dd-HH:mm:ss"];
        _mp4Path = [NSHomeDirectory() stringByAppendingFormat:@"/Documents/output-%@.mp4", [formater stringFromDate:[NSDate date]]];
        
        exportSession.outputURL = [NSURL fileURLWithPath: _mp4Path];
        exportSession.shouldOptimizeForNetworkUse = YES;
        exportSession.outputFileType = AVFileTypeMPEG4;
        [exportSession exportAsynchronouslyWithCompletionHandler:^{
            
            switch ([exportSession status]) {
                case AVAssetExportSessionStatusCompleted:
                {
                    NSLog(@"转码成功");
                    if (isUpload) {
                        
                        [self uploadComplete:nil];
                    }
                }
                    break;
                default:
                {
                    _mp4Path = nil;
                    NSLog([[exportSession error] localizedDescription]);
                }
                    break;
            }
        }];
    }
    else
    {
        UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"Error"
                                                        message:@"AVAsset doesn't support mp4 quality"
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles: nil];
        [alert show];
    }

}

@end
