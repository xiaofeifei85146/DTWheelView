//
//  ViewController.m
//  DTWheelView
//
//  Created by Teplot_03 on 16/8/26.
//  Copyright © 2016年 Teplot_03. All rights reserved.
//

#import "ViewController.h"
#import "DTWheelView.h"



@interface ViewController ()<DTWheelViewDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSMutableArray *mutArr = [NSMutableArray array];
    
    for (int i = 0; i<8; i++) {
        NSString *name = [NSString stringWithFormat:@"img%d.jpg",i];
        UIImage *img = [UIImage imageNamed:name];
        [mutArr addObject:@{@"title":name,@"content":[NSString stringWithFormat:@"我是第%d张图片，我是第%d张图片，我是第%d张图片，我是第%d张图片",i,i,i,i], @"img":img}];
    }
    
    DTWheelView *wheelView = [DTWheelView wheelWithFrame:CGRectMake(0, 100, ScreenSize.width, 300) imgs:mutArr];
    wheelView.delegate = self;
    [self.view addSubview:wheelView];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)wheelViewDidClickMidItem:(DTWheelView *)wheelView {
    NSLog(@"点击了中间的那一个");
}

@end
