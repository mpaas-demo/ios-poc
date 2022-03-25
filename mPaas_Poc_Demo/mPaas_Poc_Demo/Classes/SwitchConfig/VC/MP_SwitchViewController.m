//
//  MP_SwitchViewController.m
//  mPaas_Poc_Demo
//
//  Created by wyy on 2021/7/17.
//

#import "MP_SwitchViewController.h"
#import "MP_AViewController.h"
#import "MP_BViewController.h"
@interface MP_SwitchViewController ()

@end

@implementation MP_SwitchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = NSLocalizedString(@"开关配置", nil);
    
    CREATE_UI({
        BUTTON_WITH_ACTION(NSLocalizedString(@"开关配置信息", nil), fetchConfig)
    })
    
}

- (void)fetchConfig {
    
    [[MPConfigInterface sharedService] forceLoadConfig];
    
    NSString *value = [[MPConfigInterface sharedService] stringValueForKey:@"configPush"];
    AUNoticeDialog *alert = [[AUNoticeDialog alloc] initWithTitle:NSLocalizedString(@"配置信息", nil) message:value delegate:nil cancelButtonTitle:nil otherButtonTitles:nil];
    [alert addButton:NSLocalizedString(@"确定", nil) actionBlock:^{
        
        if ([value integerValue] == 1) {
            MP_AViewController *vc =  MP_AViewController.new;
            [self.navigationController pushViewController:vc animated:YES];
        }else{
            MP_BViewController *vc =  MP_BViewController.new;
            [self.navigationController pushViewController:vc animated:YES];
        }
        
    }];
    [alert show];
}



//
//- (void)configChangedForKey:(NSString *)key value:(NSString *)value
//{
//    if ([key isEqualToString:@"configPush"]) {
//        [self fetchConfig];
//    }
//}

//- (void)forceLoad
//{
//    [[MPConfigInterface sharedService] forceLoadConfig];
//}
//
//- (void)dealloc
//{
//    [[MPConfigInterface sharedService] removeObserver:self];
//}



@end
