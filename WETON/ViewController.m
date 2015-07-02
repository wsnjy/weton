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
@property (weak, nonatomic) IBOutlet UIDatePicker *datePicker;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *cancel;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *Done;
@property (weak, nonatomic) IBOutlet UIView *viewDatePicker;
@property (weak, nonatomic) IBOutlet UIButton *btnCari;
@property (weak, nonatomic) IBOutlet UIView *viewDeskripsi;
@property (weak, nonatomic) IBOutlet UITextView *textDeskripsi;

@end

@implementation ViewController

@synthesize deskripsi_weton;
@synthesize textFieldDate;
@synthesize datePicker;
@synthesize viewDatePicker;
@synthesize btnCari;
@synthesize viewDeskripsi, textDeskripsi;

- (IBAction)cancelBarDatePicker:(id)sender {
    
    textFieldDate.text = @"Masukkan tanggal Lahir";
    [textFieldDate resignFirstResponder];
    viewDatePicker.hidden = YES;
    btnCari.enabled = NO;
    
}

- (IBAction)doneBarDatePicker:(id)sender {
    
    if (textFieldDate.text.length == 0) {
        [self cancelBarDatePicker:sender];
    }else{
        btnCari.enabled = YES;
    }
    
    viewDatePicker.hidden = YES;
    [textFieldDate resignFirstResponder];

}

- (IBAction)btnCariAction:(id)sender {
    
    NSLog(@"btn cari action");
    
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
    NSString *date = [format stringFromDate:datePicker.date];
    NSDate *parsed = [format dateFromString:date];
    
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
    NSString *stringHasil = [NSString stringWithFormat:@"Berdasarkan informasi tanggal lahir yang anda masukkan %@ %@ %@ \n Wetonnya adalah %@ \n %@",day,[self bulan:month],year,weton_lengkap, [[self getLocalJson:weton_lengkap] objectForKey:@"deskripsi"]];
    
    textDeskripsi.text = stringHasil;
    
    
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    
    viewDatePicker.hidden = YES;
    
    self.title = @"WETON";
    
    
    datePicker.datePickerMode = UIDatePickerModeDate;
    [datePicker setDate:[NSDate date]];
    [datePicker setMaximumDate:[NSDate date]];
    [datePicker addTarget:self action:@selector(updateTextField:) forControlEvents:UIControlEventValueChanged];
    textFieldDate.delegate = self;
    
    [textDeskripsi scrollRectToVisible:CGRectMake(0, 0, 1, 1) animated:NO];
}

-(void)textFieldDidBeginEditing:(UITextField *)textField {
    [textFieldDate resignFirstResponder];
    textFieldDate.text = @"";
    viewDatePicker.hidden = NO;
}


-(void)updateTextField:(id)sender
{
//    UIDatePicker *picker = (UIDatePicker*)textFieldDate.inputView;
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setTimeZone:[NSTimeZone localTimeZone]];
    [dateFormat setDateFormat:@"dd MMMM YYYY"];
//    [dateFormat setDateFormat:@"dd-MM-YYYY"];
    NSString *date = [dateFormat stringFromDate:datePicker.date];
    textFieldDate.text = [NSString stringWithFormat:@"%@",date];

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
        namaHari = @"Minggu";
    }
    
    return namaHari;
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
