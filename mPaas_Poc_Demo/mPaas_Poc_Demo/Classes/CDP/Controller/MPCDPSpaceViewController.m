//
//  MPCDPSpaceViewController.m
//  mPaas_Poc_Demo
//
//  Created by Raffaele on 2021/7/21.
//

#import "MPCDPSpaceViewController.h"

@interface MPCDPSpaceViewController () <CDPPromotionCenterDelegate>

@property (nonatomic, strong) UIView *containerView;

@end

@implementation MPCDPSpaceViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self.view addSubview:self.containerView];
    self.containerView.hidden = YES;

    [CDPPromotionCenter addObserver:self
                  spaceCodesForView:@[@"banner_0315", @"banner_0315_bottom"]
                  spaceCodesForData:nil
                            extInfo:nil
                        immediately:NO];
}

#pragma mark - PromotionCenterDelegate
- (void)promotionViewDidFinishLoading:(CDPSpaceView *)spaceView
                            spaceCode:(NSString *)spaceCode {
    if (spaceView) {
        if ([spaceCode isEqualToString:@"banner_0315"]) {
            spaceView.frame = CGRectMake(0, 88, self.view.frame.size.width, 200);
            [self.view addSubview:spaceView];
        } else {
            spaceView.frame = CGRectMake(0, self.view.frame.size.height - 200 - 40, self.view.frame.size.width, 200);
            [self.view addSubview:spaceView];
        }
//        self.containerView.size_mp = spaceView.size_mp;
    }

//    self.containerView.hidden = spaceView == nil;
}

#pragma mark - getter and setter
- (UIView *)containerView {
    if (!_containerView) {
        _containerView = [[UIView alloc] initWithFrame:CGRectMake(0, 150, self.view.width, 300)];
        _containerView.backgroundColor = AU_COLOR_CLIENT_BG1;
        _containerView.layer.borderWidth = 1.0f;
        _containerView.layer.borderColor = AU_COLOR_APP_RED.CGColor;
    }

    return _containerView;
}

- (void)dealloc {
    [CDPPromotionCenter removeObserver:self];
}

@end
