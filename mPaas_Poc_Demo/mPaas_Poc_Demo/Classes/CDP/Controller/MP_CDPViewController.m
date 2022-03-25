//
//  MP_CDPViewController.m
//  mPaas_Poc_Demo
//
//  Created by Raffaele on 2021/7/20.
//

#import "MP_CDPViewController.h"
#import "MPCDPSpaceViewController.h"

// 展位ID
#define kBannerSpaceCode            @"space-rotation-pic"
#define kListSpaceCode              @"space-list-pic"
#define kSingleSpaceCode            @"space-banner-url"
#define kAnnouncementSpaceCode      @"space-annoucement-text-final"
#define kH5PopupSpaceCode           @"h5-popup-test"

#define kBanner_top                 @"banner_0315"
#define kBanner_bottom              @"banner_0315_bottom"

// 动态展位页面ID
#define kFullScreenViewId           @"MPCDPFullScreenViewController"
#define kListHeaderViewId           @"MPCDPLocationListHeaderViewController"
#define kListFooterViewId           @"MPCDPLocationListFooterViewController"
#define kScreenTopViewId            @"MPCDPLocationTopViewController"
#define kScreenBottomViewId         @"MPCDPLocationBottomViewController"
#define kFloatTopViewId             @"MPCDPLocationFloatTopViewController"
#define kH5PopupViewId              @"MPCDPH5PopupViewController"

@interface MP_CDPViewController ()

@end

@implementation MP_CDPViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"智能投放";
    self.view.backgroundColor = [UIColor whiteColor];
    
    CREATE_UI({
        BUTTON_WITH_ACTION(@"页面广告", webviewActivity)
//        BUTTON_WITH_ACTION(@"列表头部广告", listHeaderActivity:)
//        BUTTON_WITH_ACTION(@"列表尾部广告", listFooterActivity:)
//        BUTTON_WITH_ACTION(@"页面顶部广告", screenTopActivity:)
//        BUTTON_WITH_ACTION(@"页面底部广告", screenBottomActivity:)
//        BUTTON_WITH_ACTION(@"浮动顶部广告", floatTopActivity:)
    })
}

- (void)listHeaderActivity:(id)sender {
    [self showViewControllerWithDynamicViewID:kListHeaderViewId
                                        title:[(UIButton *)sender currentTitle]];
}

- (void)listFooterActivity:(id)sender {
    [self showViewControllerWithDynamicViewID:kListFooterViewId
                                        title:[(UIButton *)sender currentTitle]];
}

- (void)screenTopActivity:(id)sender {
    [self showViewControllerWithDynamicViewID:kScreenTopViewId
                                        title:[(UIButton *)sender currentTitle]];
}

- (void)screenBottomActivity:(id)sender {
    [self showViewControllerWithDynamicViewID:kScreenBottomViewId
                                        title:[(UIButton *)sender currentTitle]];
}

- (void)floatTopActivity:(id)sender {
    [self showViewControllerWithDynamicViewID:kFloatTopViewId
                                        title:[(UIButton *)sender currentTitle]];
}

- (void)h5PopupActivity:(id)sender {
    [self showViewControllerWithSpaceCode:kH5PopupSpaceCode
                                    title:[(UIButton *)sender currentTitle]];
}

- (void)bannerActivity:(id)sender {
    [self showViewControllerWithSpaceCode:kBannerSpaceCode
                                    title:[(UIButton *)sender currentTitle]];
}

- (void)listActivity:(id)sender {
    [self showViewControllerWithSpaceCode:kListSpaceCode
                                    title:[(UIButton *)sender currentTitle]];
}

- (void)singleActivity:(id)sender {
    [self showViewControllerWithSpaceCode:kSingleSpaceCode
                                    title:[(UIButton *)sender currentTitle]];
}

- (void)annoucementActivity:(id)sender {
    [self showViewControllerWithSpaceCode:kAnnouncementSpaceCode
                                    title:[(UIButton *)sender currentTitle]];
}

- (void)webviewActivity {
    [self showViewControllerWithSpaceCode:kBanner_top title:@"页面广告"];
}

- (void)showViewControllerWithSpaceCode:(NSString *)spaceCode title:(NSString *)title {
    MPCDPSpaceViewController *vc = [[MPCDPSpaceViewController alloc] init];
    vc.title = title;
    vc.spaceCode = spaceCode;
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)showViewControllerWithDynamicViewID:(NSString *)vcName title:(NSString *)title {
    Class vcClz = NSClassFromString(vcName);
    if (vcClz) {
        DTViewController *vc = [[vcClz alloc] init];
        vc.title = title;
        [self.navigationController pushViewController:vc animated:YES];
    }
}

@end
