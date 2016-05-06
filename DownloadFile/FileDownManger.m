//
//  FileDownManger.m
//  DownloadFile
//
//  Created by v on 16/4/13.
//  Copyright © 2016年 v. All rights reserved.
//

#import "FileDownManger.h"
#import "AppDelegate.h"

typedef void(^downloadTaskProgress)(int64_t totalBytesWritten,int64_t totalBytesExpectedToWrite);

@interface FileDownManger ()<NSURLSessionDelegate,NSURLSessionDownloadDelegate,NSURLSessionTaskDelegate>

@property (nonatomic, strong) NSURLSession *mySession;
@property (nonatomic, strong) NSFileManager *fileManger;
@property (nonatomic, strong) NSString *suggestName;
@property (nonatomic, strong) downloadTaskProgress downloadTaskProgress;
@end

@implementation FileDownManger

- (NSURLSession *)mySession{
    if (!_mySession) {
        NSLog(@"%@",NSHomeDirectory());
        NSURLSessionConfiguration *config = [NSURLSessionConfiguration backgroundSessionConfigurationWithIdentifier:@"down"];
        _mySession = [NSURLSession sessionWithConfiguration:config delegate:self delegateQueue:[NSOperationQueue mainQueue]];
    }
    return _mySession;
}
- (NSFileManager *)fileManger{
    if (!_fileManger) {
        _fileManger = [NSFileManager defaultManager];
    }
    return _fileManger;
}
-(void)downLoadWithUrlString:(NSString *)urlString{
    
    NSURLSessionDownloadTask *task = [self.mySession downloadTaskWithURL:[NSURL URLWithString:urlString]];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(appeShutup:) name:UIApplicationWillTerminateNotification object:nil];
    [task resume];
}
- (void)appeShutup:(NSNotification *)info{
    
    
}
#pragma mark ---- NSURLSessionDownloadDelegate
- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask didResumeAtOffset:(int64_t)fileOffset expectedTotalBytes:(int64_t)expectedTotalBytes{
    
    
    
}
//download已经完成
- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask
didFinishDownloadingToURL:(NSURL *)location{
    
    NSLog(@"%@",session.configuration.identifier);
    NSLog(@"%@",location.absoluteString);
    NSString *toPath = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingFormat:@"/%@",downloadTask.response.suggestedFilename];
    NSURL *toUrl = [NSURL fileURLWithPath:toPath];
    NSError *error;
    if ([self.fileManger fileExistsAtPath:toPath]) {
        NSLog(@"文件已存在");
        return;
    }
    if (![self.fileManger moveItemAtURL:location toURL:toUrl error:&error]) {
        NSLog(@"%@",error.localizedDescription);
    }else{
        NSLog(@"下载保存文件成功");
    }
}
- (void)URLSession:(NSURLSession *)session
      downloadTask:(NSURLSessionDownloadTask *)downloadTask
      didWriteData:(int64_t)bytesWritten
 totalBytesWritten:(int64_t)totalBytesWritten
totalBytesExpectedToWrite:(int64_t)totalBytesExpectedToWrite{
    
    
    if (_haveReceived) {
       
        float p = totalBytesWritten / (double)totalBytesExpectedToWrite;
        NSLog(@"%f",p);

        _haveReceived(p);
    }
   
}
#pragma mark --NSURLSessionTaskDelegate 
/**下载任务已经完成
注意：此方法返回的时候  如果没有对下载的文件进行移动或者删除  文件将会自动删除
 */
- (void)URLSession:(NSURLSession *)session
              task:(NSURLSessionTask *)task
didCompleteWithError:(NSError *)error{
    
    
    [self.mySession invalidateAndCancel];
    self.mySession = nil;
    NSLog(@"finish");
}
-(void)dealloc{


}

@end
