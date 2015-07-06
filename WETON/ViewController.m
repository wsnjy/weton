//
//  ViewController.m
//  WETON
//
//  Created by Wisnu Sanjaya on 6/6/15.
//  Copyright (c) 2015 wsnjy. All rights reserved.
//

#import "ViewController.h"
#import "ResultViewController.h"

#define IS_IPAD (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
#define IS_IPHONE (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
#define IS_RETINA ([[UIScreen mainScreen] scale] >= 2.0)

#define SCREEN_WIDTH ([[UIScreen mainScreen] bounds].size.width)
#define SCREEN_HEIGHT ([[UIScreen mainScreen] bounds].size.height)
#define SCREEN_MAX_LENGTH (MAX(SCREEN_WIDTH, SCREEN_HEIGHT))
#define SCREEN_MIN_LENGTH (MIN(SCREEN_WIDTH, SCREEN_HEIGHT))

#define IS_IPHONE_4_OR_LESS (IS_IPHONE && SCREEN_MAX_LENGTH < 568.0)
#define IS_IPHONE_5 (IS_IPHONE && SCREEN_MAX_LENGTH == 568.0)
#define IS_IPHONE_6 (IS_IPHONE && SCREEN_MAX_LENGTH == 667.0)
#define IS_IPHONE_6P (IS_IPHONE && SCREEN_MAX_LENGTH == 736.0)


@interface ViewController ()

@property (nonatomic, retain) NSString *deskripsi_weton;
@property (weak, nonatomic) IBOutlet UIDatePicker *datePicker;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *cancel;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *Done;
@property (weak, nonatomic) IBOutlet UIView *viewDatePicker;
@property (weak, nonatomic) IBOutlet UIButton *btnCari;
@property (weak, nonatomic) IBOutlet UIView *viewDeskripsi;
@property (weak, nonatomic) IBOutlet UITextView *textDeskripsi;
@property (nonatomic, retain) NSString *stringHasil;
@property (nonatomic, retain) NSString *stringTglLahir;
@property (nonatomic, retain) NSString *stringWeton;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *aboutButton;

@end

@implementation ViewController

@synthesize deskripsi_weton;
@synthesize textFieldDate;
@synthesize datePicker;
@synthesize viewDatePicker;
@synthesize btnCari;
@synthesize viewDeskripsi, textDeskripsi;
@synthesize stringHasil, stringTglLahir, stringWeton;
@synthesize aboutButton;


- (IBAction)aboutButtonAction:(id)sender {
    
    
    if(IS_IPHONE)
    {
        if (IS_IPHONE_5 || IS_IPHONE_6 || IS_IPHONE_6P){
            [self performSegueWithIdentifier:@"showAboutSegue" sender:sender];
            
        }else{
            [self performSegueWithIdentifier:@"showAboutSegue2" sender:sender];
            //iphone 3.5 inch screen
        }
    }else{
        //[ipad]
        [self performSegueWithIdentifier:@"showAboutSegue2" sender:sender];
    }
    
    NSLog(@"go to About");
    if ([[ UIScreen mainScreen ] bounds ].size.height > 568 ) {
    }else{
    }
    
}

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
    
    stringHasil = [NSString stringWithFormat:@"%@",[[self getLocalJson:weton_lengkap] objectForKey:@"deskripsi"]];
    stringTglLahir = [NSString stringWithFormat:@"%@ %@ %@",day,[self bulan:month],year];
    stringWeton = weton_lengkap;
    
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
    
    [textDeskripsi scrollRangeToVisible:NSMakeRange(0, 1)];
}

-(void)textFieldDidBeginEditing:(UITextField *)textField {
    [textFieldDate resignFirstResponder];
    textFieldDate.text = @"";
    viewDatePicker.hidden = NO;
}


-(void)updateTextField:(id)sender
{
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setTimeZone:[NSTimeZone localTimeZone]];
    [dateFormat setDateFormat:@"dd MMMM YYYY"];
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

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if([segue.identifier isEqualToString:@"showResultSegue"]){
        
        ResultViewController *controller = (ResultViewController *)segue.destinationViewController;
        controller.stringHasil = stringHasil;
        controller.stringTglLahir = stringTglLahir;
        controller.stringWeton = stringWeton;

    }else if([segue.identifier isEqualToString:@"showAboutSegue"]){

    }else if([segue.identifier isEqualToString:@"showAboutSegue2"]){
        
    }
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
