//
//  AgoraAudioOCIBLL.h
//  impcloud_dev
//
//  Created by 许阳 on 2019/4/30.
//  Copyright © 2019 Elliot. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol AgoraAudioIBLL <BHServiceProtocol>

/// [根据命令-解析-展示音视频入口]
///
/// - Parameters:
///   - uri: scheme
- (void)analyzeCMDAndJumpVw:(NSString *)uri;

/// [根据选择的人的结果展示音视频入口]
///
/// - Parameter arr: 人信息数组
- (void)createChannel:(NSArray *) arr isVideo:(BOOL)video bizID:(NSString *)bizID;

/// 有人拒绝或者离开频道指令处理
///
/// - Parameters:
///   - uid: agora_uid
///   - reason: .leave & .refuse
-(void)leaveAndRejectJoinChannel:(NSUInteger)uid Reason:(NSInteger)reason;

@end

NS_ASSUME_NONNULL_END
