//
//  ViewController.m
//  OBFilterMenu
//
//  Created by Ivan Golikov on 09.01.16.
//  Copyright © 2016 Ivan Golikov. All rights reserved.
//

#import "ViewController.h"
#import "OBInitialCircleView.h"

@interface ViewController ()

@property (nonatomic, readonly) OBInitialCircleView             *circleView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _circleView = [[OBInitialCircleView alloc]initWithFrame:CGRectMake(50.0, 50.0, 120.0, 120.0)];
    [self.view addSubview:self.circleView];
}

@end
