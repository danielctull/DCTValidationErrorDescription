//
//  DCTValidationErrorDescription.h
//  DCTValidationErrorDescription
//
//  Created by Daniel Tull on 04.02.2013.
//  Copyright (c) 2013 Daniel Tull. All rights reserved.
//

@import CoreData;

//! Project version number and string for DCTValidationErrorDescription.
FOUNDATION_EXPORT double DCTValidationErrorDescriptionVersionNumber;
FOUNDATION_EXPORT const unsigned char DCTValidationErrorDescriptionVersionString[];

@interface DCTValidationErrorDescription : NSObject
+ (NSString *)detailedDescriptionFromValidationError:(NSError *)error;
@end
