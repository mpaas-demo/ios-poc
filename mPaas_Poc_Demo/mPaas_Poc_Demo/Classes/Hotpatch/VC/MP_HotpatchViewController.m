//
//  MP_HotpatchViewController.m
//  mPaas_Poc_Demo
//
//  Created by wyy on 2021/7/8.
//

#import "MP_HotpatchViewController.h"

@interface MP_HotpatchViewController ()

@end

@implementation MP_HotpatchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = NSLocalizedString(@"热修复", nil);
    
    CREATE_UI({
        BUTTON_WITH_ACTION(NSLocalizedString(@"模拟崩溃", nil), createCrash)
    })
    
}

- (void)createCrash
{
    NSArray *array = @[NSLocalizedString(@"crash被Hotpacth热修复啦", nil), @"hello world"];
    NSString *message = array[2];
    
    AUNoticeDialog *alert = [[AUNoticeDialog alloc] initWithTitle:NSLocalizedString(@"提示", nil) message:message];
    [alert addButton:NSLocalizedString(@"知道了", nil) actionBlock:^{}];
    [alert show];
    
}



@end
