//
//  RRSegmentView.m
//  RRSegmentController
//
//  Created by Ron on 2017/3/21.
//  Copyright © 2017年 Ron. All rights reserved.
//

#import "RRSegmentView.h"

static CGFloat const kButtonWidth = 80;
static CGFloat const kButtonPadding = 10;

@interface RRSegmentView ()
{
    UIButton *_selectedButton;
    CGFloat   _contentSizeWidth;
    BOOL      _isProcessing;
}

@property (strong, nonatomic) NSArray        *titleArray;
@property (strong, nonatomic) NSMutableArray *buttonArray;

@property (strong, nonatomic) UIView        *bottomLineView;
@property (strong, nonatomic) UIScrollView  *bgScrollView;

@property (copy,   nonatomic) RRSegmentViewHandler segmentHandler;

@end

@implementation RRSegmentView

- (instancetype)initWithFrame:(CGRect)frame titleArray:(NSArray *)titleArray itemSelected:(RRSegmentViewHandler)handler {
    if (self = [super initWithFrame:frame]) {
        _titleArray = titleArray;
        if (handler) {
            _segmentHandler = handler;
        }
        [self loadUI];
    }
    return self;
}

- (void)loadUI {
    _bgScrollView = [[UIScrollView alloc] initWithFrame:self.bounds];
    
    _contentSizeWidth = (kButtonWidth + kButtonPadding) * _titleArray.count - kButtonPadding;
    
    [_bgScrollView setContentSize:CGSizeMake(_contentSizeWidth, self.bounds.size.height)];
    [_bgScrollView setShowsHorizontalScrollIndicator:NO];
    [_bgScrollView setShowsVerticalScrollIndicator:NO];
    
    _buttonArray = [[NSMutableArray alloc] initWithCapacity:0];
    
    for (int i = 0; i < _titleArray.count; i++) {
        UIButton *titleButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [titleButton setFrame:CGRectMake(i * (kButtonWidth + kButtonPadding), 0, kButtonWidth, self.bounds.size.height - 2)];
        [titleButton setTitle:_titleArray[i] forState:UIControlStateNormal];
        [titleButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [titleButton setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
        [titleButton addTarget:self action:@selector(onClickTitleButton:) forControlEvents:UIControlEventTouchUpInside];
        
        [_bgScrollView addSubview:titleButton];
        
        [_buttonArray addObject:titleButton];
        
        if (i == 0) {
            _selectedButton = titleButton;
            [_selectedButton setSelected:YES];
        }
    }
    
    _bottomLineView = [[UIView alloc] initWithFrame:CGRectMake(0, self.bounds.size.height - 2, kButtonWidth, 2)];
    [_bottomLineView setBackgroundColor:[UIColor redColor]];
    
    [_bgScrollView addSubview:_bottomLineView];
    
    [self addSubview:_bgScrollView];
}

- (void)onClickTitleButton:(UIButton *)button {
    if (_selectedButton == button) {
        return;
    }
    
    NSInteger oldIndex = [_buttonArray indexOfObject:_selectedButton];
    NSInteger newIndex = [_buttonArray indexOfObject:button];
    
    BOOL animated = labs(oldIndex - newIndex) < 2;
    
    [_selectedButton setSelected:NO];
    _selectedButton = button;
    [_selectedButton setSelected:YES];
    
    [_bgScrollView scrollRectToVisible:_selectedButton.frame animated:YES];
    
    CGFloat buttonX = _selectedButton.frame.origin.x;
    CGRect oldFrame = _bottomLineView.frame;
    
    CGRect newFrame = CGRectMake(buttonX, oldFrame.origin.y, kButtonWidth, 2);
    
    _isProcessing = YES;
    
    [UIView animateWithDuration:0.28
                     animations:^{
                         [_bottomLineView setFrame:newFrame];
                     } completion:^(BOOL finished) {
                         if (finished) {
                             _isProcessing = NO;
                         }
                     }];
    
    if (self.segmentHandler) {
        self.segmentHandler(newIndex, animated);
    }
}

#pragma mark - ContentViewScroll
- (void)contentViewScrollOffsetX:(CGFloat)offsetX {
    if (_isProcessing) {
        return;
    }
    CGFloat oldX = _selectedButton.frame.origin.x;
    
    CGFloat newX = offsetX / self.frame.size.width * (kButtonWidth + kButtonPadding);
    
    if (newX >= oldX + kButtonWidth || newX <= oldX - kButtonWidth) {
        [_selectedButton setSelected:NO];
        _selectedButton = (UIButton *)_buttonArray[(int)(newX / kButtonWidth)];
        [_selectedButton setSelected:YES];
        
        [_bgScrollView scrollRectToVisible:_selectedButton.frame animated:YES];
    }
    
    CGRect newFrame = CGRectMake(newX, self.bounds.size.height - 2, kButtonWidth, 2);
    [_bottomLineView setFrame:newFrame];
}

@end
