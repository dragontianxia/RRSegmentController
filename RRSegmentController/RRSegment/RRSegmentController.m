//
//  RRSegmentController.m
//  RRSegmentController
//
//  Created by Ron on 2017/3/22.
//  Copyright © 2017年 Ron. All rights reserved.
//

#import "RRSegmentController.h"
#import "RRSegmentView.h"

static CGFloat const kSegmentViewHeight = 44;

@interface RRSegmentController ()<UIScrollViewDelegate>

@property (strong, nonatomic) RRSegmentView *segmentView;
@property (strong, nonatomic) UIScrollView  *contentScrollView;

@end

@implementation RRSegmentController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSArray *titleArray = @[@"首页", @"数码家电", @"服饰美妆", @"图书文创", @"家居生活", @"美食厨房"];
    
    CGFloat kScreenWidth = [[UIScreen mainScreen] bounds].size.width;
    CGFloat kContentHeight = self.view.frame.size.height - 64 - kSegmentViewHeight;
    
    __weak typeof(self) wSelf = self;
    _segmentView = [[RRSegmentView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, kSegmentViewHeight)
                                             titleArray:titleArray
                                           itemSelected:^(NSInteger selectedIndex, BOOL animated) {
                                               [wSelf.contentScrollView setContentOffset:CGPointMake(selectedIndex * kScreenWidth, 0) animated:animated];
                                           }];
    [self.view addSubview:_segmentView];
    
    _contentScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 44, kScreenWidth, kContentHeight)];
    [_contentScrollView setContentSize:CGSizeMake(titleArray.count * kScreenWidth, kContentHeight)];
    [_contentScrollView setPagingEnabled:YES];
    [_contentScrollView setShowsHorizontalScrollIndicator:NO];
    [_contentScrollView setBackgroundColor:[UIColor yellowColor]];
    
    for (int i = 0; i < titleArray.count; i++) {
        // Test content
        UILabel *contentLabel = [[UILabel alloc] initWithFrame:CGRectMake(i * kScreenWidth, 0, kScreenWidth, kContentHeight)];
        [contentLabel setFont:[UIFont systemFontOfSize:50]];
        [contentLabel setText:titleArray[i]];
        [contentLabel setTextAlignment:NSTextAlignmentCenter];
        
        [contentLabel setBackgroundColor:[UIColor cyanColor]];
        
        [_contentScrollView addSubview:contentLabel];
    }
    
    [self.view addSubview:_contentScrollView];
    [_contentScrollView setDelegate:self];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    [_segmentView contentViewScrollOffsetX:scrollView.contentOffset.x];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
