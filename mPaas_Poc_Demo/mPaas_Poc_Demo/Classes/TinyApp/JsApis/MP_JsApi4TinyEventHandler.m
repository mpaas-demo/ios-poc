//
//  MP_JsApi4TinyEventHandler.m
//  mPaas_Poc_Demo
//
//  Created by wyy on 2021/7/6.
//

#import "MP_JsApi4TinyEventHandler.h"

@implementation MP_JsApi4TinyEventHandler

- (void)handler:(NSDictionary *)data context:(PSDContext *)context callback:(PSDJsApiResponseCallbackBlock)callback
{
    [super handler:data context:context callback:callback];
    AUNoticeDialog *dialog = [[AUNoticeDialog alloc] initWithTitle:@"我是原生的弹框" message:@"小程序向原生发送的事件已收到"];
    [dialog addButton:@"知道了" actionBlock:^{
          
    }];
    [dialog show];
    callback(@{@"success":@(1)});
}

@end
