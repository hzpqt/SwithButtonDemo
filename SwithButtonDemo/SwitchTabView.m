//
//  SwitchTabView.m
//  HXCoach
//
//  Created by pqt on 15/11/24.
//  Copyright © 2015年 hexin. All rights reserved.
//

#define HXPQT_SWITCH_BTN_COUNT 2      //默认按钮数量
#define HXPQT_SWITCH_BTN_WIDHT 30.f   //按钮宽度
#define HXPQT_SWITCH_BTN_HEIGHT 30.f  //按钮高度
#define HXPQT_SWITCH_BTN_BORDER_WIDTH 1.F //按钮边框宽度
#define HXPQT_SWITCH_BTN_BORDER_COLOR [UIColor clearColor].CGColor //按钮边框颜色
#define HXPQT_SWITCH_TAB_VIEW_BORDER_WIDTH 1.F //页面边框宽度
#define HXPQT_SWITCH_TAB_VIEW_BORDER_COLOR [UIColor grayColor].CGColor //页面边框颜色
#define HXPQT_SWITCH_BTN_SELECT_RADIUS 10.f  //按钮选中时圆角
#define HXPQT_SWITCH_TAB_VIEW_RADIUS 10.F //页面圆角
#define HXPQT_SWITCH_TAB_VIEW_WIDTH 60
#define HXPQT_SWITCH_TAB_VIEW_HEIGHT 30
#define HXPQT_SWITCH_BTN_DEFAULT_BACKGROUDCOLOR [UIColor clearColor].CGColor //按钮颜色
#define HXPQT_SWITCH_BTN_SELECT_BACKGROUDCOLOR [UIColor redColor].CGColor //按钮选中颜色
#define HXPQT_SWITCH_BTN_SELECT_LAYER_WIDTH 30.F
#define HXPQT_SWITCH_BTN_SELECT_LAYER_HEIGHT 25.F
#define HXPQT_SWITCH_BTN_SELECT_LAYER_XPADDING 3
#define HXPQT_SWITCH_BTN_SELECT_LAYER_YPADDING 3


#import "SwitchTabView.h"
#import "HexColors.h"

@interface SwitchTabView ()

@property (nonatomic,strong) NSMutableArray *btnArray;

@property (strong, nonatomic) CALayer *redBackgroundLayer;// 红色移动的动画背景

@end

@implementation SwitchTabView

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        [self setup];
    }
    
    return self;
}

-(void)setup
{
    self.layer.cornerRadius = HXPQT_SWITCH_TAB_VIEW_RADIUS;
    self.layer.borderWidth = HXPQT_SWITCH_TAB_VIEW_BORDER_WIDTH;
    self.layer.borderColor = HXPQT_SWITCH_TAB_VIEW_BORDER_COLOR;
    
    _btnArray = [NSMutableArray arrayWithCapacity:HXPQT_SWITCH_BTN_COUNT];
    
    for (int i = 0; i < HXPQT_SWITCH_BTN_COUNT; i++)
    {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        
        btn.layer.borderWidth = HXPQT_SWITCH_BTN_BORDER_WIDTH;
        btn.layer.borderColor = HXPQT_SWITCH_BTN_BORDER_COLOR;
        
        btn.bounds = CGRectMake(0, 0, HXPQT_SWITCH_BTN_WIDHT, HXPQT_SWITCH_BTN_HEIGHT);
        
        btn.tag = 1000 + i;
        
        [btn addTarget:self action:@selector(tabBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
        
        [_btnArray addObject:btn];
        
        [self addSubview:btn];
    }
    
    self.selectBtnIndex = 0;
    
    [self drawRedBackgroundLyaer];
}

-(void)drawRedBackgroundLyaer
{
    [self.redBackgroundLayer removeFromSuperlayer];
    
    self.redBackgroundLayer = [CALayer layer];
    
    self.redBackgroundLayer.anchorPoint = CGPointMake(0, 0);
    
    [self.redBackgroundLayer setFrame:CGRectZero];
    
    self.redBackgroundLayer.bounds = CGRectMake(0, 0, HXPQT_SWITCH_BTN_SELECT_LAYER_WIDTH, HXPQT_SWITCH_BTN_SELECT_LAYER_HEIGHT);
    
    self.redBackgroundLayer.cornerRadius = HXPQT_SWITCH_BTN_SELECT_RADIUS;
    self.redBackgroundLayer.backgroundColor = HXPQT_SWITCH_BTN_SELECT_BACKGROUDCOLOR;
    
    [self.layer insertSublayer:self.redBackgroundLayer above:self.layer];
}


+(instancetype)switchTabView
{
    SwitchTabView *tabView = [[SwitchTabView alloc] init];
    [tabView setFrame:CGRectMake(30, 40, 60, 40)];
    return tabView;
}

+(instancetype)switchTabView:(NSInteger)btnCount
{
    if (btnCount < 2)
    {
        btnCount = 2;
    }
    
    SwitchTabView *tabView = [[SwitchTabView alloc] init];
    
    tabView.tabCount = btnCount;
    
    if (tabView.btnArray.count < btnCount)
    {
        for (int i = 2; i < btnCount; i++)
        {
            UIButton *btn = [[UIButton alloc] init];
            
            btn.tag = 1000 + i;
            
            [btn addTarget:tabView action:@selector(tabBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
            
            [tabView.btnArray addObject:btn];
            
            [tabView addSubview:btn];
        }
    }
    
    return tabView;
}

-(void)tabBtnClicked:(UIButton *)btn
{
    NSInteger tag = btn.tag - 1000;
    
    [self setSelectedBtn:tag];
    
    if ([self.delegate respondsToSelector:@selector(tabBtnClicked:)])
    {
        [self.delegate tabBtnClicked:tag];
    }
}

-(void)setSelectedBtn: (NSInteger)index  //以0为第一个序号
{
    UIButton *btn = self.btnArray[index];
    
    if (index == 0)
    {
        self.redBackgroundLayer.position = CGPointMake(btn.frame.origin.x + HXPQT_SWITCH_BTN_SELECT_LAYER_XPADDING, btn.frame.origin.y + HXPQT_SWITCH_BTN_SELECT_LAYER_YPADDING);
    }
    else if( index == self.btnArray.count -1 )
    {
        self.redBackgroundLayer.position = CGPointMake(btn.frame.origin.x - HXPQT_SWITCH_BTN_SELECT_LAYER_XPADDING, btn.frame.origin.y + HXPQT_SWITCH_BTN_SELECT_LAYER_YPADDING);
    }
    else
    {
        self.redBackgroundLayer.position = CGPointMake(btn.frame.origin.x, btn.frame.origin.y + HXPQT_SWITCH_BTN_SELECT_LAYER_YPADDING);
    }
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    CGFloat btnWidth = self.frame.size.width / self.btnArray.count;
    CGFloat btnHeight = self.frame.size.height;
    
    for (int i = 0; i < self.btnArray.count; i++ )
    {
        UIButton *btn = self.btnArray[i];
        [btn setFrame:CGRectMake(i * btnWidth, 0, btnWidth, btnHeight)];
    }
    
    self.redBackgroundLayer.bounds = CGRectMake(0, HXPQT_SWITCH_BTN_SELECT_LAYER_YPADDING, btnWidth, btnHeight - HXPQT_SWITCH_BTN_SELECT_LAYER_YPADDING*2);
    
    [self setSelectedBtn:self.selectBtnIndex];
}
@end
