//
//  UserApplyInfoObject.m
//  GxDemoOC
//
//  Created by GaoX on 2017/10/3.
//  Copyright © 2017年 gx. All rights reserved.
//

#import "UserApplyInfoObject.h"

@implementation UserApplyInfoObject

static UserApplyInfoObject *shareSingleton = nil;

+ (instancetype)allocWithZone:(struct _NSZone *)zone
{
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
    self.realityName = [NSString stringWithFormat:@"%@",mainData[@"realityName"]];
    self.idNumber = [NSString stringWithFormat:@"%@",mainData[@"idNumber"]];
    self.maritalId = [NSString stringWithFormat:@"%@",mainData[@"maritalId"]];
    self.socialSecurityId = [NSString stringWithFormat:@"%@",mainData[@"socialSecurityId"]];
    self.accumulationFundId = [NSString stringWithFormat:@"%@",mainData[@"accumulationFundId"]];
    self.liveAreasId = [NSString stringWithFormat:@"%@",mainData[@"liveAreasId"]];
    self.liveAddress = [NSString stringWithFormat:@"%@",mainData[@"liveAddress"]];
    self.contactMobile = [NSString stringWithFormat:@"%@",mainData[@"contactMobile"]];
    
    self.workType = [NSString stringWithFormat:@"%@",mainData[@"workType"]];
    self.companyTypeId = [NSString stringWithFormat:@"%@",mainData[@"companyTypeId"]];
    self.companyName = [NSString stringWithFormat:@"%@",mainData[@"companyName"]];
    
    self.workYearId = [NSString stringWithFormat:@"%@",mainData[@"workYearId"]];
    self.monthIncomeId = [NSString stringWithFormat:@"%@",mainData[@"monthIncomeId"]];
    self.shareholderNum = [NSString stringWithFormat:@"%@",mainData[@"shareholderNum"]];
    self.bankFlowYearId = [NSString stringWithFormat:@"%@",mainData[@"bankFlowYearId"]];
    self.businessLicense = [NSString stringWithFormat:@"%@",mainData[@"businessLicense"]];

    self.photoType = [NSString stringWithFormat:@"%@",mainData[@"photoType"]];
    self.taxRegistration = [NSString stringWithFormat:@"%@",mainData[@"taxRegistration"]];
    self.organizationCode = [NSString stringWithFormat:@"%@",mainData[@"organizationCode"]];
    self.threeCertificatesToOne = [NSString stringWithFormat:@"%@",mainData[@"threeCertificatesToOne"]];
    self.propertyCertificate = [NSString stringWithFormat:@"%@",mainData[@"propertyCertificate"]];
    self.propertyNatureId = [NSString stringWithFormat:@"%@",mainData[@"propertyNatureId"]];
    self.propertySurplus = [NSString stringWithFormat:@"%@",mainData[@"propertySurplus"]];
    self.totalLoanAmount = [NSString stringWithFormat:@"%@",mainData[@"totalLoanAmount"]];
    self.totalLendingInstitutionsNum = [NSString stringWithFormat:@"%@",mainData[@"totalLendingInstitutionsNum"]];
    self.creditCardNum = [NSString stringWithFormat:@"%@",mainData[@"creditCardNum"]];
    self.repaymentInfoId = [NSString stringWithFormat:@"%@",mainData[@"repaymentInfoId"]];
    self.isCreditCardMini = [NSString stringWithFormat:@"%@",mainData[@"isCreditCardMini"]];
    self.isCreditCardRepayment = [NSString stringWithFormat:@"%@",mainData[@"isCreditCardRepayment"]];
    self.productId = [NSString stringWithFormat:@"%@",mainData[@"productId"]];
    self.loanPurposeId = [NSString stringWithFormat:@"%@",mainData[@"loanPurposeId"]];
    self.loanMoney = [NSString stringWithFormat:@"%@",mainData[@"loanMoney"]];
    self.descriptionStr = [NSString stringWithFormat:@"%@",mainData[@"description"]];

    if ([self.realityName isEqualToString:@"(null)"] || [self.realityName isEqualToString:@"<null>"]) {
        self.realityName = @"";
    }
    if ([self.idNumber isEqualToString:@"(null)"]|| [self.idNumber isEqualToString:@"<null>"]) {
        self.idNumber = @"";
    }
    if ([self.maritalId isEqualToString:@"(null)"]||[self.maritalId isEqualToString:@"<null>"]) {
        self.maritalId = @"";
    }
    if ([self.socialSecurityId isEqualToString:@"(null)"]||[self.socialSecurityId isEqualToString:@"<null>"]) {
        self.socialSecurityId = @"";
    }
    if ([self.accumulationFundId isEqualToString:@"(null)"]||[self.accumulationFundId isEqualToString:@"<null>"]) {
        self.accumulationFundId = @"";
    }
    if ([self.liveAreasId isEqualToString:@"(null)"]|| [self.liveAreasId isEqualToString:@"<null>"]) {
        self.liveAreasId = @"";
    }
    if ([self.liveAddress isEqualToString:@"(null)"]|| [self.liveAddress isEqualToString:@"<null>"]) {
        self.liveAddress = @"";
    }
    if ([self.contactMobile isEqualToString:@"(null)"]|| [self.contactMobile isEqualToString:@"<null>"]) {
        self.contactMobile = @"";
    }
    if ([self.workType isEqualToString:@"(null)"]|| [self.workType isEqualToString:@"<null>"]) {
        self.workType = @"";
    }
    if ([self.companyTypeId isEqualToString:@"(null)"]|| [self.companyTypeId isEqualToString:@"<null>"]) {
        self.companyTypeId = @"";
    }
    if ([self.companyName isEqualToString:@"(null)"]|| [self.companyName isEqualToString:@"<null>"]) {
        self.companyName = @"";
    }
    if ([self.workYearId isEqualToString:@"(null)"]|| [self.workYearId isEqualToString:@"<null>"]) {
        self.workYearId = @"";
    }
    if ([self.monthIncomeId isEqualToString:@"(null)"]|| [self.monthIncomeId isEqualToString:@"<null>"]) {
        self.monthIncomeId = @"";
    }
    if ([self.shareholderNum isEqualToString:@"(null)"]|| [self.shareholderNum isEqualToString:@"<null>"]) {
        self.shareholderNum = @"";
    }
    if ([self.bankFlowYearId isEqualToString:@"(null)"]|| [self.bankFlowYearId isEqualToString:@"<null>"]) {
        self.bankFlowYearId = @"";
    }
    if ([self.businessLicense isEqualToString:@"(null)"]|| [self.businessLicense isEqualToString:@"<null>"]) {
        self.businessLicense = @"";
    }
    if ([self.taxRegistration isEqualToString:@"(null)"]|| [self.taxRegistration isEqualToString:@"<null>"]) {
        self.taxRegistration = @"";
    }
    if ([self.organizationCode isEqualToString:@"(null)"]|| [self.organizationCode isEqualToString:@"<null>"]) {
        self.organizationCode = @"";
    }
    if ([self.threeCertificatesToOne isEqualToString:@"(null)"]|| [self.threeCertificatesToOne isEqualToString:@"<null>"]) {
        self.threeCertificatesToOne = @"";
    }
    if ([self.propertyCertificate isEqualToString:@"(null)"]|| [self.propertyCertificate isEqualToString:@"<null>"]) {
        self.propertyCertificate = @"";
    }
    if ([self.propertyNatureId isEqualToString:@"(null)"]|| [self.propertyNatureId isEqualToString:@"<null>"]) {
        self.propertyNatureId = @"";
    }if ([self.propertySurplus isEqualToString:@"(null)"]|| [self.propertySurplus isEqualToString:@"<null>"]) {
        self.propertySurplus = @"";
    }if ([self.totalLoanAmount isEqualToString:@"(null)"]|| [self.totalLoanAmount isEqualToString:@"<null>"]) {
        self.totalLoanAmount = @"";
    }
    if ([self.totalLendingInstitutionsNum isEqualToString:@"(null)"]|| [self.totalLendingInstitutionsNum isEqualToString:@"<null>"]) {
        self.totalLendingInstitutionsNum = @"";
    }
    if ([self.creditCardNum isEqualToString:@"(null)"]|| [self.creditCardNum isEqualToString:@"<null>"]) {
        self.creditCardNum = @"";
    }
    if ([self.repaymentInfoId isEqualToString:@"(null)"]|| [self.repaymentInfoId isEqualToString:@"<null>"]) {
        self.repaymentInfoId = @"";
    }
    if ([self.isCreditCardMini isEqualToString:@"(null)"]|| [self.isCreditCardMini isEqualToString:@"<null>"]) {
        self.isCreditCardMini = @"";
    }if ([self.isCreditCardRepayment isEqualToString:@"(null)"]|| [self.isCreditCardRepayment isEqualToString:@"<null>"]) {
        self.isCreditCardRepayment = @"";
    }
    if ([self.productId isEqualToString:@"(null)"]|| [self.productId isEqualToString:@"<null>"]) {
        self.productId = @"";
    }
    if ([self.loanPurposeId isEqualToString:@"(null)"]|| [self.loanPurposeId isEqualToString:@"<null>"]) {
        self.loanPurposeId = @"";
    }
    if ([self.loanMoney isEqualToString:@"(null)"]|| [self.loanMoney isEqualToString:@"<null>"]) {
        self.loanMoney = @"";
    }
    if ([self.descriptionStr isEqualToString:@"(null)"]|| [self.descriptionStr isEqualToString:@"<null>"]) {
        self.descriptionStr = @"";
    }
}

@end
