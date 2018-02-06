//
//  UserApplyInfoObject.h
//  GxDemoOC
//
//  Created by GaoX on 2017/10/3.
//  Copyright © 2017年 gx. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserApplyInfoObject : NSObject

@property (nonatomic, strong) NSDictionary *mainData;
@property (nonatomic, copy) NSString *dataStr; // 是否有数据
// 个人信息
@property (nonatomic, copy) NSString *realityName;
@property (nonatomic, copy) NSString *idNumber;
@property (nonatomic, copy) NSString *maritalId; // 婚姻状况
@property (nonatomic, copy) NSString *socialSecurityId; // 社保
@property (nonatomic, copy) NSString *accumulationFundId; // 公积金
@property (nonatomic, copy) NSString *liveAreasId;
@property (nonatomic, copy) NSString *liveAddress;
@property (nonatomic, copy) NSString *contactMobile;

// 工作信息
@property (nonatomic, copy) NSString *workType;


@property (nonatomic, copy) NSString *companyTypeId;
@property (nonatomic, copy) NSString *companyName;
// 公司员工
@property (nonatomic, copy) NSString *workYearId;
@property (nonatomic, copy) NSString *monthIncomeId;
// 企业员工
@property (nonatomic, copy) NSString *photoType;

@property (nonatomic, copy) NSString *shareholderNum;
@property (nonatomic, copy) NSString *bankFlowYearId;
@property (nonatomic, copy) NSString *businessLicense;
@property (nonatomic, copy) NSString *taxRegistration;
@property (nonatomic, copy) NSString *organizationCode;
@property (nonatomic, copy) NSString *threeCertificatesToOne;

// 房产信息
@property (nonatomic, copy) NSString *propertyCertificate;
@property (nonatomic, copy) NSString *propertyNatureId;
@property (nonatomic, copy) NSString *propertySurplus;
// 负债信息
@property (nonatomic, copy) NSString *totalLoanAmount;
@property (nonatomic, copy) NSString *totalLendingInstitutionsNum;
@property (nonatomic, copy) NSString *creditCardNum;
@property (nonatomic, copy) NSString *repaymentInfoId;
@property (nonatomic, copy) NSString *isCreditCardMini;
@property (nonatomic, copy) NSString *isCreditCardRepayment;

// 贷款申请信息
@property (nonatomic, copy) NSString *productId;
@property (nonatomic, copy) NSString *loanPurposeId;
@property (nonatomic, copy) NSString *loanMoney;
@property (nonatomic, copy) NSString *descriptionStr;


+ (instancetype)sharedInstanceTool;

@end
