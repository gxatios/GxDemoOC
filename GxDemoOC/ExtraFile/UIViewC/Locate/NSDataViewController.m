//
//  NSDataViewController.m
//  GXOnlineDemo
//
//  Created by xin gao on 14-2-27.
//  Copyright (c) 2014年 xin gao. All rights reserved.
//

#import "NSDataViewController.h"

@interface NSDataViewController ()

@end

@implementation NSDataViewController

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

- (NSString *)nsdataToNSString:(NSData *)_data
{
    NSString *aString = [[NSString alloc] initWithData:_data encoding:NSUTF8StringEncoding];
    return aString;
}


- (NSData *)nsstringToNSData:(NSString *)_aString
{
    NSString *aString = _aString;
    NSData *aData = [aString dataUsingEncoding:NSUTF8StringEncoding];
    return aData;
}

- (NSData *)byteToNSData:(Byte *)_byte
{
    Byte byte[] = {0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23};
    NSData *aData = [[NSData alloc] initWithBytes:byte length:24];
    NSLog(@"data -- %@",aData);
    return aData;
}

- (Byte *)nsdataToByte:(NSData *)_aData
{
    NSString *aString = @"1234567890";
    NSData *aData = [aString dataUsingEncoding:NSUTF8StringEncoding];
    Byte *aByte = (Byte *)[aData bytes];

    return aByte;

}

- (NSString *)byteToHexStr:(NSData *)_aData
{
    // byte数组  16机制数字
    Byte *bytes = (Byte *)[_aData bytes];
    NSString *hexStr = @"";

    return hexStr;
}

- (NSData *)hexStrToNSData:(NSString *)_aString
{
    ///// 将16进制数据转化成Byte 数组
//    NSString *hexStr = _aString;
    NSString *hexString = @"3e435fab9c34891f"; //16进制字符串
    int j=0;
    Byte bytes[128];
    for (int i =0; i<[hexString length]; i++) {
        int int_ch;
        unichar hex_char1 = [hexString characterAtIndex:i]; ////两位16进制数中的第一位(高位*16)
        int int_ch1;
        if(hex_char1 >= '0' && hex_char1 <='9')
            int_ch1 = (hex_char1-48)*16;   //// 0 的Ascll - 48
        else if(hex_char1 >= 'A' && hex_char1 <='F')
            int_ch1 = (hex_char1-55)*16; //// A 的Ascll - 65
        else
            int_ch1 = (hex_char1-87)*16; //// a 的Ascll - 97
        i++;
        
        unichar hex_char2 = [hexString characterAtIndex:i]; ///两位16进制数中的第二位(低位)
        int int_ch2;
        if(hex_char2 >= '0' && hex_char2 <='9')
            int_ch2 = (hex_char2-48); //// 0 的Ascll - 48
        else if(hex_char1 >= 'A' && hex_char1 <='F')
            int_ch2 = hex_char2-55; //// A 的Ascll - 65
        else
            int_ch2 = hex_char2-87; //// a 的Ascll - 97
        
        int_ch = int_ch1+int_ch2;
        NSLog(@"int_ch=%d",int_ch);
        bytes[j] = int_ch;  ///将转化后的数放入Byte数组里
        j++;
    }
    NSData *newData = [[NSData alloc] initWithBytes:bytes length:128];
    return newData;
}

- (NSData *)uiimageToNSData:(UIImage *)_image
{
    NSString *path = [[NSBundle mainBundle] bundlePath];
    NSString *name = [NSString stringWithFormat:@"ceshi.png"];
    NSString *finishPath = [path stringByAppendingPathComponent:name];
    NSData *imageData = [NSData dataWithContentsOfFile:finishPath];
    
    return imageData;
}

- (UIImage *)nsdataToUIImage:(NSData *)_aData
{
    UIImage *aImage = [UIImage imageWithData:_aData];
    return aImage;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
