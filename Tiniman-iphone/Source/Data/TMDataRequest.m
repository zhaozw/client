//
//  TMDataRequest.m
//  Tiniman-iphone
//
//  Created by sunny on 12-10-24.
//
//

#import "TMDataRequest.h"

@implementation TMDataRequest
+ (id)parserBlock:(id)dataBlock
{
    
    void (^parseBlock)(NSDictionary*, id) = ^(NSDictionary* dict, id block){
        
        NSUInteger error = [[dict objectForKey:@"error"] unsignedIntValue];
        ((void(^)(NSUInteger,...))dataBlock)(error, @"str");
    };
    return parseBlock;
}

+ (id)NetRequestLoginWithUsername:(NSString *)username
                              uid:(NSString *)uid
                        dataBlock:(void (^)(NSUInteger uid, NSString* str))dataBlock
{
    
    
    TMDataRequest* request = [self request];
    //request.dataBlock = dataBlock;
    
    request.parseBlock = [self parserBlock:dataBlock];

    
    request.parseBlock(@{@"error":@123});
    
    return [[[self alloc] init] autorelease];
}
@end
