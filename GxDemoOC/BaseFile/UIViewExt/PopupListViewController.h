//
//  PopupListViewController.h
//  GxDemoOC
//
//  Created by zhxGx on 2017/10/18.
//  Copyright © 2017年 gx. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^PopupListVCBlock)(NSInteger indexNum);
@interface PopupListViewController : UITableViewController
@property (nonatomic, strong) NSArray *showDataArray;
@property (nonatomic, copy) PopupListVCBlock popupBlock;
@end
