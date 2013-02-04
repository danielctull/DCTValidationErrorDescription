//
//  DCTValidationErrorDescription.m
//  DCTValidationErrorDescription
//
//  Created by Daniel Tull on 04.02.2013.
//  Copyright (c) 2013 Daniel Tull. All rights reserved.
//

#import "DCTValidationErrorDescription.h"

@implementation DCTValidationErrorDescription

+ (NSString *)detailedDescriptionFromValidationError:(NSError *)validationError {

	if (![[validationError domain] isEqualToString:@"NSCocoaErrorDomain"]) return @"";

	NSArray *errors = nil;

	if ([validationError code] == NSValidationMultipleErrorsError)
		errors = [[validationError userInfo] objectForKey:NSDetailedErrorsKey];
	else
		errors = @[validationError];

	if ([errors count] == 0) return @"";

	NSMutableString *messages = [[NSMutableString alloc] initWithFormat:@"Failed with the following reason%@:", (([errors count] > 1)?@"s":@"")];

	for (NSError *error in errors) {

		NSManagedObject *mo = [[error userInfo] objectForKey:@"NSValidationErrorObject"];
		NSString *entityName = [mo isKindOfClass:[NSManagedObject class]] ? [[mo entity] name] : NSStringFromClass([mo class]);
		NSString *attributeName = [[error userInfo] objectForKey:@"NSValidationErrorKey"];

		NSString *message = nil;

		switch ([error code]) {
			case NSManagedObjectValidationError:
				message = @"Generic validation error.";
				break;
			case NSValidationMissingMandatoryPropertyError:
				message = [NSString stringWithFormat:@"The attribute '%@' must not be empty.", attributeName];
				break;
			case NSValidationRelationshipLacksMinimumCountError:
				message = [NSString stringWithFormat:@"The relationship '%@' doesn't have enough entries.", attributeName];
				break;
			case NSValidationRelationshipExceedsMaximumCountError:
				message = [NSString stringWithFormat:@"The relationship '%@' has too many entries.", attributeName];
				break;
			case NSValidationRelationshipDeniedDeleteError:
				message = [NSString stringWithFormat:@"To delete, the relationship '%@' must be empty.", attributeName];
				break;
			case NSValidationNumberTooLargeError:
				message = [NSString stringWithFormat:@"The number of the attribute '%@' is too large.", attributeName];
				break;
			case NSValidationNumberTooSmallError:
				message = [NSString stringWithFormat:@"The number of the attribute '%@' is too small.", attributeName];
				break;
			case NSValidationDateTooLateError:
				message = [NSString stringWithFormat:@"The date of the attribute '%@' is too late.", attributeName];
				break;
			case NSValidationDateTooSoonError:
				message = [NSString stringWithFormat:@"The date of the attribute '%@' is too soon.", attributeName];
				break;
			case NSValidationInvalidDateError:
				message = [NSString stringWithFormat:@"The date of the attribute '%@' is invalid.", attributeName];
				break;
			case NSValidationStringTooLongError:
				message = [NSString stringWithFormat:@"The text of the attribute '%@' is too long.", attributeName];
				break;
			case NSValidationStringTooShortError:
				message = [NSString stringWithFormat:@"The text of the attribute '%@' is too short.", attributeName];
				break;
			case NSValidationStringPatternMatchingError:
				message = [NSString stringWithFormat:@"The text of the attribute '%@' doesn't match the required pattern.", attributeName];
				break;
			default:
				message = [NSString stringWithFormat:@"Unknown error (code %@).", @([error code])];
				break;
		}

		[messages appendFormat:@"\n    %@%@%@%@%@", (entityName?:@""), (attributeName?@".":@""), (attributeName?:@""), (entityName?@": ":@""), message];
	}

	return messages;
}

@end
