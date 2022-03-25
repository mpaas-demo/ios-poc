//
//  MP_JsApiHandler4OPenCamera.m
//  mPaas_Poc_Demo
//
//  Created by wyy on 2021/7/17.
//

#import "MP_JsApiHandler4OPenCamera.h"

@interface MP_JsApiHandler4OPenCamera ()<UINavigationControllerDelegate,UIImagePickerControllerDelegate>

@end

@implementation MP_JsApiHandler4OPenCamera


- (void)handler:(NSDictionary *)data context:(PSDContext *)context callback:(PSDJsApiResponseCallbackBlock)callback
{
     [super handler:data context:context callback:callback];
     
     UIViewController *currentVC = context.currentViewController;
     
     if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
     {
         UIImagePickerControllerSourceType sourceType = UIImagePickerControllerSourceTypeCamera;//设置类型为相机
         UIImagePickerController *picker = [[UIImagePickerController alloc] init];//初始化
         picker.delegate = self;
         picker.allowsEditing = YES;
         picker.sourceType = sourceType;
         picker.showsCameraControls = YES;
         
         [currentVC presentViewController:picker animated:YES completion:^{
         }];
     }
     else {
         NSLog(@"该设备无相机");
     }
}


#pragma mark - 从相册选择图片后操作
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
  
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
  
    //将照片存到媒体库
    UIImageWriteToSavedPhotosAlbum(image, self, @selector(image:didFinishSavingWithError:contextInfo:), NULL);

    [picker dismissViewControllerAnimated:YES completion:^{}];

}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [picker dismissViewControllerAnimated:YES completion:^{}];
}

#pragma mark - 照片存到本地后的回调
- (void)image:(UIImage*)image didFinishSavingWithError:(NSError*)error contextInfo:(void*)contextInfo{
    if (!error) {
        NSLog(@"存储成功");
        AUToast *toast =  [AUToast presentToastWithText:@"图片已保存到相册" logTag:@"1"];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [toast dismissToast];
        });
        
    } else {
        NSLog(@"存储失败：%@", error);
    }

}

@end

