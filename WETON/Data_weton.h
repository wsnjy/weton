//
//  Data_weton.h
//  WETON
//
//  Created by Wisnu Sanjaya on 6/9/15.
//  Copyright (c) 2015 wsnjy. All rights reserved.
//

#import <CoreData/CoreData.h>

@interface Data_weton : NSManagedObject

@property (nonatomic, retain) NSString *nama_weton;
@property (nonatomic, retain) NSString *deskripsi_weton;
@property (nonatomic, retain) NSNumber * id_data;


@end
