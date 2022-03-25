//
//  DemoViewController.m
//  test
//
//  Created by mPaaS on 16/11/21.
//  Copyright © 2016年 Alibaba. All rights reserved.
//

#import "DemoViewController.h"

@interface DemoViewController ()<AUBannerViewDelegate>

@property (nonatomic,strong) AUBannerView *bannerV;

@end

@implementation DemoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    NSInteger spaceY = 10;
    NSInteger height = 200;
    
    // 普通banner （深色）
    for (NSInteger i = 0; i < 1; i ++) {
        CGRect rect = CGRectMake(10, 10 + (height + spaceY) * i, self.view.width - 20, height);
        AUBannerView *bannerView = [[AUBannerView alloc] initWithFrame:rect
                                                               bizType:@"demo"
                                                            makeConfig:^(AUBannerViewConfig *config)
                                    {
                                        config.duration = 2;
                                        config.style = AUBannerStyleDeepColor;
                                        config.autoTurn = YES;
                                        config.autoStartTurn = YES;
                                    }];
        
        bannerView.delegate = self;
        bannerView.tag = 1;
        bannerView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.1];
        [self.view addSubview:bannerView];
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(10 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [bannerView updateConfigOperation:^(AUBannerViewConfig *config) {
                config.duration = 1;
                config.style = AUBannerStyleDeepColor;
                config.autoTurn = NO;
                config.autoStartTurn = NO;
            }];
        });
        
    }
    
    // 普通banner （浅色）
    for (NSInteger i = 1; i < 2; i ++) {
        CGRect rect = CGRectMake(10, 10 + (height + spaceY) * i, self.view.width - 20, height);
//        AUBannerView *bannerView = [[AUBannerView alloc] initWithFrame:rect
//                                                               bizType:@"demo"
//                                                            makeConfig:^(AUBannerViewConfig *config)
//                                    {
//                                        config.duration = 5;
//                                        config.style = AUBannerStyleLightColor;
//                                        config.autoTurn = YES;
//                                        config.autoStartTurn = YES;
//                                        config.pageControlDotTapEnabled = YES;
//                                    }];
//
//        bannerView.delegate = self;
//        bannerView.tag = 2;
//        bannerView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.1];
//        [self.view addSubview:bannerView];
    }

    
    
}

#pragma mark - AUBannerViewDelegate

- (NSInteger)numberOfItemsInBannerView:(AUBannerView *)bannerView
{
    return bannerView.tag == 1 ? 3 : 4;
}

- (UIView *)bannerView:(AUBannerView *)bannerView itemViewAtPos:(NSInteger)pos
{
    NSArray *array = nil;
    // 深色
    if (bannerView.tag == 1) {
        array = @[RGB(0x108EE9), RGB_A(0x108EE9, 0.5), [UIColor blueColor]];
    }
    // 浅色
    else {
        array = @[RGB(0xfFFFFF),RGB_A(0xeFFFFF, 0.8),RGB(0xcFFFFF),RGB_A(0xeFFFFF, 0.5),RGB_A(0xeFFFFF, 0.9)];
    }
    
    UIView *view = [[UIView alloc] init];
    view.backgroundColor = array[pos];
    return view;
}


- (void)bannerView:(AUBannerView *)bannerView didTapedItemAtPos:(NSInteger)pos
{
    NSLog(@"didTapedItemAtPos %@", @(pos));
}

//YXZ 5J -180  DX 1J -40 DBC -22 GRBC -16 LCB -16 PHG -16

//8点 - 10点 10点半

@end
