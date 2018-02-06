//
//  QFSaveCacheFile.h
//  报销兔
//
//  Created by aqiang on 2017/12/15.
//  Copyright © 2017年 gx. All rights reserved.
//

#import <Foundation/Foundation.h>

#define FolderName @"QFCache"

@interface QFSaveCacheFile : NSObject

//解归档

+ (id)loadDataList:(NSString *)fileName;

//归档

+ (void)saveDataList:(id)object fileName:(NSString *)fileName;


//删除归档
+ (BOOL)removeFile:(NSString *)fileName;;


@end
