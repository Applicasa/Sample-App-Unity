//
//  LiResponse.h
//  Applicasa
//
//  Created by Applicasa
//  Copyright (c) 2012 Applicasa All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LiResponse : NSObject{
    void *statement;
}

@property NSInteger responseType;
@property (nonatomic,strong) NSString *responseMessage;
@property (nonatomic,strong) NSDictionary *responseData;
@property (nonatomic,strong) NSDate *responseTime;

+ (LiResponse *) responseWithDictionary:(NSDictionary *)dictionary;
+ (LiResponse *) responseWithResponseType:(NSInteger)_responseType ResponseMessage:(NSString *)_responseMessage ResponseData:(NSDictionary *)_responseData;

- (void) setStatement:(void *)stmt;
- (void *) getStatement;

- (void) logResponseWithRequest:(NSString *)request;


@end
