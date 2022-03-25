//
//  DTFrameworkInterface+mPaas_Poc_Demo.m
//  mPaas_Poc_Demo
//
//  Created by wyy on 2021/07/05. All rights reserved.
//

#import "DTFrameworkInterface+mPaas_Poc_Demo.h"
#import <MASSChannel/MASSAccess.h>

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wobjc-protocol-method-implementation"

static NSTimeInterval __start_timestamp = 0;
static UIWindow *splashScreenWindow;

@implementation DTFrameworkInterface (mPaas_Poc_Demo)

- (BOOL)shouldLogReportActive
{
    return YES;
}

- (NSTimeInterval)logReportActiveMinInterval
{
    return 0;
}

- (BOOL)shouldLogStartupConsumption
{
    return YES;
}

- (BOOL)shouldAutoactivateBandageKit
{
    return YES;
}

- (BOOL)shouldAutoactivateShareKit
{
    return YES;
}

- (DTNavigationBarBackTextStyle)navigationBarBackTextStyle
{
    return DTNavigationBarBackTextStyleAlipay;
}

- (void)application:(UIApplication *)application beforeDidFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
//   移动分析
    [self configAnalysis];
//   初始化网关
    [MPRpcInterface initRpc];
//   初始化分享组件
    [self configShareSDK];
//   初始化容器
    [self configNebula];
    
    [[MASSAccess shareInstance] dispatchTokenSvrInfo:nil uploadInfo:nil downloadInfo:nil downloadInfoCrypto:nil configStorage:nil];

    //智能投放
    [CDPPromotionInterface start];
    
    [MPNebulaAdapterInterface shareInstance].configDelegate = self;
}


#pragma mark---移动分析

- (void)configAnalysis
{
//  卡顿监控率设置为100%，可以根据需要设置比率。
    [MPAnalysisHelper setLagMonitorPercent:100];
//  开启性能监控
    [MPAnalysisHelper startPerformanceMonitor];
//  上报启动时间
    NSTimeInterval time = CFAbsoluteTimeGetCurrent() - __start_timestamp;
    [[MPAnalysisHelper sharedInstance] writeLogForStartupWithTime:time];
//  用户报活日志
    [[MPAnalysisHelper sharedInstance] writeLogForReportActive];
    // 初始化日志诊断
    [MPDiagnoseAdapter initDiagnose];
}


#pragma mark---初始化容器
- (void)configNebula
{
    // 自定义jsapi路径和预置离线包信息
    NSString *presetApplistPath = [[NSBundle mainBundle] pathForResource:[NSString stringWithFormat:@"DemoCustomPresetApps.bundle/h5_json.json"] ofType:nil];
    NSString *appPackagePath = [[NSBundle mainBundle] pathForResource:[NSString stringWithFormat:@"DemoCustomPresetApps.bundle"] ofType:nil];
    NSString *pluginsJsapisPath = [[NSBundle mainBundle] pathForResource:[NSString stringWithFormat:@"DemoCustomPlugins.bundle/Poseidon-UserDefine-Extra-Config.plist"] ofType:nil];
    [MPNebulaAdapterInterface initNebulaWithCustomPresetApplistPath:presetApplistPath customPresetAppPackagePath:appPackagePath customPluginsJsapisPath:pluginsJsapisPath];
}

#pragma mark---配置分享组件
- (void)configShareSDK
{
    NSDictionary *configDic = @{
    @"weixin" : @{@"key":@"wxa077a4686304b04a", @"secret":@"aa81504c94d6e70cecd623f97be6256a", @"universalLink": @"https://mpaas-mappcenter.aliyuncs.com/weichat/"},
                            @"weibo" : @{@"key":@"1877934830", @"secret":@"1067b501c42f484262c1803406510af0"},
                            @"qq" : @{@"key":@"101815269", @"secret":@"6a5dde7d8e04e860646ec2187a92017d", @"universalLink": @"https://mpaas-mappcenter.aliyuncs.com/qq_conn/101815269"},
                            @"alipay": @{@"key":@"2015060900117932"},/*该 key 对应的 bundleID 为"share.demo", 如需用来测试,请修改为自己申请的 key 或修改 bundleID 为"share.demo"*/
                            @"dingTalk": @{@"key":@"dingoa5ri8qeitsaknejil"}};
    
     [APSKClient registerAPPConfig:configDic];
    
}

- (DTFrameworkCallbackResult)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler {
    [self showAlert:userInfo];

    return DTFrameworkCallbackResultContinue;
}

- (void)application:(UIApplication *)application afterDidFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // 通知关闭启动页
    APWillKillSplashScreen();
    
    [MPNebulaAdapterInterface shareInstance].nebulaVeiwControllerClass = NSClassFromString(@"MP_H5WebViewController");
//    关闭验签
    [MPNebulaAdapterInterface shareInstance].nebulaNeedVerify = NO;
//    强制更新所有离线包
    [[MPNebulaAdapterInterface shareInstance]requestAllNebulaApps:^(NSDictionary *data, NSError *error) {
        
    }];
}

- (DTFrameworkCallbackResult)application:(UIApplication *)application handleDidFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // 广告逻辑
    BOOL showSplashWindow = YES;
    showSplashWindow = splashScreenExist(showSplashWindow);
    if (showSplashWindow) {
        __weak typeof(self) weakSelf = self;
        splashScreenWindow = APSplashScreenStart(^{
            [weakSelf splashScreenDidDismiss];
        });
    }
    
    return DTFrameworkCallbackResultContinue;
}

- (void)splashScreenDidDismiss {
    //切换主Window
    [DTContextGet().window makeKeyAndVisible];
    [self performSelector:@selector(doDismiss) withObject:nil afterDelay:3.0];
}

- (void)doDismiss {
    //释放闪屏对象
    splashScreenWindow.rootViewController = nil;
    splashScreenWindow = nil;
    [self notifySplashScreenDismiss];
}

- (void)notifySplashScreenDismiss {
    //闪屏结束通知
    [[NSNotificationCenter defaultCenter] postNotificationName:@"kSplashScreenDidDismiss" object:nil];
}

- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url {
    [APSKClient handleOpenURL:url];
    return YES;
}

- (BOOL)application:(UIApplication *)application continueUserActivity:(NSUserActivity *)userActivity restorationHandler:(void(^)(NSArray<id<UIUserActivityRestoring>> * __nullable restorableObjects))restorationHandler
{
    [APSKClient handleOpenUniversalLink:userActivity];
    return YES;;
}

- (void)showAlert:(NSDictionary *)userInfo {
    AUNoticeDialog *alert = [[AUNoticeDialog alloc] initWithTitle:@"通知详情" message:[NSString stringWithFormat:@"%@", userInfo] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alert show];
}

@end

#pragma clang diagnostic pop

