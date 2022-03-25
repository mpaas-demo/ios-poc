//
//  MP_H5WebViewController.m
//  mPaas_Poc_Demo
//
//  Created by wyy on 2021/7/6.
//

#import "MP_H5WebViewController.h"
#import <MPNebulaAdapter/MPH5ErrorHelper.h>

@interface MP_H5WebViewController ()<PSDPluginProtocol>

@property (nonatomic,assign) BOOL isTinyApp;

@end

@implementation MP_H5WebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    // 当前页面的WebView
    WKWebView *webView = (WKWebView *)self.psdContentView;
    NSLog(@"[mpaas] webView: %@", webView);
    // 当前页面的启动参数
    NSDictionary *expandParams = self.psdScene.createParam.expandParams;
    NSLog(@"[mpaas] expandParams: %@", expandParams);
    
    if ([expandParams[@"showRightBarItem"] integerValue] == 1) {
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"原生toH5" style:UIBarButtonItemStylePlain target:self action:@selector(sendEventToH5)];
    }
    
    
    if ([expandParams count] > 0) {
        [self customNavigationBarWithParams:expandParams];
    }
}

- (void)sendEventToH5
{
    // native向 H5 发送事件
    [self callHandler:@"nativeToH5Event" data:@{@"key1":@"value1"} responseCallback:^(id responseData) {
        NSLog(@"%@",responseData);
    }];

}


- (void)customNavigationBarWithParams:(NSDictionary *)expandParams
{
    // 定制导航栏背景
    NSString *titleBarColorString = expandParams[@"titleBarColor"];
    if ([titleBarColorString isKindOfClass:[NSString class]] && [titleBarColorString length] > 0) {
        UIColor *titleBarColor = [UIColor colorFromHexString_au:titleBarColorString];
        [self.navigationController.navigationBar setNavigationBarStyleWithColor:titleBarColor translucent:NO];
        [self.navigationController.navigationBar setNavigationBarBottomLineColor:titleBarColor];
    }
    
    //导航栏是否隐藏，默认不隐藏。设置隐藏后，webview需全屏
    NSString *showTitleBar = expandParams[@"showTitleBar"];
    if (showTitleBar && ![showTitleBar boolValue]) {
        self.options.showTitleBar = NO;
        [self.navigationController setNavigationBarHidden:YES];
    }
    
    //导航栏是否透明，默认不透明。设置透明后，webview需全屏
//    NSString *transparentTitle = expandParams[@"transparentTitle"];
//    if ([transparentTitle isEqualToString:@"always"] || [transparentTitle isEqualToString:@"auto"]) {
//
//        // 导航栏和底部横线变为透明
//        UIColor *clearColor = [UIColor clearColor] ;
//        [self.navigationController.navigationBar setNavigationBarTranslucentStyle];
//        [self.navigationController.navigationBar setNavigationBarStyleWithColor:clearColor translucent:YES];
//
//        // 调整webview的位置
//        self.edgesForExtendedLayout = UIRectEdgeAll;
//        if (@available(iOS 11.0, *)) {
//            UIWebView *wb = (UIWebView *)[self psdContentView];
//            wb.scrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
//        }else{
//            self.automaticallyAdjustsScrollViewInsets = NO;
//        }
//    }
    
    // 修改默认返回按钮文案颜色
    NSString *backButtonColorString = expandParams[@"backButtonColor"];
    if ([backButtonColorString isKindOfClass:[NSString class]] && [backButtonColorString length] > 0) {
        UIColor *backButtonColor = [UIColor colorFromHexString:backButtonColorString];
        
        NSArray *leftBarButtonItems = self.navigationItem.leftBarButtonItems;
        if ([leftBarButtonItems count] == 1) {
            if (leftBarButtonItems[0] && [leftBarButtonItems[0] isKindOfClass:[AUBarButtonItem class]]) {
                AUBarButtonItem *backItem = leftBarButtonItems[0];
                backItem.titleColor = backButtonColor;
                backItem.backButtonColor = backButtonColor;
            }
        }
    }
    
    // 设置标题颜色
    NSString *titleColorString = expandParams[@"titleColor"];
    if ([titleColorString isKindOfClass:[NSString class]] && [titleColorString length] > 0) {
        UIColor *titleColor = [UIColor colorFromHexString_au:titleColorString];
        id<NBNavigationTitleViewProtocol> titleView = self.navigationItem.titleView;
        [[titleView mainTitleLabel] setFont:[UIFont systemFontOfSize:16]];
        [[titleView mainTitleLabel] setTextColor:titleColor];
    }
    
}



#pragma mark - 注册为容器插件
- (void)nbViewControllerInit
{
    [super nbViewControllerInit];
    
    PSDSession *session = [self viewControllerProxy].psdSession;
    [session addEventListener:kEvent_Navigation_All
                 withListener:self
                   useCapture:NO];
    [session addEventListener:kEvent_Page_All
                 withListener:self
                   useCapture:NO];
    
}

- (NSString *)name
{
    return NSStringFromClass([self class]);
}

#pragma mark - 对应UIWebViewDelegate的委托实现

- (void)handleEvent:(PSDEvent *)event
{
    [super handleEvent:event];
    
    if (![[event.context currentViewController] isEqual:self]) {
        return;
    }
    NSLog(@"---------%@",event.eventType);
    if ([event.eventType isEqualToString:kEvent_Page_Create]) {
        NSLog(@"----容器页面创建-----%@",event.eventType);
        return;
    }
    if ([event.eventType isEqualToString:kEvent_Page_Load_Start]) {
        NSLog(@"----容器页面开始加载-----%@",event.eventType);
        return;
    }
    if ([event.eventType isEqualToString:kEvent_Page_Load_FirstByte]) {
        NSLog(@"----已请求第一个字节-----%@",event.eventType);
        return;
    }
    if ([event.eventType isEqualToString:kEvent_Page_Load_DomReady]) {
        NSLog(@"----容器dom已ready-----%@",event.eventType);
        return;
    }
    if ([event.eventType isEqualToString:kEvent_Page_Load_Complete]) {
        NSLog(@"-----容器加载完成----%@",event.eventType);
        return;
    }
    if ([event.eventType isEqualToString:kEvent_Page_Destroy]) {
        NSLog(@"----已销毁-----%@",event.eventType);
        return;
    }
    
    if ([kEvent_Navigation_Start isEqualToString:event.eventType]) {
        // 此事件可拦截当前url是否加载
        BOOL shouldStart = [self handleContentViewShouldStartLoad:(id)event ];
        
        if (!shouldStart) {
            [event preventDefault];
        }
    }
    else if ([kEvent_Page_Load_Start isEqualToString:event.eventType]) {
        [self handleContentViewDidStartLoad:(id)event];
    }
    else if ([kEvent_Page_Load_Complete isEqualToString:event.eventType]) {
        [self handleContentViewDidFinishLoad:(id)event];
    }
    else if ([kEvent_Navigation_Error isEqualToString:event.eventType]) {
        [self handleContentViewDidFailLoad:(id)event];
    }
}


- (BOOL)handleContentViewShouldStartLoad:(PSDNavigationEvent *)event
{
    return YES;
}

- (void)handleContentViewDidStartLoad:(PSDPageEvent *)event
{
    
}

- (void)handleContentViewDidFinishLoad:(PSDPageEvent *)event
{
    
}

- (void)handleContentViewDidFailLoad:(PSDNavigationEvent *)event
{
    PSDNavigationEvent *naviEvent = (PSDNavigationEvent *)event;
    NSError *error = naviEvent.error;
    [MPH5ErrorHelper handlErrorWithWebView:(UIWebView *)self.psdContentView error:error];
}


- (void)dealloc
{
    
}




@end
