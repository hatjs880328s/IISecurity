//
//  SearchSelectDelegate.h
//  impcloud_dev
//
//  Created by 衣凡 on 2019/5/23.
//  Copyright © 2019 Elliot. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol SearchSelectDelegate <NSObject>
@optional
- (void)getSelectPeople:(NSMutableArray *)peopleArray groupArray:(NSMutableArray *)groupArray chatArray:(NSMutableArray *)chatArray;
- (void)getCid:(NSString *)str;
- (void)sharePeople:(NSString *)inspur_id name:(NSString *)name;
- (void)shareForUser:(NSString *)uid;

@end
