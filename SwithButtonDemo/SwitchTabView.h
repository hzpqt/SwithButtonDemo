//
//  SwitchTabView.h
//  HXCoach
//
//  Created by pqt on 15/11/24.
//  Copyright © 2015年 hexin. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SwitchTabViewDelegate <NSObject>

@optional
-(void)tabBtnClicked:(NSInteger)btnTag;

@end

@interface SwitchTabView : UIView

@property (nonatomic,assign) NSInteger tabCount;   //按钮数量

@property (nonatomic,assign) NSInteger selectBtnIndex; //选中按钮序号

@property (nonatomic,weak) id<SwitchTabViewDelegate> delegate;//切换按钮委托

-(void)setSelectedBtn: (NSInteger)index;

+(instancetype)switchTabView;

+(instancetype)switchTabView:(NSInteger)tabCount;
@end
