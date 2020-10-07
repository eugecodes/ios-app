#import <Foundation/Foundation.h>
#import <float.h>

#define LEV_INF_DISTANCE FLT_MAX

@interface NSString(Levenshtein)

- (float) asciiLevenshteinDistanceWithString: (NSString *)stringB;
- (float) asciiLevenshteinDistanceWithString: (NSString *)stringB skippingCharacterSet: (NSCharacterSet *)charset;

@end