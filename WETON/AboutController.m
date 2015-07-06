//
//  AboutController.m
//  WETON
//
//  Created by Wisnu Sanjaya on 6/25/15.
//  Copyright (c) 2015 wsnjy. All rights reserved.
//

#import "AboutController.h"

@interface AboutController ()

@end

@implementation AboutController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
}

- (void)viewWillAppear:(BOOL)animated{
    UIButton *buttonLeft =  [UIButton buttonWithType:UIButtonTypeCustom];
    [buttonLeft setImage:[UIImage imageNamed:@"back-button"] forState:UIControlStateNormal];
    [buttonLeft addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    [buttonLeft setFrame:CGRectMake(0, 0, 22, 22)];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:buttonLeft];

}

- (void)back{
    NSLog(@"pop");
    [self.navigationController popViewControllerAnimated:YES];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
