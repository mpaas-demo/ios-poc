//
//  MP_DeviceViewController.m
//  mPaas_Poc_Demo
//
//  Created by wyy on 2021/7/7.
//

#import "MP_DeviceViewController.h"

@interface MP_DeviceViewController ()

@end

@implementation MP_DeviceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = NSLocalizedString(@"设备标识", nil);
    
    CREATE_UI({
        BUTTON_WITH_ACTION(NSLocalizedString(@"获取设备标识", nil), getDeviceId)
    })
}

- (void)getDeviceId
{
    NSString *str = [NSString stringWithFormat:@"Current Device identifier is：%@", [MPUtdidInterface deviceId]];
    
    AUNoticeDialog *alert = [[AUNoticeDialog alloc] initWithTitle:NSLocalizedString(@"设备标识", nil) message:str delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alert show];
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
