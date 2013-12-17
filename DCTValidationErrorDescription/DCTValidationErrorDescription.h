//
//  DCTValidationErrorDescription.h
//  DCTValidationErrorDescription
//
//  Created by Daniel Tull on 04.02.2013.
//  Copyright (c) 2013 Daniel Tull. All rights reserved.
//

@import CoreData;

@interface DCTValidationErrorDescription : NSObject
+ (NSString *)detailedDescriptionFromValidationError:(NSError *)error;
@end
