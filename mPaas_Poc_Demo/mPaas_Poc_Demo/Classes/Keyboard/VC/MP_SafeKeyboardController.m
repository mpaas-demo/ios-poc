//
//  MP_SafeKeyboardController.m
//  mPaas_Poc_Demo
//
//  Created by wyy on 2021/7/9.
//

#import "MP_SafeKeyboardController.h"

@interface MP_SafeKeyboardController ()

@property (nonatomic,strong) UITextField *textField;

@end

@implementation MP_SafeKeyboardController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"键盘";
    [self.view addSubview:self.textField];
    
}

- (UITextField *)textField
{
    if (!_textField) {
        _textField = [[UITextField alloc] initWithFrame:CGRectMake(30, 120, self.view.bounds.size.width - 60, 44)];
        _textField.borderStyle = UITextBorderStyleRoundedRect;
        _textField.placeholder = @"请输入内容";
        _textField.inputView = [AUNumKeyboards sharedKeyboard];
    }
    return _textField;
}

@end
