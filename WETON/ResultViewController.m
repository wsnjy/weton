//
//  ResultViewController.m
//  WETON
//
//  Created by Wisnu Sanjaya on 7/1/15.
//  Copyright (c) 2015 wsnjy. All rights reserved.
//

#import "ResultViewController.h"
#import <pop/POP.h>

@interface ResultViewController ()
@property (weak, nonatomic) IBOutlet UITextView *textResult;
@property (weak, nonatomic) IBOutlet UILabel *lblTglLahir;
@property (weak, nonatomic) IBOutlet UILabel *lblWeton;
@property (weak, nonatomic) IBOutlet UIView *viewLoader;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *DukunconsY;
@property (nonatomic, assign) BOOL constante;
@property (nonatomic , retain) POPSpringAnimation *layoutAnimation;

@end

@implementation ResultViewController
@synthesize textResult;
@synthesize lblTglLahir, lblWeton;
@synthesize stringHasil, stringTglLahir, stringWeton;
@synthesize viewLoader;
@synthesize DukunconsY,constante;
@synthesize layoutAnimation;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [textResult scrollRangeToVisible:NSMakeRange(0, 1)];
    textResult.text = stringHasil;
    lblTglLahir.text = stringTglLahir;
    lblWeton.text = stringWeton;
    
    UIButton *buttonLeft =  [UIButton buttonWithType:UIButtonTypeCustom];
    [buttonLeft setImage:[UIImage imageNamed:@"back-button"] forState:UIControlStateNormal];
    [buttonLeft addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    [buttonLeft setFrame:CGRectMake(0, 0, 22, 22)];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:buttonLeft];

    UIButton *buttonRight =  [UIButton buttonWithType:UIButtonTypeCustom];
    [buttonRight setImage:[UIImage imageNamed:@"home-button"] forState:UIControlStateNormal];
    [buttonRight addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    [buttonRight setFrame:CGRectMake(0, 0, 22, 22)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:buttonRight];
    
    layoutAnimation = [POPSpringAnimation animationWithPropertyNamed:kPOPLayoutConstraintConstant];
    layoutAnimation.springSpeed = 0.1;
    
    constante = YES;
    [self performSelector:@selector(animateConstraint) withObject:self afterDelay:1.0 ];
    [self performSelector:@selector(animateConstraint) withObject:self afterDelay:4.0 ];

}

- (void)viewWillAppear:(BOOL)animated{
 
    
}

- (void)back{
    NSLog(@"pop");
    [self.navigationController popViewControllerAnimated:YES];
}


- (void)goToHome{
    NSLog(@"home");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)animateConstraint{
    
    if (constante == YES) {
        layoutAnimation.springBounciness = 15;
        layoutAnimation.toValue = @(75);
        [DukunconsY pop_addAnimation:layoutAnimation forKey:@"detailsContainerWidthAnimate"];
        constante = NO;
    }else{
        layoutAnimation.springBounciness = 1;
        layoutAnimation.toValue = @(125);
        [DukunconsY pop_addAnimation:layoutAnimation forKey:@"detailsContainerWidthAnimate"];
        [self performSelector:@selector(showResult) withObject:self afterDelay:3.0 ];
    }
}

- (void)showResult{
    viewLoader.hidden = YES;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
