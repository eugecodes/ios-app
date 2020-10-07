#import "ProcessorString.h"

int smallestOf(int a, int b, int c);

@implementation NSString (Levenshtein)

- (float) asciiLevenshteinDistanceWithString: (NSString *)stringB
{
    return [self asciiLevenshteinDistanceWithString:stringB
                               skippingCharacterSet:nil];
}


- (float) asciiLevenshteinDistanceWithString: (NSString *)stringB skippingCharacterSet: (NSCharacterSet *)charset
{
    if (!stringB)
        return LEV_INF_DISTANCE;
    
    
    NSString *stringA;
    if (charset) {
        stringA = [[self componentsSeparatedByCharactersInSet:charset] componentsJoinedByString:@""];
        stringB = [[stringB componentsSeparatedByCharactersInSet:charset] componentsJoinedByString:@""];
    } else {
        stringA = self;
    }
    
    NSData *dataA = [stringA dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    NSData *dataB = [stringB dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    const char *cstringA = [dataA bytes];
    const char *cstringB = [dataB bytes];
    int k, i, j, cost, * d, distance;
    
    int n = [dataA length];
    int m = [dataB length];
    
    if( n++ != 0 && m++ != 0 ) {
        
        d = malloc( sizeof(int) * m * n );
        
        for( k = 0; k < n; k++)
            d[k] = k;
        
        for( k = 0; k < m; k++)
            d[ k * n ] = k;
        
        for( i = 1; i < n; i++ )
            for( j = 1; j < m; j++ ) {
                
                if( cstringA[i-1] == cstringB[j-1] )
                    cost = 0;
                else
                    cost = 1;
                
                d[ j * n + i ] = smallestOf( d[ (j - 1) * n + i ] + 1,
                                            d[ j * n + i - 1 ] +  1,
                                            d[ (j - 1) * n + i -1 ] + cost );
            }
        
        distance = d[ n * m - 1 ];
        
        free( d );
        
        return distance;
    }
    return 0.0;
}

int smallestOf(int a, int b, int c)
{
    int min = a;
    if ( b < min )
        min = b;
    
    if( c < min )
        min = c;
    
    return min;
}


@end