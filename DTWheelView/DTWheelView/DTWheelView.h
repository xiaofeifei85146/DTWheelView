//
//  DTWheelView.h
//  DTWheelView
//
//  Created by Teplot_03 on 16/8/26.
//  Copyright © 2016年 Teplot_03. All rights reserved.
//

#import <UIKit/UIKit.h>
@class DTWheelView;

#define ScreenSize [[UIScreen mainScreen] bounds].size

@protocol DTWheelViewDelegate <NSObject>
@optional
- (void)wheelViewDidClickMidItem:(DTWheelView *)wheelView;

@end

@interface DTWheelView : UIView
@property (nonatomic, weak) id<DTWheelViewDelegate> delegate;

+ (instancetype)showController:(UIViewController *)ctr frame:(CGRect)frame imgs:(NSArray *)imgs;

@end
