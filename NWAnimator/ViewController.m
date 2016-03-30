//
//  ViewController.m
//  NWAnimator
//
//  Created by Nicholas White on 3/28/16.
//  Copyright © 2016 Nicholas White. All rights reserved.
//

#import "ViewController.h"
#import "NWAnimator.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UILabel *flyingLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 30)];
    flyingLabel.text = @"Watch me!";
    [self.view addSubview:flyingLabel];
    [NWAnimator animateForKey:@"flyingLabel" duration:1 animate:^{
        flyingLabel.center = self.view.center;
        flyingLabel.transform = CGAffineTransformMakeRotation(M_PI);
    }];
    [NWAnimator animateForKey:@"flyingLabel" duration:1 animate:^{
        flyingLabel.transform = CGAffineTransformScale(CGAffineTransformMakeRotation(M_PI * 2), 2.0, 2.0);
    }];
    // By setting duration to 0, we reset the rotation back to 0 without spinning.
    // We delay for 1 second before applying the next step
    [NWAnimator animateForKey:@"flyingLabel" duration:0 delay:1.0 animate:^{
        flyingLabel.transform = CGAffineTransformMakeScale(2.0, 2.0);
    }];
    [NWAnimator animateForKey:@"flyingLabel" duration:0.5 animate:^{
        flyingLabel.transform = CGAffineTransformIdentity;
    }];
    [NWAnimator animateForKey:@"flyingLabel" duration:0.5 animate:^{
        flyingLabel.center = CGPointMake(self.view.frame.size.width, -20);
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
