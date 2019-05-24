//
//  AgoraAudioOCIBLL.h
//  impcloud_dev
//
//  Created by 许阳 on 2019/4/30.
//  Copyright © 2019 Elliot. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol IIsuprIBLL <BHServiceProtocol>

/// [根据用户ID获取头像地址]
///
/// - Parameter uri: uri
- (NSString *)getUserImgURL:(NSString *)someOneID;

@end

NS_ASSUME_NONNULL_END
