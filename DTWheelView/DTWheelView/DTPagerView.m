//
//  DTPagerView.m
//  DTWheelView
//
//  Created by Teplot_03 on 16/8/26.
//  Copyright © 2016年 Teplot_03. All rights reserved.
//

#import "DTPagerView.h"

#define ScaleOfAni 0.6

@interface DTPagerView ()


@property (nonatomic, strong) UIImageView *imgV;

@property (nonatomic, strong) UILabel *titleL;

@property (nonatomic, strong) UITextView *contentL;

@end

@implementation DTPagerView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupWithFrame:frame];
    }
    return self;
}

- (void)setupWithFrame:(CGRect)frame {
    self.backgroundColor = [UIColor colorWithRed:45/225.0 green:62/225.0 blue:80/225.0 alpha:1];
    self.layer.borderColor = [UIColor cyanColor].CGColor;
    self.layer.borderWidth = 2;
    CGFloat width = frame.size.width;
    CGFloat height = frame.size.height;
    
    [self addSubview:self.imgV];
    [self addSubview:self.titleL];
    [self addSubview:self.contentL];
    
    _imgV.frame = CGRectMake(0, 0, width, width);
    _titleL.frame = CGRectMake(width*0.05, CGRectGetMaxY(_imgV.frame), width*0.9, 20);
    _contentL.frame = CGRectMake(0, CGRectGetMaxY(_titleL.frame), width, height-5-CGRectGetMaxY(_titleL.frame));
    
}


- (void)setData:(NSDictionary *)data {
    _data = data;
    
    _imgV.image = data[@"img"];
    _titleL.text = data[@"title"];
    _contentL.text = data[@"content"];
}

- (void)setSizeStyle:(PagerViewSizeStyle)sizeStyle {
    switch (sizeStyle) {
        case PagerViewSizeStyleSmaller:
        {
            self.layer.borderWidth = 0;
            self.alpha = 0.3;
            self.transform = CGAffineTransformMakeScale(0.9f, 0.9f);
        }
            break;
            
        case PagerViewSizeStyleBiger:
        {
            self.layer.borderWidth = 2;
            self.alpha = 1.0;
            self.transform = CGAffineTransformMakeScale(1.0f, 1.0f);
        }
            break;
        default:
            break;
    }
}

- (UIImageView *)imgV {
    if (!_imgV) {
        _imgV = [[UIImageView alloc] init];
        _imgV.image = [UIImage imageNamed:@"default"];
    }
    return _imgV;
}

- (UILabel *)titleL {
    if (!_titleL) {
        _titleL = [[UILabel alloc] init];
        _titleL.text = @"title";
        _titleL.numberOfLines = 0;
        _titleL.textColor = [UIColor whiteColor];
    }
    return _titleL;
}

- (UITextView *)contentL {
    if (!_contentL) {
        _contentL = [[UITextView alloc] init];
        _contentL.backgroundColor = [UIColor clearColor];
        _contentL.textColor = [UIColor whiteColor];
        _contentL.text = @"我是土豪，我是土豪，我真的是土豪";
    }
    return _contentL;
}

@end
