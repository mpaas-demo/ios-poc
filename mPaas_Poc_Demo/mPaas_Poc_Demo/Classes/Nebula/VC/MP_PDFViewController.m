//
//  MP_PDFViewController.m
//  mPaas_Poc_Demo
//
//  Created by Raffaele on 2021/10/22.
//

#import "MP_PDFViewController.h"

@interface MP_PDFViewController ()

@end

@implementation MP_PDFViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    WKWebView *web = [[WKWebView alloc] initWithFrame:CGRectMake(0, 0, 640, 900)];
    web.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:web];
    
    NSURL *url = [NSURL URLWithString:@"https://gw.alipayobjects.com/os/basement_prod/1ce3efc7-a8e0-4111-83e5-4cc8de73170e.pdf"];
    [web loadRequest:[NSURLRequest requestWithURL:url]];
}

@end
