//
//  MySyncService.m
//  mPaas_Poc_Demo
//
//  Created by yangwei on 2021/7/17.
//

#import "MySyncService.h"
#import <MPMssAdapter/MPSyncInterface.h>

#define SYNC_BIZ_NAME @"SYNC-TRADE-DATA"

@implementation MySyncService
+ (instancetype)sharedInstance
{
    static MySyncService *bizService;
    static dispatch_once_t llSOnceToken;
    dispatch_once(&llSOnceToken, ^{
        bizService = [[self alloc] init];
    });
    return bizService;
}
-(instancetype)init
{
    self = [super init];
    if (self) {
        [MPSyncInterface initSync];
        BOOL registerSingleDeviceSync = [MPSyncInterface registerSyncBizWithName:SYNC_BIZ_NAME syncObserver:self selector:@selector(revSyncBizNotification:)];
        [MPSyncInterface bindUserWithSessionId:@"SESSION_DEMO"];
    }
    return self;
}
-(void)revSyncBizNotification:(NSNotification*)notify
{
    NSDictionary *userInfo = notify.userInfo;
    dispatch_async(dispatch_get_main_queue(), ^{
        //业务数据处理
        [MySyncService handleSyncData:userInfo];
        //回调 SyncSDK，表示业务数据已经处理
        [MPSyncInterface responseMessageNotify:userInfo];
    });
}
+(void)handleSyncData:(NSDictionary *)userInfo
{
    NSString * stringOp = userInfo[@"op"];
    NSArray *op = [NSJSONSerialization JSONObjectWithData:[stringOp dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingMutableContainers error:nil];
    if([op isKindOfClass:[NSArray class]]){
        [op enumerateObjectsUsingBlock:^(NSDictionary * item, NSUInteger idx, BOOL *stop) {
            if([item isKindOfClass:[NSDictionary class]]){
                NSString * plString = item[@"pl"];//业务数据 payload
                if(item[@"isB"]){
                    NSData *dataPl = [[NSData alloc] initWithBase64EncodedString:plString options:kNilOptions];
                    NSString *pl = [[NSString alloc] initWithData:dataPl encoding:NSUTF8StringEncoding];
                    NSLog(@"biz payload data:%@,string:%@",dataPl,pl);
                }else{
                     NSLog(@"biz payload:%@",plString);
                }
                NSString *syncResult = [NSString stringWithFormat:@"sync 消息：%@", plString];
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:syncResult     delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                 alert.tag = 1999;
                 [alert show];
            }
        }];
    }
}
-(void)dealloc
{
    BOOL unRegisterSingleDeviceSync = [MPSyncInterface unRegisterSyncBizWithName:SYNC_BIZ_NAME syncObserver:[MySyncService sharedInstance]];
    [MPSyncInterface removeSyncNotificationObserver:self];
}
@end
