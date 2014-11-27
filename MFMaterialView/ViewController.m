//
//  ViewController.m
//  MFMaterialView
//
//  Created by Matthew Faluotico on 11/18/14.
//  Copyright (c) 2014 mf. All rights reserved.
//

#import "ViewController.h"
#import "MFMaterialView.h"
#import "POP/pop.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    MFMaterialView *v = [[MFMaterialView alloc] initWithOptions
                         :@{kMFMGColor : [UIColor colorWithWhite:0.3 alpha:0.3],
                            kMFMGRadius: @170}];
    
    NSArray *subs = self.step.subviews;
    [self.view insertSubview:v belowSubview:self.b];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
//