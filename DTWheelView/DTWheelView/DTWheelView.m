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

@interface DTWheelView ()<UIGestureRecognizerDelegate>
{
    DTPagerView *lastPagerView;
}
@property (nonatomic, strong) NSArray *imgs;

@property (nonatomic, strong) UIScrollView *scrollView;


@end

@implementation DTWheelView

+ (instancetype)wheelWithFrame:(CGRect)frame imgs:(NSArray *)imgs{
    
    DTWheelView *wheel = [[DTWheelView alloc] initWithFrame:frame];
    
    NSMutableArray *temp = [NSMutableArray array];
    for (int i = 0; i<9; i++) {
        [temp addObjectsFromArray:imgs];
    }
    
    wheel.imgs = temp;
        
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

- (void)setupWithFrame:(CGRect)frame {
    self.userInteractionEnabled = YES;
    self.backgroundColor = [UIColor lightGrayColor];
    _imgs = [NSArray array];
    
    CGFloat width = self.frame.size.width;
    
    _scrollView = [[UIScrollView alloc] init];
    _scrollView.frame = CGRectMake(width/3, 0, CGRectGetWidth(self.frame)/3, CGRectGetHeight(self.frame));
    _scrollView.pagingEnabled = YES;
    _scrollView.clipsToBounds = NO;
    _scrollView.userInteractionEnabled = NO;
    [self addSubview:_scrollView];
    
    //手势
    UISwipeGestureRecognizer *swipeLeft = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeAction:)];
    swipeLeft.delegate = self;
    swipeLeft.direction = UISwipeGestureRecognizerDirectionLeft;
    [self addGestureRecognizer:swipeLeft];
    
    UISwipeGestureRecognizer *swipeRight = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeAction:)];
    swipeRight.delegate = self;
    swipeRight.direction = UISwipeGestureRecognizerDirectionRight;
    [self addGestureRecognizer:swipeRight];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(wheelViewTapAction:)];
    tap.numberOfTapsRequired = 1;
    tap.numberOfTouchesRequired = 1;
    [self addGestureRecognizer:tap];
    [tap requireGestureRecognizerToFail:swipeLeft];
    [tap requireGestureRecognizerToFail:swipeRight];
}

- (void)wheelViewTapAction :(UITapGestureRecognizer *)sender{

    //在这里获取点击的frame
    CGPoint point = [sender locationInView:sender.view];
    
    CGFloat x = point.x;
//    CGFloat y = point.y;
//    NSLog(@"touch (x, y) is (%f, %f)", x, y);
    
    //获取x和view的关系
    CGFloat wheelWidth = self.frame.size.width;
    if (x<wheelWidth/3) {
        //        NSLog(@"点击了左边");
        [self gotoPagerNext:NO];
    }else if (x>wheelWidth/3 && x<wheelWidth*2/3) {
//        NSLog(@"点击了中间");
        if ([self.delegate respondsToSelector:@selector(wheelViewDidClickMidItem:)]) {
            [self.delegate wheelViewDidClickMidItem:self];
        }
    }else if (x>wheelWidth*2/3) {
        //        NSLog(@"点击了右边");
        [self gotoPagerNext:YES];
    }
    
}


- (void)swipeAction:(UISwipeGestureRecognizer *)gesture {
    
    UISwipeGestureRecognizerDirection direction = gesture.direction;
    
    switch (direction) {
        case UISwipeGestureRecognizerDirectionLeft:
        {
            [self gotoPagerNext:YES];
        }
            break;
            
        case UISwipeGestureRecognizerDirectionRight:
        {
            [self gotoPagerNext:NO];
        }
            break;
            
        default:
            break;
    }
    
}

- (void)gotoPagerNext:(BOOL)isNext {
    
//    NSLog(@"%@",lastPagerView.data[@"title"]);
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
        if (weakSelf) {
            DTPagerView *pagerView = [weakSelf.scrollView viewWithTag:lastPagerView.tag+(isNext?1:(-1))];
            pagerView.sizeStyle = PagerViewSizeStyleBiger;
            lastPagerView = pagerView;
        }
        
    } completion:^(BOOL finished) {
        if (weakSelf) {
            weakSelf.userInteractionEnabled = YES;
        }
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

        [self.scrollView addSubview:pagerV];
        
        if (i == _imgs.count/9*4) {
            pagerV.sizeStyle = PagerViewSizeStyleBiger;
            lastPagerView = pagerV;
        }else {
            pagerV.sizeStyle = PagerViewSizeStyleSmaller;
        }
        
        if (i == imgs.count-1) {
            self.scrollView.contentSize = CGSizeMake(CGRectGetMaxX(pagerV.frame)+gap, CGRectGetHeight(self.frame));
            self.scrollView.contentOffset = CGPointMake(_imgs.count/9*4*(CGRectGetWidth(self.frame)/3), 0);
        }
    }
}



@end
