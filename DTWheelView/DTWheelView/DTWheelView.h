//
//  DTWheelView.h
//  DTWheelView
//
//  Created by Teplot_03 on 16/8/26.
//  Copyright © 2016年 Teplot_03. All rights reserved.
//

#import <UIKit/UIKit.h>

#define ScreenSize [[UIScreen mainScreen] bounds].size

@interface DTWheelView : UIView

+ (instancetype)showController:(UIViewController *)ctr frame:(CGRect)frame imgs:(NSArray *)imgs;

@end
