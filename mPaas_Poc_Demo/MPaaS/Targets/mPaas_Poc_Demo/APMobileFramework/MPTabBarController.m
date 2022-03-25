//
//  MPTabBarController.m

#import "MPTabBarController.h"
#import "DemoViewController.h"
#import "MP_HomeViewController.h"

@interface MPTabBarController ()

@end

@implementation MPTabBarController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self createChildVCs];
}

- (void)createChildVCs
{
    // 这里指定Tab使用的图片
    NSArray *baseImgs = [NSArray arrayWithObjects:
                         @"TabBar_HomeBar",
                         @"TabBar_Discovery",
                         @"TabBar_PublicService",
                         @"TabBar_Friends", nil];
    NSArray *selectImgs = [NSArray arrayWithObjects:
                           @"TabBar_HomeBar_Sel",
                           @"TabBar_Discovery_Sel",
                           @"TabBar_PublicService_Sel",
                           @"TabBar_Friends_Sel", nil];
    
    UIViewController* tab1ViewController = MP_HomeViewController.new;
    UIViewController* tab2ViewController = [[DTViewController alloc] init];
    UIViewController* tab3ViewController = [[DTViewController alloc] init];
    UIViewController* tab4ViewController = [[DemoViewController alloc] init];
    
    NSArray *navArray = @[tab1ViewController, tab2ViewController, tab3ViewController, tab4ViewController];
    NSArray *titles = @[@"首页", @"Tab2", @"Tab3", @"Tab4"];
    for (int i = 0; i < [navArray count]; i ++)
    {
        UIImage *bImg = [UIImage imageNamed:baseImgs[i]];
        UIImage *selectImg = [UIImage imageNamed:selectImgs[i]];

        UITabBarItem *item = [[UITabBarItem alloc] initWithTitle:NSLocalizedString(titles[i], nil) image:bImg selectedImage:selectImg];
        item.selectedImage = [item.selectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        item.image = [item.image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        item.tag = i;
        [(UIViewController *)navArray[i] setTabBarItem:item];
        ((UIViewController *)navArray[i]).title = NSLocalizedString(titles[i], nil);
    }
    
    self.viewControllers = navArray;
    self.selectedIndex = 0;
    [self.delegate tabBarController:self.tabBarController didSelectViewController:tab1ViewController];
}


- (void)loadView
{
    [super loadView];
    self.delegate = self;
}

- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController
{
    self.title = viewController.title;
    self.navigationItem.leftBarButtonItem = viewController.navigationItem.leftBarButtonItem;
    self.navigationItem.leftBarButtonItems = viewController.navigationItem.leftBarButtonItems;
    self.navigationItem.rightBarButtonItem = viewController.navigationItem.rightBarButtonItem;
    self.navigationItem.rightBarButtonItems = viewController.navigationItem.rightBarButtonItems;
}

@end
