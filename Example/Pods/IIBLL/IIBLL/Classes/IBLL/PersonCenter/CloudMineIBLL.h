//
//  CloudMineOCIBLL.h
//  impcloud_dev
//
//  Created by 许阳 on 2019/4/30.
//  Copyright © 2019 Elliot. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol CloudMineIBLL <BHServiceProtocol>

-(UIViewController *)jumpToCloudMineVC;

@optional
-(UITableViewCell *)getCloudMineCellStyle:(UITableViewCellStyle)style ReuseID:(NSString *)reuseID;

@end

NS_ASSUME_NONNULL_END
