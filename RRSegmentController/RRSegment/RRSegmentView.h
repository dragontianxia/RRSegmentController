//
//  RRSegmentView.h
//  RRSegmentController
//
//  Created by Ron on 2017/3/21.
//  Copyright © 2017年 Ron. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^RRSegmentViewHandler)(NSInteger selectedIndex, BOOL animated);

@interface RRSegmentView : UIView

- (instancetype)initWithFrame:(CGRect)frame titleArray:(NSArray *)titleArray itemSelected:(RRSegmentViewHandler)handler;

- (void)contentViewScrollOffsetX:(CGFloat)offsetX;

@end
