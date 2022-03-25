//
//  MP_SyncViewController.m
//  mPaas_Poc_Demo
//
//  Created by Raffaele on 2021/7/17.
//

#import "MP_SyncViewController.h"
#import "MPSyncServiceImpl.h"
#import <mPaas/MPaaSInterface.h>
#import <mPaas/DTDeviceInfo.h>
#import <mPaas/MPJSONKit.h>
#import "MPSyncTestCase.h"

@interface MP_SyncViewController ()

@property (nonatomic, strong) AUInputBox *userIdInput;
@property (nonatomic, strong) AUInputBox *sessionIdInput;
@property (nonatomic, strong) AUInputBox *deviceIdInput;
@property (nonatomic, strong) AUInputBox *syncStatusInput;

@property (nonatomic, strong) id<MPSyncService> syncService;

@end

@implementation MP_SyncViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"移动同步";
    self.view.backgroundColor = [UIColor whiteColor];
    
    CREATE_UI(
//      BUTTON_WITH_ACTION(@"建立SYNC连接", startSyncService)
//      BUTTON_WITH_ACTION(@"绑定用户", bindUser)
//      BUTTON_WITH_ACTION(@"解绑用户", unbindUser)
              
      BUTTON_WITH_ACTION(@"Sync初始化与环境检测", runAllTestCase);
      BUTTON_WITH_ACTION(@"注册Sync监听", registerSyncObserver)
      BUTTON_WITH_ACTION(@"去除Sync监听", unRegisterSyncObserver)
      BUTTON_WITH_ACTION(@"绑定TestCase用户", bindTestCaseUser)
      BUTTON_WITH_ACTION(@"解绑TestCase用户", unbindTestCaseUser)
    )
    
    self.userIdInput.textFieldText = [MPaaSInterface sharedInstance].userId;
    self.sessionIdInput.textFieldText = @"SESSION_DEMO";
    self.deviceIdInput.textFieldText = [[DTDeviceInfo sharedDTDeviceInfo] did];
    [self refreshSyncStatus];
    
    
}

- (void)runAllTestCase {
    //详细用例
    [MPSyncTestCase runAllTestCase];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        AUNoticeDialog *alert = [[AUNoticeDialog alloc] initWithTitle:@"执行结果" message:@"Sync 自动部分用例执行完毕，其余部分需要操作服务端推数据测试" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
    });
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self refreshSyncStatus];
    });
}

#pragma mark - TestCase
- (void)registerSyncObserver {
    [MPSyncTestCase testRegister];
    [self refreshSyncStatus];
}

- (void)unRegisterSyncObserver {
    [MPSyncTestCase testUnRegister];
    [self refreshSyncStatus];
}

- (void)bindTestCaseUser {
    [MPSyncTestCase testBindUser];
    [self refreshSyncStatus];
}

- (void)unbindTestCaseUser {
    [MPSyncTestCase testUnBindUser];
    [self refreshSyncStatus];
}

#pragma mark - Demo
- (void)refreshSyncStatus {
    self.syncStatusInput.textFieldText = [self linkStatus];
}

- (UIView *)inputCell:(AUInputBox *)input first:(BOOL)first last:(BOOL)last location:(CGFloat *)yStart {
    UIView *wrapView = [[UIView alloc] initWithFrame:CGRectMake(0, *yStart, AUCommonUIGetScreenWidth(), 44)];
    wrapView.backgroundColor = [UIColor whiteColor];
    
    CGFloat lineHeight = 1/[UIScreen mainScreen].scale;
    if (first) {
        UIView *topLine = [[UIView alloc] initWithFrame:CGRectMake(0, 0, AUCommonUIGetScreenWidth(), lineHeight)];
        topLine.backgroundColor = RGB(0xdddddd);
        [wrapView addSubview:topLine];
    }
    
    [wrapView addSubview:input];
    
    CGFloat left = last ? 0 : 15;
    UIView *bottomLine = [[UIView alloc] initWithFrame:CGRectMake(left, input.bottom, AUCommonUIGetScreenWidth() - left, lineHeight)];
    bottomLine.backgroundColor = RGB(0xdddddd);
    [wrapView addSubview:bottomLine];
    
    wrapView.height = bottomLine.bottom;
    *yStart = wrapView.bottom;
    
    return wrapView;
}

- (NSString *)linkStatus {
    switch ([DTLongLinkBusiness  connectStatus]) {
        case NetConnectTypeConnecting:
            return @"连接中...";
        case NetConnectTypeConnected:
            return @"已连接";
        default:
            return @"未连接";
    }
}

//接收sync数据
- (void)receiveSyncData:(NSDictionary *)data {
    AUNoticeDialog *alert = [[AUNoticeDialog alloc] initWithTitle:@"接收数据" message:[data JSONString_mp] delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
    [alert show];
}

- (AUInputBox *)userIdInput {
    if (!_userIdInput) {
        _userIdInput = [AUInputBox inputboxWithOriginY:0 inputboxType:AUInputBoxTypeNone];
        _userIdInput.style = AUInputBoxStyleNone;
        _userIdInput.titleLabel.text = @"用户 ID";
        _userIdInput.textField.textColor = AU_COLOR_HINT;
        _userIdInput.textField.enabled = NO;
    }
    return _userIdInput;
}

- (AUInputBox *)sessionIdInput {
    if (!_sessionIdInput) {
        _sessionIdInput = [AUInputBox inputboxWithOriginY:0 inputboxType:AUInputBoxTypeNone];
        _sessionIdInput.style = AUInputBoxStyleNone;
        _sessionIdInput.titleLabel.text = @"Session ID";
        _sessionIdInput.textField.textColor = AU_COLOR_HINT;
        _sessionIdInput.textField.enabled = NO;
    }
    return _sessionIdInput;
}

- (AUInputBox *)deviceIdInput {
    if (!_deviceIdInput) {
        _deviceIdInput = [AUInputBox inputboxWithOriginY:0 inputboxType:AUInputBoxTypeNone];
        _deviceIdInput.style = AUInputBoxStyleNone;
        _deviceIdInput.titleLabel.text = @"设备 ID";
        _deviceIdInput.textField.textColor = AU_COLOR_HINT;
        _deviceIdInput.textField.enabled = NO;
    }
    return _deviceIdInput;
}

- (AUInputBox *)syncStatusInput {
    if (!_syncStatusInput) {
        _syncStatusInput = [AUInputBox inputboxWithOriginY:0 inputboxType:AUInputBoxTypeNone];
        _syncStatusInput.style = AUInputBoxStyleNone;
        _syncStatusInput.titleLabel.text = @"连接状态";
        _syncStatusInput.textField.textColor = AU_COLOR_HINT;
        _syncStatusInput.textField.enabled = NO;
    }
    return _syncStatusInput;
}

@end
