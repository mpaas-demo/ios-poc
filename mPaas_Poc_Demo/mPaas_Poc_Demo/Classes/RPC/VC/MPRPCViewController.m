//
//  MPRPCViewController.m
//  mPaas_Poc_Demo
//
//  Created by Raffaele on 2021/7/7.
//

#import "MPRPCViewController.h"
#import "MPRPCDefine.h"
#import "MPRPCClient.h"
#import "MPFriendJsonGetReq.h"
#import "MPLgCollectAddtoolJsonPostReq.h"

typedef void(^MPActionBlock)(void);

@interface MPRPCViewController ()

@end

@implementation MPRPCViewController

- (void)viewDidLoad {
    [super viewDidLoad];
        
    self.title = NSLocalizedString(@"移动网关", nil);
    self.view.backgroundColor = [UIColor whiteColor];
    
    CREATE_UI({
//        BUTTON_WITH_ACTION(NSLocalizedString(@"调用RPC: Get", nil), exampleRpcGet);
        BUTTON_WITH_ACTION(NSLocalizedString(@"调用RPC", nil), exampleRpcPost);
        BUTTON_WITH_ACTION(NSLocalizedString(@"调用RPC: 未验签", nil), exceptionGet);
        BUTTON_WITH_ACTION(NSLocalizedString(@"调用RPC: 未加密", nil), decryptGet);
    })
}

#pragma mark - RPC Get
- (void)exampleRpcGet {
    __block NSString *response;
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    __block NSDictionary *userInfo = nil;
    [DTRpcAsyncCaller callAsyncBlock:^{
        @try {
            MPRPCClient *client = [[MPRPCClient alloc] init];
            MPFriendJsonGetReq *req = [self getRequest];
            response = [client friendJsonGet:req];
        } @catch (DTRpcException *exception) {
            userInfo = exception.userInfo;
            NSError *error = [userInfo objectForKey:@"kDTRpcErrorCauseError"];
            NSInteger code = error.code;
            dispatch_async(dispatch_get_main_queue(), ^{
                [MBProgressHUD hideHUDForView:self.view animated:YES];
                NSString *errorMsg = [NSString stringWithFormat:@"Rpc Exception code : %d", exception.code];
                [AUToast presentToastWithin:self.view withIcon:AUToastIconNetFailure text:errorMsg duration:1.5 logTag:@"demo" completion:nil];
                APLog(errorMsg);
            });
        }
    } completion:^{
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        if (response) {
            if ([response isKindOfClass:[NSDictionary class]]) {
                AUNoticeDialog *alert = [[AUNoticeDialog alloc] initWithTitle:NSLocalizedString(@"返回数据", nil) message:[response JSONString_mp] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
                [alert show];
            } else {
                if ([response isKindOfClass:[NSString class]] && [response isEqualToString:NSLocalizedString(@"限流触发，请勿频繁请求", nil)]) {
                    AUNoticeDialog *alert = [[AUNoticeDialog alloc] initWithTitle:NSLocalizedString(@"返回数据", nil) message:response delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
                    [alert show];
                }
            }
        }
    }];
}

- (MPFriendJsonGetReq *)getRequest {
    MPFriendJsonGetReq *req = [[MPFriendJsonGetReq alloc] init];
    req.name = @"mPaaS";
    req.pass = @"hello";
    
    return req;
}

#pragma mark - RPC Post
- (void)exampleRpcPost {
    __block NSString *response;
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [DTRpcAsyncCaller callAsyncBlock:^{
        @try {
            MPRPCClient *client = [[MPRPCClient alloc] init];
            response = [client lgCollectAddtoolJsonPost:[self getPostRequest]];
        } @catch (DTRpcException *exception) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [MBProgressHUD hideHUDForView:self.view animated:YES];
                NSString *errorMsg = [NSString stringWithFormat:@"Rpc Exception code : %d", exception.code];
                [AUToast presentToastWithin:self.view withIcon:AUToastIconNetFailure text:errorMsg duration:1.5 logTag:@"demo" completion:nil];
                APLog(errorMsg);
            });
        }
    } completion:^{
        [MBProgressHUD hideHUDForView:self.view animated:YES];
//        if (response) {
//            NSString *msg = [NSString stringWithFormat:@"Name: %@\nAge: %d\nVIP expire time: %lld\nVIP level: %d", response.name, response.age, response.vipInfo.expireTime, response.vipInfo.level];
//            AUNoticeDialog *alert = [[AUNoticeDialog alloc] initWithTitle:NSLocalizedString(@"返回数据", nil) message:[response JSONString_mp] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
//            [alert show];
//        }
        
        if ([response isKindOfClass:[NSDictionary class]]) {
            AUNoticeDialog *alert = [[AUNoticeDialog alloc] initWithTitle:NSLocalizedString(@"返回数据", nil) message:[response JSONString_mp] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alert show];
        } else {
            if ([response isKindOfClass:[NSString class]] && [response isEqualToString:NSLocalizedString(@"限流触发，请勿频繁请求", nil)]) {
                AUNoticeDialog *alert = [[AUNoticeDialog alloc] initWithTitle:NSLocalizedString(@"返回数据", nil) message:response delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
                [alert show];
            }
        }
    }];
}

- (MPLgCollectAddtoolJsonPostReq *)getPostRequest {
    MPLgCollectAddtoolJsonPostReq *req = [[MPLgCollectAddtoolJsonPostReq alloc] init];
    req.name = @"mPaaS";
    req.link = @"www.antgroup.com";
    
    return req;
}

#pragma mark - 未加签
- (void)exceptionGet {
    __block NSString *response;
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    __block NSDictionary *userInfo = nil;
    [DTRpcAsyncCaller callAsyncBlock:^{
        @try {
            MPRPCClient *client = [[MPRPCClient alloc] init];
            MPFriendJsonGetReq *req = [self getRequest];
            response = [client exceptionGet:req];
        } @catch (DTRpcException *exception) {
            userInfo = exception.userInfo;
            NSError *error = [userInfo objectForKey:@"kDTRpcErrorCauseError"];
            NSInteger code = error.code;
            dispatch_async(dispatch_get_main_queue(), ^{
                [MBProgressHUD hideHUDForView:self.view animated:YES];
                NSString *errorMsg = [NSString stringWithFormat:@"Rpc Exception code : %d", exception.code];
                [AUToast presentToastWithin:self.view withIcon:AUToastIconNetFailure text:errorMsg duration:1.5 logTag:@"demo" completion:nil];
                APLog(errorMsg);
            });
        }
    } completion:^{
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        if (response) {
            AUNoticeDialog *alert = [[AUNoticeDialog alloc] initWithTitle:NSLocalizedString(@"返回数据", nil) message:response delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alert show];
        }
    }];
}

#pragma mark - RPC 未加密
- (void)decryptGet {
    __block NSString *response;
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    __block NSDictionary *userInfo = nil;
    [DTRpcAsyncCaller callAsyncBlock:^{
        @try {
            MPRPCClient *client = [[MPRPCClient alloc] init];
            MPFriendJsonGetReq *req = [self getRequest];
            response = [client decryptFailed:req];
        } @catch (DTRpcException *exception) {
            userInfo = exception.userInfo;
            NSError *error = [userInfo objectForKey:@"kDTRpcErrorCauseError"];
            NSInteger code = error.code;
            dispatch_async(dispatch_get_main_queue(), ^{
                [MBProgressHUD hideHUDForView:self.view animated:YES];
                NSString *errorMsg = [NSString stringWithFormat:@"Rpc Exception code : %d", exception.code];
                [AUToast presentToastWithin:self.view withIcon:AUToastIconNetFailure text:errorMsg duration:1.5 logTag:@"demo" completion:nil];
                APLog(errorMsg);
            });
        }
    } completion:^{
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        if (response) {
            if ([response isKindOfClass:[NSDictionary class]]) {
                AUNoticeDialog *alert = [[AUNoticeDialog alloc] initWithTitle:NSLocalizedString(@"返回数据", nil) message:[response JSONString_mp] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
                [alert show];
            } else {
                if ([response isKindOfClass:[NSString class]] && [response isEqualToString:NSLocalizedString(@"限流触发，请勿频繁请求", nil)]) {
                    AUNoticeDialog *alert = [[AUNoticeDialog alloc] initWithTitle:NSLocalizedString(@"返回数据", nil) message:response delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
                    [alert show];
                }
            }
        }
    }];
}

@end
