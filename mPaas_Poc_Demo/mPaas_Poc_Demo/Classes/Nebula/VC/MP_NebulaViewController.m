//
//  MP_NebulaViewController.m
//  mPaas_Poc_Demo
//
//  Created by wyy on 2021/7/6.
//

#import "MP_NebulaViewController.h"
#import "MPNavigatorDemoVC.h"
#import "MP_PDFViewController.h"

@interface MP_NebulaViewController ()

@end

@implementation MP_NebulaViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    self.title = NSLocalizedString(@"H5容器和离线包", nil);
    
    CREATE_UI({
        BUTTON_WITH_ACTION(NSLocalizedString(@"打开在线页面", nil), openOnlineAction)
//        BUTTON_WITH_ACTION(@"打开PDF", openPDFAction)
        BUTTON_WITH_ACTION(NSLocalizedString(@"打开本地页面", nil), openLocalFileAction)
        BUTTON_WITH_ACTION(NSLocalizedString(@"自定义JSAPI", nil), customJsApiAction)
        BUTTON_WITH_ACTION(NSLocalizedString(@"打开H5离线包", nil), openOfflinePackageAction)
        BUTTON_WITH_ACTION(NSLocalizedString(@"定制导航栏", nil), customNavigatorBar)
    })
}

- (void)customNavigatorBar
{
    MPNavigatorDemoVC *vc = [MPNavigatorDemoVC new];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)openPDFAction {
    MP_PDFViewController *vc = [MP_PDFViewController new];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)openOnlineAction
{
    [[MPNebulaAdapterInterface shareInstance] startH5ViewControllerWithParams:@{@"url":@"https://help.aliyun.com/document_detail/59192.html?spm=a2c4g.11186623.6.1341.2b13724bf5IcDA"}];
}

- (void)openLocalFileAction
{
    NSString *path = [[NSBundle mainBundle].bundlePath stringByAppendingFormat:@"/%@", @"H52Native.html"];
    path = [NSString stringWithFormat:@"file://%@", path];
    if ([path length] > 0) {
        [[MPNebulaAdapterInterface shareInstance] startH5ViewControllerWithParams:@{@"url": path}];
    }
}

- (void)customJsApiAction
{
    NSString *path = [[NSBundle mainBundle].bundlePath stringByAppendingFormat:@"/%@", @"H52Native.html"];
    path = [NSString stringWithFormat:@"file://%@", path];
    if ([path length] > 0) {
        [[MPNebulaAdapterInterface shareInstance] startH5ViewControllerWithParams:@{@"url": path,@"showRightBarItem":@"1"}];
    }
}

- (void)openOfflinePackageAction
{
    [[MPNebulaAdapterInterface shareInstance] startH5ViewControllerWithNebulaApp:@{@"appId":@"70000000"}];
//    [[MPNebulaAdapterInterface shareInstance] startH5ViewControllerWithNebulaApp:@{@"appId":@"20220000"}];
}

@end
