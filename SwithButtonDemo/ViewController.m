//
//  ViewController.m
//  SwithButtonDemo
//
//  Created by pqt on 16/3/7.
//  Copyright © 2016年 pqt. All rights reserved.
//

#import "ViewController.h"
#import "SwitchTabView.h"

#define TAB_COUNT 3

@interface ViewController () <SwitchTabViewDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    SwitchTabView *tabViewCount = [SwitchTabView switchTabView:TAB_COUNT];
    [tabViewCount setFrame:CGRectMake(CGRectGetMidX(self.view.frame) - 50 , CGRectGetMidY(self.view.frame) - 50, 100, 50)];
    tabViewCount.delegate = self;
    [self.view addSubview:tabViewCount];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark SwitchTabViewDelegate
-(void)tabBtnClicked:(NSInteger)btnIndex
{
    NSLog(@"第%ld个按钮按下",btnIndex);
}
@end
