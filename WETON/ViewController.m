//
//  ViewController.m
//  WETON
//
//  Created by Wisnu Sanjaya on 6/6/15.
//  Copyright (c) 2015 wsnjy. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (nonatomic, retain) NSString *deskripsi_weton;

@end

@implementation ViewController

@synthesize deskripsi_weton;

- (void)viewDidLoad {
    
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    // Inisialisasi weton
    NSArray *weton = @[@"Pon",
                       @"Wage",
                       @"Kliwon",
                       @"Legi",
                       @"Pahing"
                       ];

    
    // setting format tanggal
    NSDateFormatter *format = [[NSDateFormatter alloc] init];
    [format setDateFormat:@"yyyy-MM-dd"];
    
    // bikin patokan tanggal (pon)
    NSDate *init = [format dateFromString:@"2015-06-03"];
    
    // input data
    NSDate *parsed = [format dateFromString:@"1989-02-06"];
    
    // format untuk nama hari
    [format setDateFormat:@"EEEE"];
    NSString *dayName = [format stringFromDate:parsed];

    // hitung selisih hari
    int selisih = floor( ([self daysBetween:init and:parsed]));
    
    // dapatkan wetonnya dengan menggunakan rumus untuk mendapatkan index array weton
    NSString *wetonnya = weton[selisih % 5 < 0 ? (5 + selisih % 5) : selisih % 5];
    
    // mencari komponen bulan
    NSDateComponents *components = [[NSCalendar currentCalendar] components:NSCalendarUnitMonth fromDate:parsed];
    int month = (int)[components month];

    [format setDateFormat:@"dd"];
    NSString *day = [format stringFromDate:parsed];
    [format setDateFormat:@"yyyy"];
    NSString *year = [format stringFromDate:parsed];
    

    NSString *weton_lengkap = [NSString stringWithFormat:@"%@ %@",[self convertNamaHari:dayName],wetonnya];
    
    NSLog(@"Berdasarkan informasi tanggal lahir yang anda masukkan %@ %@ %@ \n Wetonnya adalah %@ \n %@",day,[self bulan:month],year,weton_lengkap, [[self getLocalJson:weton_lengkap] objectForKey:@"deskripsi"]);
    
}

- (NSDictionary *)getLocalJson:(NSString *)wetonnya{
    
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"mbuh" ofType:@"json"];
    NSData *JSONData = [NSData dataWithContentsOfFile:filePath options:NSDataReadingMappedIfSafe error:nil];
    NSArray *jsoncat = [[NSArray alloc] initWithArray:[NSJSONSerialization JSONObjectWithData:JSONData options:NSJSONReadingMutableContainers error:nil]];
    
    NSDictionary *jsonWeton = [[NSDictionary alloc] init];
    
    for (NSDictionary  *dict in jsoncat) {
        
        if ([[dict objectForKey:@"nama_weton"] isEqualToString:wetonnya]) {
            jsonWeton = dict;
        }

    }
    
    return jsonWeton;
}


- (long)daysBetween:(NSDate *)dt1 and:(NSDate *)dt2 {
    NSUInteger unitFlags = NSCalendarUnitDay;
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *components = [calendar components:unitFlags fromDate:dt1 toDate:dt2 options:0];
    
    
    return [components day];
}

- (NSString *)bulan:(int)month{

    
    NSArray *arrayBulan = @[@"Januari",
                           @"Febuari",
                           @"Maret",
                           @"April",
                           @"Mei",
                           @"Juni",
                           @"Juli",
                           @"Agustus",
                           @"September",
                           @"Oktober",
                           @"November",
                           @"Desember",
                            ];
    
    NSString *namaBulan = arrayBulan[month-1];
    
    return namaBulan;
    
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
