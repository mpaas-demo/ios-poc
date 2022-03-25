//
//  MPaaSInterface+mPaas_Poc_Demo.m
//  mPaas_Poc_Demo
//
//  Created by wyy on 2021/07/05. All rights reserved.
//

#import "MPaaSInterface+mPaas_Poc_Demo.h"

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wobjc-protocol-method-implementation"

@implementation MPaaSInterface (mPaas_Poc_Demo)

- (BOOL)enableSettingService {
    return NO;
}

- (NSString *)userId {
    return @"66666666";
}

@end

#pragma clang diagnostic pop

