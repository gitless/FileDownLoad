//
//  FileDownManger.h
//  DownloadFile
//
//  Created by v on 16/4/13.
//  Copyright © 2016年 v. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FileDownManger : NSObject
-(void)downLoadWithUrlString:(NSString *)urlString;
@property (nonatomic,copy)void(^haveReceived)(float);
@end
