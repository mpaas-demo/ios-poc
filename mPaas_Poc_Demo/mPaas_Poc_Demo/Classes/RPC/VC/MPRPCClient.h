//
//  MPRPCClient.h
//  mPaas_Poc_Demo
//
//  Created by Raffaele on 2021/7/7.
//

@class MPFriendJsonGetReq;
@class MPRPCUserInfo;
@class MPLgCollectAddtoolJsonPostReq;

@interface MPRPCClient : NSObject

- (NSString *)friendJsonGet:(MPFriendJsonGetReq *)requestParam;

- (NSString *)lgCollectAddtoolJsonPost:(MPLgCollectAddtoolJsonPostReq *)requestParam;

- (NSString *)exceptionGet:(MPFriendJsonGetReq *)requestParam;

- (NSString *)decryptFailed:(MPFriendJsonGetReq *)requestParam;

@end
    
