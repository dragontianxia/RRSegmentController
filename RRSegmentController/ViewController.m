//
//  ViewController.m
//  RRSegmentController
//
//  Created by Ron on 2017/3/21.
//  Copyright © 2017年 Ron. All rights reserved.
//

#import "ViewController.h"
#import "RRSegmentController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    RRSegmentController *segmentController = [[RRSegmentController alloc] init];
    [self addChildViewController:segmentController];
    [self.view addSubview:segmentController.view];
    [segmentController didMoveToParentViewController:self];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
