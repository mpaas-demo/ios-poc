//
//  SyncDemoViewController.m
//  mPaas_Poc_Demo
//
//  Created by yangwei on 2021/7/17.
//

#import "SyncDemoViewController.h"
#import "MySyncService.h"
#import "AppDelegate.h"
@interface SyncDemoViewController ()

@end

@implementation SyncDemoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = NSLocalizedString(@"移动同步", nil);
    self.view.backgroundColor = [UIColor whiteColor];
    
    
    [MySyncService sharedInstance];
    
    CREATE_UI(
      BUTTON_WITH_ACTION(NSLocalizedString(@"建立Sync连接", nil), startSyncService)
      BUTTON_WITH_ACTION(NSLocalizedString(@"绑定用户", nil), bindUser)
      BUTTON_WITH_ACTION(NSLocalizedString(@"解绑用户", nil), unbindUser)
    )
}

- (void)startSyncService
{
    [MySyncService sharedInstance];
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:@"已创建连接" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
     alert.tag = 10000;
     [alert show];
}

- (void)bindUser{
    [MPSyncInterface bindUserWithSessionId:@"SESSION_DEMO"];
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:@"已绑定用户" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
     alert.tag = 10001;
     [alert show];
}

- (void)unbindUser
{
    [MPSyncInterface unBindUser];
<<<<<<< HEAD
    
    [(AppDelegate *)[UIApplication sharedApplication].delegate addLocalNotification];
=======
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:@"用户已解绑" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
     alert.tag = 10002;
     [alert show];
>>>>>>> 589ea531ec61ac70eb1ecb5bfc28b12d11535062
}

@end
