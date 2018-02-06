//
//  LocateSaveViewController.m
//  GXOnlineDemo
//
//  Created by gaoxin on 14-3-18.
//  Copyright (c) 2014年 xin gao. All rights reserved.
//

#import "LocateSaveViewController.h"

@interface LocateSaveViewController ()
{
    NSString *_quotesLocateStr;
//    NSMutableArray *_quotesLocateArray;
}
@property (nonatomic,retain) NSMutableArray *quotesLocateArray;
@end

@implementation LocateSaveViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)getLocate
{
    //  获取本地的plist文件 ，读取
    NSString *plistCatPath = [[NSBundle mainBundle] pathForResource:@"quotes" ofType:@"plist"];
    self.quotesLocateArray = [[NSMutableArray arrayWithContentsOfFile:plistCatPath] copy];
    
    NSString *selectedCategory = @"classic";
    // 2.2 - filter array by category using predicate
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"category == %@", selectedCategory];
    NSArray *filteredArray = [self.quotesLocateArray filteredArrayUsingPredicate:predicate];
    NSLog(@"%@",filteredArray);
}

//a 本地路径拼接
+ (NSString *)filePath:(NSString*)filename
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains( NSDocumentDirectory,NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *documentLibraryFolderPath = [documentsDirectory stringByAppendingPathComponent:filename];
    return documentLibraryFolderPath;
}

+ (BOOL)fileExitWith:(NSString *)filename
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if ([fileManager fileExistsAtPath:[self filePath:filename]]) {
        return YES;
    }else{
        return NO;
    }
}
+ (BOOL)arrayExistWith:(NSString *)fileName
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    return [fileManager fileExistsAtPath:fileName];
}





- (NSString *)pathForHome
{
    //获取根目录
    NSString *homePath = NSHomeDirectory();
    NSLog(@"Home目录：%@",homePath);
    return homePath;
}

- (NSString *)pathForDocument
{
    //获取Documents文件夹目录,第一个参数是说明获取Doucments文件夹目录，第二个参数说明是在当前应用沙盒中获取，所有应用沙盒目录组成一个数组结构的数据存放
    NSArray *docPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES);
    NSString *documentsPath = [docPath objectAtIndex:0];
    NSLog(@"Documents目录：%@",documentsPath);
    return documentsPath;
}

- (NSString *)pathForCache
{
    //获取Cache目录
    NSArray *cacPath = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString *cachePath = [cacPath objectAtIndex:0];
    NSLog(@"Cache目录：%@",cachePath);
    return cachePath;
}

- (NSString *)pathForLibrary
{
    //Library目录
    NSArray *libsPath = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES);
    NSString *libPath = [libsPath objectAtIndex:0];
    NSLog(@"Library目录：%@",libPath);
    return libPath;
}

- (NSString *)pathForTemp
{
    //temp目录
    NSString *tempPath = NSTemporaryDirectory();
    NSLog(@"temp目录：%@",tempPath);
    return tempPath;
}

- (void)docuWriteTo
{
    //写入文件   xml格式的plist文件，数据格式保存了内容。
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *docDir = [paths objectAtIndex:0];
    if (!docDir) {
        NSLog(@"Documents 目录未找到");
    }
    NSArray *array = [[NSArray alloc] initWithObjects:@"内容",@"content",nil];
    NSString *filePath = [docDir stringByAppendingPathComponent:@"testFile.txt"];
    [array writeToFile:filePath atomically:YES];
}

- (void)docuReadTo
{
    // 读取文件
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *docDir = [paths objectAtIndex:0];
    NSString *filePath = [docDir stringByAppendingPathComponent:@"testFile.txt"];
    NSArray *array = [[NSArray alloc]initWithContentsOfFile:filePath];
    NSLog(@"%@", array);
}

+(NSString *)pathInDocumentDirectory:(NSString *)fileName{
    //获取沙盒中的文档目录
    NSArray *documentDirectories = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    
    
    NSString *documentDirectory=[documentDirectories objectAtIndex:0];
    
    return [documentDirectory stringByAppendingPathComponent:fileName];
}



+(NSString *)pathInCacheDirectory:(NSString *)fileName{
    //获取沙盒中缓存文件目录
    NSString *cacheDirectory = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)[0];
    
    
    //将传入的文件名加在目录路径后面并返回
    return [cacheDirectory stringByAppendingPathComponent:fileName];
}

/*
 http://www.uml.org.cn/mobiledev/201209211.asp
 IOS学习之IOS沙盒(sandbox)机制和文件操作之NSFileManager(三)
 我们看看NSFileManager如何使用。包括创建文件，目录，删除，遍历目录等。
 
 */

- (NSString *)fileBuildInDocu
{
//    1、在Documents里创建目录
//    创建一个叫test的目录,先找到Documents的目录，
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSLog(@"documentsDirectory%@",documentsDirectory);
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString *testDirectory = [documentsDirectory stringByAppendingPathComponent:@"test"];
    // 创建目录
    [fileManager createDirectoryAtPath:testDirectory withIntermediateDirectories:YES attributes:nil error:nil];
    return testDirectory;
}

- (void)docuBuildInDocu
{
//    2、在test目录下创建文件
//    
//    创建文件怎么办呢？接着上面的代码 testPath 要用stringByAppendingPathComponent拼接上你要生成的文件名，比如test00.txt。这样才能在test下写入文件。
//    
//    testDirectory是上面代码生成的路径哦，不要忘了。我往test文件夹里写入三个文件，test00.txt ,test22.txt,text.33.txt。内容都是写入内容，write String。
//    
//    实现代码如下：
    NSString *testDirectory = [self fileBuildInDocu];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    NSString *testPath = [testDirectory stringByAppendingPathComponent:@"test00.txt"];
    NSString *testPath2 = [testDirectory stringByAppendingPathComponent:@"test22.txt"];
    NSString *testPath3 = [testDirectory stringByAppendingPathComponent:@"test33.txt"];
    
    NSString *string = @"写入内容，write String";
    [fileManager createFileAtPath:testPath contents:[string  dataUsingEncoding:NSUTF8StringEncoding] attributes:nil];
    [fileManager createFileAtPath:testPath2 contents:[string  dataUsingEncoding:NSUTF8StringEncoding] attributes:nil];
    [fileManager createFileAtPath:testPath3 contents:[string  dataUsingEncoding:NSUTF8StringEncoding] attributes:nil];
}
- (void)getListInDocu
{
//    3、获取目录列里所有文件名
//    两种方法获取：subpathsOfDirectoryAtPath 和 subpathsAtPath
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSLog(@"documentsDirectory%@",documentsDirectory);
    
    NSFileManager *fileManage = [NSFileManager defaultManager];
    NSString *myDirectory = [documentsDirectory stringByAppendingPathComponent:@"test"];
    
    NSArray *file = [fileManage subpathsOfDirectoryAtPath: myDirectory error:nil];
    NSLog(@"%@",file);
    NSArray *files = [fileManage subpathsAtPath: myDirectory ];
    NSLog(@"%@",files);
}

- (void)operInDocu
{
//    4、fileManager使用操作当前目录
    
    //创建文件管理器
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    //更改到待操作的目录下
    [fileManager changeCurrentDirectoryPath:[documentsDirectory stringByExpandingTildeInPath]];
    //创建文件fileName文件名称，contents文件的内容，如果开始没有内容可以设置为nil，attributes文件的属性，初始为nil
    NSString * fileName = @"testFileNSFileManager.txt";
    NSArray *array = [[NSArray alloc] initWithObjects:@"hello world",@"hello world1", @"hello world2",nil];
    [fileManager createFileAtPath:fileName contents:array attributes:nil];
    
    //    5、删除文件
    //    接上面的代码，remove就ok了。
    [fileManager removeItemAtPath:fileName error:nil];

}

- (void)dataMultiOperInDocu
{
//    6、混合数据的读写
//    用NSMutableData创建混合数据，然后写到文件里。并按数据的类型把数据读出来
//    6.1写入数据：
    
    NSString *fileName = @"testFileNSFileManager.txt";
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    //获取文件路径
    NSString *path = [documentsDirectory stringByAppendingPathComponent:fileName];
    //待写入的数据
    NSString *temp = @"nihao 世界";
    int dataInt = 1234;
    float dataFloat = 3.14f;
    //创建数据缓冲
    NSMutableData *writer = [[NSMutableData alloc] init];
    //将字符串添加到缓冲中
    [writer appendData:[temp dataUsingEncoding:NSUTF8StringEncoding]];
    //将其他数据添加到缓冲中
    [writer appendBytes:&dataInt length:sizeof(dataInt)];
    [writer appendBytes:&dataFloat length:sizeof(dataFloat)];
    //将缓冲的数据写入到文件中
    [writer writeToFile:path atomically:YES];
    
//    6.2读取刚才写入的数据：
    //读取数据：
    int intData;
    float floatData = 0.0;
    NSString *stringData;
    
    NSData *reader = [NSData dataWithContentsOfFile:path];
    stringData = [[NSString alloc] initWithData:[reader subdataWithRange:NSMakeRange(0, [temp length])]
                                       encoding:NSUTF8StringEncoding];
    [reader getBytes:&intData range:NSMakeRange([temp length], sizeof(intData))];
    [reader getBytes:&floatData range:NSMakeRange([temp length] + sizeof(intData), sizeof(floatData))];
    NSLog(@"stringData:%@ intData:%d floatData:%f", stringData, intData, floatData);
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/



@end
