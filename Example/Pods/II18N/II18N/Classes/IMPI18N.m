// ==============================================================================
//
// 国际化相关处理文件
//
// ==============================================================================

#import "IMPI18N.h"

//Bundle
static NSBundle *bundle = nil;

@implementation IMPI18N

//Bundle
+ (NSBundle *)bundle {
    return bundle;
}

//初始化语言
+(void)initUserLanguage {
    NSString *string;
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"appLanguage"] == nil) {
        //获取系统当前语言版本
        NSArray *languages = [NSLocale preferredLanguages];
        NSString *language = [languages objectAtIndex:0];
        if ([language hasPrefix:@"en"]) {
            //英文
            string = @"en";
        }
        else if ([language hasPrefix:@"zh"]) {
            // 简体中文
            string = @"zh-Hans";
        }
        else {
            //其他语言不支持，默认为简体中文
            string = @"zh-Hans";
        }
        [[NSUserDefaults standardUserDefaults] setObject:string forKey:@"userLanguage"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
    else {
        string = [self userLanguage];
        if(string.length == 0) {
            //获取系统当前语言版本
            NSArray *languages = [NSLocale preferredLanguages];
            NSString *language = [languages objectAtIndex:0];
            if ([language hasPrefix:@"en"]) {
                //英文
                string = @"en";
            }
            else if ([language hasPrefix:@"zh"]) {
                // 简体中文
                string = @"zh-Hans";
            }
            else {
                //其他语言不支持，默认为简体中文
                string = @"zh-Hans";
            }
            [[NSUserDefaults standardUserDefaults] setObject:string forKey:@"userLanguage"];
            [[NSUserDefaults standardUserDefaults] synchronize];
        }
    }
    //获取lproj文件路径
    NSString *path = [[NSBundle mainBundle] pathForResource:string ofType:@"lproj"];
    if (path.length == 0) {
        //生成bundle
        bundle = [NSBundle mainBundle];
    }
    else {
        //生成bundle
        bundle = [NSBundle bundleWithPath:path];
    }
}

//获取应用当前语言
+(NSString *)userLanguage {
    return [[NSUserDefaults standardUserDefaults] objectForKey:@"userLanguage"];
}

//设置当前语言
+(void)setUserlanguage:(NSString *)language {
    NSString *path = [[NSBundle mainBundle] pathForResource:language ofType:@"lproj" ];
    bundle = [NSBundle bundleWithPath:path];
    [[NSUserDefaults standardUserDefaults] setObject:language forKey:@"userLanguage"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

/// 是否是英文语言
+(BOOL)isENLanguage {
    NSString *languageStr = [[NSUserDefaults standardUserDefaults] objectForKey:@"userLanguage"];
    if ([languageStr isEqualToString:@"en"]) {
        return true;
    }
    return false;
}

//获取当前Localde
+ (NSLocale *)currentLocal {
     return [[NSLocale alloc] initWithLocaleIdentifier:[self userLanguage]];
}

//是否在国内
+ (BOOL)isChina {
    if ([[self userLanguage] rangeOfString:@"zh"].location != NSNotFound) {
        return YES;
    }
    else {
        return NO;
    }
}

//读取国际化资源文件方法
+(NSString *)localizedStringForKey:(NSString *)key value:(NSString *)value table:(NSString *)tbl {
    return [[self bundle] localizedStringForKey:key value:value table:tbl];
}

//本地化时间格式
+ (NSString *)localizedDateString:(NSDate *)date dateStyle:(NSDateFormatterStyle)dateStyle timeStyle:(NSDateFormatterStyle)timeStyle {
    NSDateFormatter *dateformate = [[NSDateFormatter alloc]init];
    dateformate.locale = [self currentLocal];
    dateformate.dateStyle = dateStyle;
    dateformate.timeStyle = timeStyle;
    return [dateformate stringFromDate:date];
}

@end
