//
//  MyJsApiHandler4MyApp.m
//  MPH5Demo_pod
//
//  Created by wyy on 2021/5/18.
//  Copyright © 2021 yangwei. All rights reserved.
//

#import "MyJsApiHandler4MyApp.h"

@implementation MyJsApiHandler4MyApp

- (void)handler:(NSDictionary *)data context:(PSDContext *)context callback:(PSDJsApiResponseCallbackBlock)callback
 {
     [super handler:data context:context callback:callback];
     
     NSString *userId = @"admin";
     if ([userId length] > 0) {
         callback(@{@"success":@YES, @"userId":userId});
     } else {
         callback(@{@"success":@NO});
     }
     
 }

@end
