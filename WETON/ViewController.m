//
//  ViewController.m
//  WETON
//
//  Created by Wisnu Sanjaya on 6/6/15.
//  Copyright (c) 2015 wsnjy. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    NSArray *weton = @[@"Pon",
                       @"Wage",
                       @"Kliwon",
                       @"Legi",
                       @"Pahing"
                       ];

    
    NSDateFormatter *format = [[NSDateFormatter alloc] init];
    [format setDateFormat:@"yyyy-MM-dd"];
    
    NSDate *init = [format dateFromString:@"2015-06-03"];
    NSDate *parsed = [format dateFromString:@"2015-06-08"];
    
    NSLog(@"now %@",parsed);
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"EEEE"];

    NSString *dayName = [dateFormatter stringFromDate:parsed];

    
    int selisih = floor( ([self daysBetween:parsed and:init]));
    NSString *wetonnya = weton[selisih % 5 < 0 ? (5 + selisih % 5) : selisih % 5];

    NSLog(@"wetonnya  %@ %@",[self convertNamaHari:dayName],wetonnya);
    
    
    if (managedObjectContext == nil) {
        managedObjectContext = [self managedObjectContext];
    }


}

- (NSManagedObjectContext *)managedObjectContext {
    NSManagedObjectContext *context = nil;
    id delegate = [[UIApplication sharedApplication] delegate];
    if ([delegate performSelector:@selector(managedObjectContext)]) {
        context = [delegate managedObjectContext];
    }
    return context;
}


- (long)daysBetween:(NSDate *)dt1 and:(NSDate *)dt2 {
    NSUInteger unitFlags = NSCalendarUnitDay;
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *components = [calendar components:unitFlags fromDate:dt1 toDate:dt2 options:0];
    return [components day];
}

- (NSString *)convertNamaHari:(NSString *)day{
    
    NSString *namaHari;
    
    if ([day isEqualToString:@"Monday"]) {
        namaHari = @"Senin";
    }else if ([day isEqualToString:@"Tuesday"]){
        namaHari = @"Selasa";
    }else if ([day isEqualToString:@"Wednesday"]){
        namaHari = @"Rabu";
    }else if ([day isEqualToString:@"Thursday"]){
        namaHari = @"Kamis";
    }else if ([day isEqualToString:@"Friday"]){
        namaHari = @"Jumat";
    }else if ([day isEqualToString:@"Saturday"]){
        namaHari = @"Sabtu";
    }else{
        namaHari = @"Ahad";
    }
    
    return namaHari;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
