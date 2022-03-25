//
//  MP_TinyAppViewController.m
//  mPaas_Poc_Demo
//
//  Created by wyy on 2021/7/6.
//

#import "MP_TinyAppViewController.h"
#import "MP_TinyScanDebugHelper.h"

@interface MP_TinyAppViewController ()

@end

@implementation MP_TinyAppViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = NSLocalizedString(@"小程序", nil);
    
    CREATE_UI({
        BUTTON_WITH_ACTION(NSLocalizedString(@"启动小程序Demo", nil), openTinyAppAction)
        BUTTON_WITH_ACTION(NSLocalizedString(@"调试/预览小程序", nil), debugTinyAppAction)
        BUTTON_WITH_ACTION(NSLocalizedString(@"自定义JSAPI", nil), customJsApiAction)
    })
}

//打开小程序
- (void)openTinyAppAction
{
//    [MPNebulaAdapterInterface startTinyAppWithId:@"0000000000000001" params:@{}];
    [MPNebulaAdapterInterface startTinyAppWithId:@"2022000000000013" params:@{}];
}

//调试小程序
- (void)debugTinyAppAction
{
    [[MP_TinyScanDebugHelper sharedInstance] startScanWithNavVc:self.navigationController];
}

- (void)customJsApiAction
{
    [MPNebulaAdapterInterface startTinyAppWithId:@"0000000000000002" params:@{}];

}

@end
