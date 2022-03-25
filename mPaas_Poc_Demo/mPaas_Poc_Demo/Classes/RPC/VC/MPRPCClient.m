//
//  MPRPCClient.h
//  mPaas_Poc_Demo
//
//  Created by Raffaele on 2021/7/7.
//
#import "MPFriendJsonGetReq.h"
#import "MPLgCollectAddtoolJsonPostReq.h"
#import "MPRPCClient.h"

@implementation MPRPCClient

- (NSString *)friendJsonGet:(MPFriendJsonGetReq *)requestParam {
    DTRpcMethod *method = [[DTRpcMethod alloc] init];
    method.operationType = @"com.antcloud.request.get";
    method.checkLogin = NO;
    method.signCheck = YES;
    method.returnType = @"@\"NSString\"";

    return [[DTRpcClient defaultClient] executeMethod:method params:@[requestParam ? requestParam : [NSNull null]]];
}

/**************************************************************************/

- (NSString *)lgCollectAddtoolJsonPost:(MPLgCollectAddtoolJsonPostReq *)requestParam {
    DTRpcMethod *method = [[DTRpcMethod alloc] init];
    method.operationType = @"com.antcloud.request.post";
    method.checkLogin = NO;
    method.signCheck = YES;
    method.returnType = @"@\"NSString\"";

    return [[DTRpcClient defaultClient] executeMethod:method params:@[ requestParam ? requestParam : [NSNull null]]];
}

/**************************************************************************/

- (NSString *)exceptionGet:(MPFriendJsonGetReq *)requestParam {
    DTRpcMethod *method = [[DTRpcMethod alloc] init];
    method.operationType = @"com.antcloud.request.get";
    method.checkLogin = NO;
    method.signCheck = NO;
    method.returnType = @"@\"NSString\"";

    return [[DTRpcClient defaultClient] executeMethod:method params:@[requestParam ? requestParam : [NSNull null]]];
}

/**************************************************************************/

- (NSString *)decryptFailed:(MPFriendJsonGetReq *)requestParam {
    DTRpcMethod *method = [[DTRpcMethod alloc] init];
    method.operationType = @"com.antcloud.request.get";
    method.checkLogin = NO;
    method.signCheck = YES;
    method.isCrypt = YES;
    method.returnType = @"@\"NSString\"";

    return [[DTRpcClient defaultClient] executeMethod:method params:@[requestParam ? requestParam : [NSNull null]]];
}

/**************************************************************************/

@end
    
    
