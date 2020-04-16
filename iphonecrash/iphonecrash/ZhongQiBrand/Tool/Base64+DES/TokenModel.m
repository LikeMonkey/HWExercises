//
//  TokenModel.m
//  VoteCloud
//
//  Created by ios2 on 2019/8/14.
//  Copyright © 2019 CY. All rights reserved.
//

#import "TokenModel.h"

@implementation TokenModel

-(NSString *)time {
	if (!_time) {
		_time = [NSString spaceTimeLine];
	}
	return _time;
}
-(NSString *)token {
	NSString *method = NullString(self.method)?@"":self.method;
	NSString *time = NullString(self.time)?@"":self.time;
	NSString *auth = NullString(self.auth)?@"":self.auth;
	return [CommonFunc token:auth time:time method:method key:Token_key];
}

-(NSDictionary *)dictionary
{
	NSString *method = NullString(self.method)?@"":self.method;
	NSString *token = NullString(self.token)?@"":self.token;
	NSString *time = NullString(self.time)?@"":self.time;
	NSString *auth = NullString(self.auth)?@"":self.auth;
	return @{
			 @"method":method,
			 @"token":token,
			 @"time":time,
			 @"auth":auth
			 };
}

@end
