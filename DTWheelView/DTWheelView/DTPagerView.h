//
//  DTPagerView.h
//  DTWheelView
//
//  Created by Teplot_03 on 16/8/26.
//  Copyright © 2016年 Teplot_03. All rights reserved.
//

#import <UIKit/UIKit.h>
@class DTPagerView;

@protocol DTPagerViewDelegate <NSObject>

- (void)pagerViewClicked:(DTPagerView *)pagerView;

@end

typedef enum : NSUInteger {
    PagerViewSizeStyleBiger,
    PagerViewSizeStyleSmaller,
} PagerViewSizeStyle;

@interface DTPagerView : UIView
@property (nonatomic, weak) id<DTPagerViewDelegate> delegate;

@property (nonatomic, strong) NSDictionary *data;

@property (nonatomic, assign) PagerViewSizeStyle sizeStyle;

@end
