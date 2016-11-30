//
//  ViewController.m
//  CoreAnimationTes
//
//  Created by cao on 16/11/30.
//  Copyright © 2016年 daniel. All rights reserved.
//

#import "ViewController.h"
#import "OYCClock.h"

@interface ViewController ()


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    OYCClock *clock = [OYCClock clock];
    clock.center = self.view.center;
    
    [self.view addSubview:clock];
}

@end
