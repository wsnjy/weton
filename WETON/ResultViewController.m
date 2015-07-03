//
//  ResultViewController.m
//  WETON
//
//  Created by Wisnu Sanjaya on 7/1/15.
//  Copyright (c) 2015 wsnjy. All rights reserved.
//

#import "ResultViewController.h"

@interface ResultViewController ()
@property (weak, nonatomic) IBOutlet UITextView *textResult;
@property (weak, nonatomic) IBOutlet UILabel *lblTglLahir;
@property (weak, nonatomic) IBOutlet UILabel *lblWeton;

@end

@implementation ResultViewController
@synthesize textResult;
@synthesize lblTglLahir, lblWeton;
@synthesize stringHasil, stringTglLahir, stringWeton;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [textResult scrollRangeToVisible:NSMakeRange(0, 1)];
    textResult.text = stringHasil;
    lblTglLahir.text = stringTglLahir;
    lblWeton.text = stringWeton;
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
