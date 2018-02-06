//
//  UpDataInfoObject.m
//  GxDemoOC
//
//  Created by zhxGx on 2017/9/4.
//  Copyright © 2017年 gx. All rights reserved.
//
/*
 婚姻选项	maritals	JSONArray	婚姻选项基础数据
 社保选项	socials	JSONArray	社保选项基础数据
 公积金选项	accumulations	JSONArray	公积金选项基础数据
 单位性质选项	companyTypes	JSONArray	单位性质选项基础数据
 现单位上班年限选项	workYears	JSONArray	现单位上班年限选项基础数据
 月薪选项	incomes	JSONArray	月薪选项基础数据
 公司年流水选项	bankFlows	JSONArray	公司年流水选项基础数据
 还款信用记录选项	repayments	JSONArray	还款信用记录选项基础数据
 居住地址	liveAreas	JSONArray	居住地址基础数据
 贷款目的选项	loanPurposes	JSONArray	贷款目的选项基础数据
 */
#import "UpDataInfoObject.h"

@implementation UpDataInfoObject

static UpDataInfoObject *shareSingleton = nil;

+ (instancetype)allocWithZone:(struct _NSZone *)zone{
    @synchronized(self) {
        if (shareSingleton == nil) {
            shareSingleton = [super allocWithZone:zone];
        }
    }
    return shareSingleton;
}
+ (instancetype)sharedInstanceTool{
    @synchronized(self){
        if(shareSingleton == nil){
            shareSingleton = [[self alloc] init];
        }
    }
    return shareSingleton;
}
-(id)copyWithZone:(struct _NSZone *)zone{
    return shareSingleton;
}
-(void)setMainData:(NSDictionary *)mainData{
    _mainData = mainData;
    self.dataStr = @"1";
    self.maritals = [NSArray arrayWithArray:mainData[@"maritals"]];
    self.socials = [NSArray arrayWithArray:mainData[@"socials"]];
    self.accumulations = [NSArray arrayWithArray:mainData[@"accumulations"]];
    self.companyTypes = [NSArray arrayWithArray:mainData[@"companyTypes"]];
    self.workYears = [NSArray arrayWithArray:mainData[@"workYears"]];
    self.incomes = [NSArray arrayWithArray:mainData[@"incomes"]];
    self.bankFlows = [NSArray arrayWithArray:mainData[@"bankFlows"]];
    self.repayments = [NSArray arrayWithArray:mainData[@"repayments"]];
    self.liveAreas = [NSArray arrayWithArray:mainData[@"liveAreas"]];
    self.loanPurposes = [NSArray arrayWithArray:mainData[@"loanPurposes"]];
    self.houseTypeList = [NSArray arrayWithArray:mainData[@"houseTypeList"]];
    self.repaymentTypeList = [NSArray arrayWithArray:mainData[@"repaymentTypeList"]];
}

@end
