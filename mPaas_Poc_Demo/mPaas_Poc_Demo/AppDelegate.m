//
//  AppDelegate.m
//  mPaas_Poc_Demo
//
//  Created by wyy on 2021/7/2.
//

#import "AppDelegate.h"
#import "MPTabBarController.h"
#import <UserNotifications/UserNotifications.h>
#import <MPPushSDK/MPPushSDK.h>
#import <MASSChannel/MASSAccess.h>

//#import <ShareSDK/ShareSDK.h>

@interface AppDelegate () <UNUserNotificationCenterDelegate>

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
   
    self.window = [[UIWindow alloc] initWithFrame:UIScreen.mainScreen.bounds];
    self.window.backgroundColor = UIColor.whiteColor;

    
//    本地测试热修复文件是否正确
//    NSString *jsFile = [[NSBundle mainBundle] pathForResource:@"TestCrash" ofType:@"js"];
//    [MPDynamicInterface runWithResultDynamicLocalFile:jsFile];
    
    MPTabBarController *tabBarVC = MPTabBarController.new;
    DFNavigationController *nv = [[DFNavigationController alloc] initWithRootViewController:tabBarVC];
    self.window.rootViewController = nv;
    [self.window makeKeyAndVisible];
    
<<<<<<< HEAD
    //初始化mpaas框架
    [[DTFrameworkInterface sharedInstance] manualInitMpaasFrameworkWithApplication:application launchOptions:launchOptions window:self.window navigationController:nv];

=======
    //推送
>>>>>>> 589ea531ec61ac70eb1ecb5bfc28b12d11535062
    NSDictionary *userInfo = [launchOptions objectForKey: UIApplicationLaunchOptionsRemoteNotificationKey];
    if ([[[UIDevice currentDevice] systemVersion] doubleValue] >= 10.0) {
        UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
        center.delegate = self;
        [center requestAuthorizationWithOptions:(UNAuthorizationOptionAlert | UNAuthorizationOptionBadge | UNAuthorizationOptionSound)
                              completionHandler:^(BOOL granted, NSError * _Nullable error) {

        }];
    }else{
        //iOS 10 以下Push冷启动处理
        [self showAlert:userInfo];
    }
<<<<<<< HEAD
     
=======
    
    //CDP 启动Netctrl
    [[MASSAccess shareInstance] dispatchTokenSvrInfo:nil uploadInfo:nil downloadInfo:nil downloadInfoCrypto:nil configStorage:nil];
    
    //初始化mpaas框架
    [[DTFrameworkInterface sharedInstance] manualInitMpaasFrameworkWithApplication:application launchOptions:launchOptions window:self.window navigationController:nv];
>>>>>>> 589ea531ec61ac70eb1ecb5bfc28b12d11535062
    
    return YES;
}

<<<<<<< HEAD

- (void)addLocalNotification
{
    //创建通知
    UNMutableNotificationContent *content = [[UNMutableNotificationContent alloc] init];
    content.title = @"通知标题";
    content.subtitle = @"通知副标题";
    content.body = @"通知内容";
    content.badge = @1;//角标数
    content.categoryIdentifier = @"categoryIdentifier";
  
    //声音设置 [UNNotificationSound soundNamed:@"sound.mp3"] 通知文件要放到bundle里面
    UNNotificationSound *sound = [UNNotificationSound defaultSound];
    content.sound = sound;
    
    UNTimeIntervalNotificationTrigger *trigger = [UNTimeIntervalNotificationTrigger triggerWithTimeInterval:5 repeats:NO];
    //创建UNNotificationRequest通知请求对象
    NSString *requestIdentifier = @"requestIdentifier";
    UNNotificationRequest *request = [UNNotificationRequest requestWithIdentifier:requestIdentifier content:content trigger:trigger];
    //将通知加到通知中心
    [[UNUserNotificationCenter currentNotificationCenter] addNotificationRequest:request withCompletionHandler:^(NSError * _Nullable error) {
        
    }];
    
}

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken
{
=======
- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
>>>>>>> 589ea531ec61ac70eb1ecb5bfc28b12d11535062
    // 绑定设备token
    [[PushService sharedService] setDeviceToken:deviceToken];
    // 绑定用户
    [[PushService sharedService] pushBindWithUserId:@"XXXX" completion:^(NSException *error) {
        NSLog(@"%@", error);
    }];
}

<<<<<<< HEAD
//基于 iOS 7 及以上，iOS 10 以下的系统版本
- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult result))completionHandler {
    
    //处理接受到的消息
    [self showAlert:userInfo];
}

//基于 iOS 10 及以上的系统版本
- (void)userNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(UNNotificationPresentationOptions options))completionHandler {
    
    NSDictionary *userInfo = notification.request.content.userInfo;
    if([notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        //应用处于前台时的远程推送接受
        [self showAlert:userInfo];
    } else {
        //应用处于前台时的本地推送接受
    }
    
    completionHandler(UNNotificationPresentationOptionBanner);
}

//基于 iOS 10 及以上的系统版本
- (void)userNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void(^)(void))completionHandler {
    NSDictionary *userInfo = response.notification.request.content.userInfo;
    
    if([response.notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        //应用处于后台或者活冷启动时远程推送接受
        [self showAlert:userInfo];
    } else {
        //应用处于前台时的本地推送接受
    }
    
    completionHandler();
}

=======
>>>>>>> 589ea531ec61ac70eb1ecb5bfc28b12d11535062
- (void)showAlert:(NSDictionary *)userInfo {
    AUNoticeDialog *alert = [[AUNoticeDialog alloc] initWithTitle:@"通知详情" message:[NSString stringWithFormat:@"%@", userInfo] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alert show];
}


//- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<UIApplicationOpenURLOptionsKey,id> *)options
//{
//    return YES;
//}

@end
