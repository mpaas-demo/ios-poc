//
//  MP_UpgradeViewController.m
//  mPaas_Poc_Demo
//
//  Created by wyy on 2021/7/9.
//

#import "MP_UpgradeViewController.h"

@interface MP_UpgradeViewController ()<AliUpgradeViewDelegate>

@end

@implementation MP_UpgradeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = NSLocalizedString(@"版本升级", nil);
    
    CREATE_UI({
        BUTTON_WITH_ACTION(NSLocalizedString(@"检测升级：默认弹框提示", nil), checkUpgradeDefault)
        BUTTON_WITH_ACTION(NSLocalizedString(@"检测升级：自定义弹框图像和loading", nil), checkUpgradeWithHeaderImage)
        BUTTON_WITH_ACTION(NSLocalizedString(@"检测升级：自定义弹框UI", nil), checkUpgradeWIthCustomUI)
    })
}

- (void)checkUpgradeDefault {
    [MPCheckUpgradeInterface sharedService].defaultUpdateInterval = 7;
    [[MPCheckUpgradeInterface sharedService] checkNewVersion];
}

- (void)checkUpgradeWithHeaderImage {
    MPCheckUpgradeInterface *upgradeInterface = [MPCheckUpgradeInterface sharedService];
    upgradeInterface.viewDelegate = self;
    [upgradeInterface checkNewVersion];
}

- (UIImage *)upgradeImageViewHeader{
    return APCommonUILoadImage(@"ilustration_ap_expection_alert");
}

- (void)showToastViewWith:(NSString *)message duration:(NSTimeInterval)timeInterval {
    [self showAlert:message];
}

- (void)showAlert:(NSString*)message {
    AUNoticeDialog* alertView = [[AUNoticeDialog alloc] initWithTitle:@"Information" message:message delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    [alertView show];
}

- (void)checkUpgradeWIthCustomUI {
    [[MPCheckUpgradeInterface sharedService] checkUpgradeWith:^(NSDictionary *upgradeInfos) {
        
        NSString *msg = upgradeInfos[@"message"];
        msg = [msg stringByReplacingOccurrencesOfString:@"\n" withString:@"\\n"];
        NSDictionary *dic = [self dictionaryWithJsonString:msg];
        NSLog(@"%@",dic);
        [self showAlert:[upgradeInfos JSONString_mp]];
        
    } failure:^(NSException *exception) {
        
    }];
}

- (NSString*)dictionaryToJson:(NSDictionary*)dic
{
    NSError *parseError =nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:&parseError];
    return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
}

- (NSDictionary*)dictionaryWithJsonString:(NSString*)jsonString {
    
    if(jsonString ==nil) {
         return nil;
    }
    
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSError*err;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                        options:NSJSONReadingMutableContainers
                        error:&err];
    
    if(err) {
            NSLog(@"json解析失败：%@",err);
            return nil;
    }
    return dic;
}



@end
