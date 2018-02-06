//
//  UpDataInfoObject.h
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
#import <Foundation/Foundation.h>

@interface UpDataInfoObject : NSObject
@property (nonatomic, copy) NSString *dataStr;
@property (nonatomic, strong) NSDictionary *mainData;
@property (nonatomic, strong) NSArray *maritals;
@property (nonatomic, strong) NSArray *socials;
@property (nonatomic, strong) NSArray *accumulations;
@property (nonatomic, strong) NSArray *companyTypes;
@property (nonatomic, strong) NSArray *workYears;
@property (nonatomic, strong) NSArray *incomes;
@property (nonatomic, strong) NSArray *bankFlows;
@property (nonatomic, strong) NSArray *repayments;
@property (nonatomic, strong) NSArray *liveAreas;
@property (nonatomic, strong) NSArray *loanPurposes;
@property (nonatomic, strong) NSArray *houseTypeList;
@property (nonatomic, strong) NSArray *repaymentTypeList;
+ (instancetype)sharedInstanceTool;
@end
