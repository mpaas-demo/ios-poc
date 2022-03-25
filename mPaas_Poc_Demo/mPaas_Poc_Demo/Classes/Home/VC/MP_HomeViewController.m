//
//  MP_HomeViewController.m
//  mPaas_Poc_Demo
//
//  Created by wyy on 2021/7/5.
//

#import "MP_HomeViewController.h"

@interface MP_HomeViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UITableView *tableView;

@end

@implementation MP_HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.tableView];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"kNotificationLauncherDidAppear" object:nil];
}

- (NSArray *)dataList
{
    return @[
             @{@"name":@"版本升级提示", @"class":@"MP_UpgradeViewController"},
             @{@"name":@"开关配置", @"class":@"MP_SwitchViewController"},
             @{@"name":@"H5容器和离线包", @"class":@"MP_NebulaViewController"},
             @{@"name":@"小程序", @"class":@"MP_TinyAppViewController"},
             @{@"name":@"移动网关组件", @"class":@"MPRPCViewController"},
//             @{@"name":@"消息推送", @"class":@""},
             @{@"name":@"移动同步", @"class":@"SyncDemoViewController"},
//             @{@"name":@"移动分析", @"class":@"MP_AnalysisViewController"},
             @{@"name":@"智能投放", @"class":@"MP_CDPViewController"},
             @{@"name":@"设备标识", @"class":@"MP_DeviceViewController"},
             @{@"name":@"扫一扫组件", @"class":@"MP_ScanCodeController"},
             @{@"name":@"分享组件", @"class":@"MP_ShareViewController"},
             @{@"name":@"定位地图", @"class":@"MP_LBSViewController"},
//             @{@"name":@"UI组件", @"class":@"DemoComponentViewController"},
//             @{@"name":@"安全键盘", @"class":@"MP_SafeKeyboardController"},
//             @{@"name":@"音视频通话组件", @"class":@"MP_ARTVCViewController"},
             @{@"name":@"热修复", @"class":@"MP_HotpatchViewController"}];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self dataList].count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [UITableViewCell createCellWithTableView:tableView];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    if (indexPath.row < [self dataList].count) {
        NSDictionary *dic = [self dataList][indexPath.row];
//        cell.textLabel.text = dic[@"name"];
        cell.textLabel.text = NSLocalizedString(dic[@"name"], nil);
        cell.textLabel.font = [UIFont systemFontOfSize:18];
    }
   
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row < [self dataList].count) {
        NSDictionary *dic = [self dataList][indexPath.row];
        NSString *className = dic[@"class"];
        if (className.length) {
            Class cls = NSClassFromString(className);
            id vc = [[cls alloc] init];
            if ([vc isKindOfClass:UIViewController.class]) {
                [self.navigationController pushViewController:vc animated:YES];
            }
        }else{
            NSLog(@"没找到对应控制器");
        }
    }
}


- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.rowHeight = 64;
//        _tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }
    return _tableView;
}


@end
