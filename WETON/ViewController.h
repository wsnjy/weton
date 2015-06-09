//
//  ViewController.h
//  WETON
//
//  Created by Wisnu Sanjaya on 6/6/15.
//  Copyright (c) 2015 wsnjy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Data_weton.h"

@interface ViewController : UIViewController{
    NSManagedObjectContext *managedObjectContext;
}

@property (nonatomic, retain) NSManagedObjectContext *managedObjectContext;

@end

