//
//  ViewController.m
//  PHStockChart
//
//  Created by Peter on 5/10/16.
//  Copyright © 2016 Peter. All rights reserved.
//

#import "ViewController.h"

#import "GuPiaoView.h"


@interface ViewController ()

@property (nonatomic,weak) GuPiaoView * gupiaoV;

@property (weak, nonatomic) IBOutlet UIButton *button;

@property (nonatomic,assign) BOOL isFullScreen;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    GuPiaoView *fns = [[GuPiaoView alloc] initWithFrame:CGRectMake(0, 60, 300, 400)];
    
    
    _gupiaoV = fns;
    
    _gupiaoV.isShiZiXianShown = YES;
    
    
    [self settingData];
    [self settudata];
    
    
    [_gupiaoV initWithChartStyle:PHChartStyleLaZhuTu];
    _gupiaoV.laZhuTuSubStyle = PHLaZhuTuSubstyleVR;
    
    _gupiaoV.backgroundColor = [UIColor whiteColor];
    _isFullScreen = NO;
    
    UITapGestureRecognizer* singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapScreen)];
    singleTap.numberOfTapsRequired = 2;
    [self.gupiaoV addGestureRecognizer:singleTap];
    
    [self.view addSubview:fns];
    
}




-(void)tapScreen {
    
    if (_isFullScreen) {
        [self clickRecover];
    }
    else
    {
        
        [self clickB:nil];
    }
    
}


-(void)clickRecover {
    
    _isFullScreen = NO;
    [self setNeedsStatusBarAppearanceUpdate];
    [UIView animateWithDuration:2.0 animations:^{
        _gupiaoV.transform = CGAffineTransformMakeRotation(0);
        _gupiaoV.frame = CGRectMake(0, 80, self.view.frame.size.width, 300);
        
        
    } completion:^(BOOL finished) {
    }];
    [_gupiaoV setNeedsDisplay];
}




-(BOOL)prefersStatusBarHidden {
    return _isFullScreen ? YES : NO ;
}


- (IBAction)clickB:(id)sender {
    _isFullScreen = YES;
    [self setNeedsStatusBarAppearanceUpdate];
    [UIView animateWithDuration:2.0 animations:^{
        CGPoint tempt;
        tempt = _gupiaoV.center;
        tempt.x = self.view.frame.size.width / 2;
        tempt.y = self.view.frame.size.height / 2;
        
        CGRect tem = _gupiaoV.bounds;
        tem.size.width = self.view.frame.size.height;
        tem.size.height = self.view.frame.size.width;
        
        _gupiaoV.center = tempt;
        _gupiaoV.bounds = tem;
        _gupiaoV.transform = CGAffineTransformMakeRotation(M_PI/2);
        
    } completion:^(BOOL finished) {
        
        
        
    }];
    
    
    [_gupiaoV setNeedsDisplay];
    
}


-(void)settudata {
    
    
    [_gupiaoV initWithLabel];
    
    [_gupiaoV initWithZuoShou:3220 zongL:@"87.3万"];
    
    
    NSString *path1 = [[NSBundle mainBundle] pathForResource:@"dazhexian" ofType:@"plist"];
    NSArray *arr1 = [[NSArray alloc] initWithContentsOfFile:path1];
    
    
    NSArray *arr2 = [NSArray array];
    
    NSString *path3 = [[NSBundle mainBundle] pathForResource:@"zhutu" ofType:@"plist"];
    NSArray *arr3 = [[NSArray alloc] initWithContentsOfFile:path3];
    
    NSMutableArray *arr = [NSMutableArray array];
    for (NSNumber * num  in arr1 ){
        NSNumber *numtempt =  [NSNumber numberWithFloat:[num floatValue] - 40];
        [arr addObject:numtempt];
    }
    arr2 = arr;
    
    [_gupiaoV fenShiWithDaZheData:arr1 xiaoZheData:arr2 zhuData:arr3];
    
}


-(void)settingData {
    
    
    
    NSString *path1 = [[NSBundle mainBundle] pathForResource:@"lazhutu1" ofType:@"plist"];
    NSArray *arr1 = [[NSArray alloc] initWithContentsOfFile:path1];
    
    
    [_gupiaoV initWithLZTarray:arr1];
    
    NSString *path2 = [[NSBundle mainBundle] pathForResource:@"vol" ofType:@"plist"];
    NSArray *arr2 = [[NSArray alloc] initWithContentsOfFile:path2];
    [_gupiaoV initWithVol:arr2];
    
    
    
    NSString *path3 = [[NSBundle mainBundle] pathForResource:@"macd" ofType:@"plist"];
    NSArray *arr3 = [[NSArray alloc] initWithContentsOfFile:path3];
    [_gupiaoV initWithMACD:arr3];
    
    
    
    NSString *path4 = [[NSBundle mainBundle] pathForResource:@"kdj" ofType:@"plist"];
    NSArray *arr4 = [[NSArray alloc] initWithContentsOfFile:path4];
    [_gupiaoV initWithKDJ:arr4];
    [_gupiaoV initWithRSI:arr4];
    [_gupiaoV initWithBIAS:arr4];
    [_gupiaoV initWithDMA:arr4];
    [_gupiaoV initWithOBV:arr4];
    [_gupiaoV initWithROC:arr4];
    [_gupiaoV initWithMTM:arr4];
    [_gupiaoV initWithCR:arr4];
    [_gupiaoV initWithBRAR:arr4];
    [_gupiaoV initWithVR:arr4];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
