//
//  DTWheelView.m
//  DTWheelView
//
//  Created by Teplot_03 on 16/8/26.
//  Copyright © 2016年 Teplot_03. All rights reserved.
//

#import "DTWheelView.h"
#import "DTPagerView.h"

//随机颜色
#define randomColor [UIColor colorWithRed:arc4random()%256/256.0 green:arc4random()%256/256.0 blue:arc4random()%256/256.0 alpha:1];

@interface DTWheelView ()
{
    DTPagerView *lastPagerView;
}
@property (nonatomic, strong) NSArray *imgs;

@property (nonatomic, strong) UIScrollView *scrollView;


@end

@implementation DTWheelView

+ (instancetype)showController:(UIViewController *)ctr frame:(CGRect)frame imgs:(NSArray *)imgs{
    
    DTWheelView *wheel = [[DTWheelView alloc] initWithFrame:frame];
    
    wheel.imgs = imgs;
    
    [ctr.view addSubview:wheel];
    
    return wheel;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupWithFrame:frame];
    }
    return self;
}

//中间加上20 两边各去掉10
- (void)setupWithFrame:(CGRect)frame {
    self.backgroundColor = [UIColor lightGrayColor];
    _imgs = [NSArray array];
    
    _scrollView = [[UIScrollView alloc] init];
    _scrollView.frame = CGRectMake(125, 0, CGRectGetWidth(self.frame)-250, CGRectGetHeight(self.frame));
    _scrollView.pagingEnabled = YES;
    _scrollView.clipsToBounds = NO;
    _scrollView.userInteractionEnabled = NO;
    [self addSubview:_scrollView];
    
    UISwipeGestureRecognizer *swipeLeft = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeAction:)];
    swipeLeft.direction = UISwipeGestureRecognizerDirectionLeft;
    [self addGestureRecognizer:swipeLeft];
    //UISwipeGestureRecognizerDirectionRight
    UISwipeGestureRecognizer *swipeRight = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeAction:)];
    swipeRight.direction = UISwipeGestureRecognizerDirectionRight;
    [self addGestureRecognizer:swipeRight];
    self.userInteractionEnabled = YES;
}

- (void)swipeAction:(UISwipeGestureRecognizer *)gesture {
    
    UISwipeGestureRecognizerDirection direction = gesture.direction;
    
    switch (direction) {
        case UISwipeGestureRecognizerDirectionLeft:
        {
            NSLog(@"左滑了");
            [self gotoPagerNext:YES];
        }
            break;
            
        case UISwipeGestureRecognizerDirectionRight:
        {
            NSLog(@"右滑了");
            [self gotoPagerNext:NO];
        }
            break;
            
        default:
            break;
    }
    
}

- (void)gotoPagerNext:(BOOL)isNext {
    
    NSLog(@"%@",lastPagerView.data[@"title"]);
    if (isNext) {
        //如果左滑，是最后一个item就不变
        if (lastPagerView.tag == _imgs.count+10-1) return;
    }else {
        //如果右滑，是第一个item就不变
        if (lastPagerView.tag == 10) return;
    }
    
    
    
    CGPoint currentOffset = _scrollView.contentOffset;
    currentOffset.x += isNext?CGRectGetWidth(_scrollView.frame):(-CGRectGetWidth(_scrollView.frame));

    __weak typeof(self) weakSelf = self;
    self.userInteractionEnabled = NO;
    [UIView animateWithDuration:0.5 animations:^{
        
        _scrollView.contentOffset = currentOffset;
        lastPagerView.sizeStyle = PagerViewSizeStyleSmaller;
        
        DTPagerView *pagerView = [weakSelf.scrollView viewWithTag:lastPagerView.tag+(isNext?1:(-1))];
        pagerView.sizeStyle = PagerViewSizeStyleBiger;
        lastPagerView = pagerView;
    } completion:^(BOOL finished) {
        weakSelf.userInteractionEnabled = YES;
    }];
    
}

- (void)setImgs:(NSArray *)imgs {
    _imgs = imgs;
    CGFloat gap = self.scrollView.frame.size.width*0.05;
    CGFloat width = CGRectGetWidth(_scrollView.frame)-2*gap;
    
    for (int i = 0; i<imgs.count; i++) {
        DTPagerView *pagerV = [[DTPagerView alloc] initWithFrame:CGRectMake(gap + (2*gap+width)*i, 0, width, CGRectGetHeight(self.frame))];
        pagerV.data = imgs[i];
        pagerV.tag = 10+i;
        NSLog(@"%ld",pagerV.tag);
        [self.scrollView addSubview:pagerV];
        
        if (i == 0) {
            pagerV.sizeStyle = PagerViewSizeStyleBiger;
            lastPagerView = pagerV;
        }else {
            pagerV.sizeStyle = PagerViewSizeStyleSmaller;
        }
        
        if (i == imgs.count-1) {
            self.scrollView.contentSize = CGSizeMake(CGRectGetMaxX(pagerV.frame)+gap, CGRectGetHeight(self.frame));
        }
    }
}



@end
