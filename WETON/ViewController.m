//
//  ViewController.m
//  WETON
//
//  Created by Wisnu Sanjaya on 6/6/15.
//  Copyright (c) 2015 wsnjy. All rights reserved.
//

/*
 $init = strtotime('1990-05-15');
 $weton = [
 0 => 'Pon',
 1 => 'Wage',
 2 => 'Kliwon',
 3 => 'Legi',
 4 => 'Pahing',
 ];
 
 $input_tanggal = '01-01-2010';
 
 $tanggal_cari = DateTime::createFromFormat('d-m-Y',$input_tanggal);
 $selisih = floor(($tanggal_cari->getTimestamp() - $init) / (60 * 60 * 24));
 $weton_anda = $weton[$selisih % 5 < 0 ? (5  + $selisih % 5) : $selisih % 5];
 
 echo "input tanggal: ". strftime('%d %B %Y', $tanggal_cari->getTimestamp());
 echo "<br>";
 echo strftime('%A',$tanggal_cari->getTimestamp());
 echo " ";
 echo $weton_anda;
 */

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    NSDateFormatter *format = [[NSDateFormatter alloc] init];
    NSString *init = [format dateFromString:@"1990-05-15"];

    
    NSArray *weton = @[@"Pon",
                       @"Wage",
                       @"Kliwon",
                       @"Legi",
                       @"Pahing"
                       ];

    
    [format setDateFormat:@"d-m-Y"];
    NSDate *now = [[NSDate alloc] init];
    NSString *dateString = [format stringFromDate:now];
    NSLog(@"The time: %@", dateString);
    
    NSDate *parsed = [format dateFromString:@"01-01-2010"];
    NSLog(@"The time: %@", [format stringFromDate:parsed]);

    
    
    NSString *input_tanggal = @"01-01-2010";
    
    NSString *hari = @"";
    
    NSString *wetonnya = @"";
    
    
    NSLog(@"weton anda %@ %@", hari,wetonnya);
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
