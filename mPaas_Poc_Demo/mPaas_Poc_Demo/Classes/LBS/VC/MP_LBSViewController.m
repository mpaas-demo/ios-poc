//
//  MP_LBSViewController.m
//  mPaas_Poc_Demo
//
//  Created by wyy on 2021/7/7.
//

#import "MP_LBSViewController.h"

@interface MP_LBSViewController ()<AMapSearchDelegate>

@property (nonatomic,strong) MAMapView *mapView;

@property (nonatomic,strong) AMapSearchAPI *mapSearch;

@property (nonatomic,strong) UILabel *addressLab;

@end

@implementation MP_LBSViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = NSLocalizedString(@"定位", nil);
    
    [AMapServices sharedServices].apiKey = @"b605ee79b590dd63b0171cb3ac395b44";
        
    CREATE_UI({
        BUTTON_WITH_ACTION(NSLocalizedString(@"开始定位", nil), updateLocation)
    })
    
    [self.view addSubview:self.addressLab];
    [self.view addSubview:self.mapView];
    
}

- (void)updateLocation {
    [LBSLocationManager locationWithRequestBlock:^(LBSLocationRequest *request) {
        request.bizType = @"MPAAS-DEMO";
    } onFinishedLocating:^(BOOL success, CLLocation *location, NSError *error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            NSString *message =[NSString stringWithFormat:@"longitude: %.5f, latitude: %.5f, accuracy: %.3f",location.coordinate.longitude, location.coordinate.latitude, location.horizontalAccuracy];
            
            CLLocationCoordinate2D coordinate = CLLocationCoordinate2DMake(location.coordinate.latitude, location.coordinate.longitude);
            [self.mapView setCenterCoordinate:coordinate animated:YES];
            [self reGoecodeSearchWithCoordinate:coordinate];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                AUNoticeDialog *alert = [[AUNoticeDialog alloc] initWithTitle:NSLocalizedString(@"定位成功", nil) message:message];
                [alert addButton:NSLocalizedString(@"知道了", nil) actionBlock:^{}];
                [alert show];
            });
           
        });
    }];
    
}

//逆地理编码
- (void)reGoecodeSearchWithCoordinate:(CLLocationCoordinate2D)coordinate
{
    AMapReGeocodeSearchRequest *regeo = [[AMapReGeocodeSearchRequest alloc] init];
    regeo.location = [AMapGeoPoint locationWithLatitude:coordinate.latitude longitude:coordinate.longitude];
    regeo.requireExtension = YES;
    [self.mapSearch AMapReGoecodeSearch:regeo];
}

#pragma mark---AMapSearchDelegate
- (void)onReGeocodeSearchDone:(AMapReGeocodeSearchRequest *)request response:(AMapReGeocodeSearchResponse *)response
{
    if (response.regeocode) {
        self.addressLab.text = [NSString stringWithFormat:@"当前地址：%@",response.regeocode.formattedAddress];
    }
}

- (void)AMapSearchRequest:(id)request didFailWithError:(NSError *)error
{
    NSLog(@"Error: %@", error);
}

- (void)onPOISearchDone:(AMapPOISearchBaseRequest *)request response:(AMapPOISearchResponse *)response
{
    if (response.pois.count == 0)
    {
        return;
    }
    
    //解析response获取POI信息，具体解析见 Demo
}

#pragma mark---lazy

- (UILabel *)addressLab
{
    if (!_addressLab) {
        _addressLab = [[UILabel alloc] initWithFrame:CGRectMake(25, 200, self.view.bounds.size.width - 50, 80)];
        _addressLab.numberOfLines = 3;
        _addressLab.textColor = UIColor.blackColor;
        _addressLab.font = [UIFont systemFontOfSize:17];
        [self.view addSubview:_addressLab];
        _addressLab.text = @"当前地址：";
    }
    return _addressLab;
}

- (AMapSearchAPI *)mapSearch
{
    if (!_mapSearch) {
        _mapSearch = AMapSearchAPI.new;
        _mapSearch.delegate = self;
    }
    return _mapSearch;
}


- (MAMapView *)mapView
{
    if (!_mapView) {
        _mapView = MAMapView.new;
        _mapView.frame = CGRectMake(0, 300, UIScreen.mainScreen.bounds.size.width, UIScreen.mainScreen.bounds.size.height - 300);
        _mapView.mapType = MAMapTypeStandard;
        //显示用户当前位置
        _mapView.showsUserLocation = YES;
        _mapView.userTrackingMode = MAUserTrackingModeFollow;
        _mapView.zoomLevel = 14.0;
    }
    return _mapView;
}

@end
