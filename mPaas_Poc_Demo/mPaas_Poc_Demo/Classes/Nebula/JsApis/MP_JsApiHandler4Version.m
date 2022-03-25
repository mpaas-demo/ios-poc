//
//  MP_JsApiHandler4Version.m
//  mPaas_Poc_Demo
//
//  Created by wyy on 2021/7/17.
//

#import "MP_JsApiHandler4Version.h"

@implementation MP_JsApiHandler4Version

- (void)handler:(NSDictionary *)data context:(PSDContext *)context callback:(PSDJsApiResponseCallbackBlock)callback
 {
     
     [super handler:data context:context callback:callback];
     
     NSString *version = [NSString stringWithFormat:@"V%@",[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]];
     
     AUNoticeDialog *alert = [[AUNoticeDialog alloc] initWithTitle:@"版本" message:[NSString stringWithFormat:@"当前app版本是：%@",version] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
     [alert show];
     
 }

@end
