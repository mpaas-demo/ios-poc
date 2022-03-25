//
//  MTJsApiHandler4OpenSms.m
//  MTPotal
//
//  Created by lizhen on 2017/9/5.
//  Copyright © 2017年 Alibaba. All rights reserved.
//

#import "MPJsApiHandler4OpenSms.h"
#import <MessageUI/MessageUI.h>      
@implementation MPJsApiHandler4OpenSms

- (void)handler:(NSDictionary *)data context:(PSDContext *)context callback:(PSDJsApiResponseCallbackBlock)callback
{
    [super handler:data context:context callback:callback];
    
    // 打开系统短信
    NSURL *url = [NSURL URLWithString:@"sms://xxx"];
    BOOL reasult = [[UIApplication sharedApplication] openURL:url];
    callback(@{@"success":@(reasult)});

    
//    id <NBNavigationTitleViewProtocol> titleView = context.currentViewController.navigationItem.titleView;
//
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        titleView.mainTitleLabel.text = @"含沙盒哈哈是的";
//        titleView.mainTitleLabel.superview.width = 100;
//    });
  
    
}


- (void)dealloc
{
    
}

@end
