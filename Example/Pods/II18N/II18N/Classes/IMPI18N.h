// ==============================================================================
//
// 国际化相关处理文件
//
// ==============================================================================

#import <Foundation/Foundation.h>

//读取资源文件国际化定义key
#define IMPLocalizedString(key) [IMPI18N localizedStringForKey:key value:@"" table:nil]
//读取系统定义国际化key-如APP名称、Tab初始名称等
#define IMPLocalizedStringFromTable(key, tbl) [IMPI18N localizedStringForKey:(key) value:@"" table:(tbl)]

@interface IMPI18N : NSObject

//初始化语言
+(void)initUserLanguage;
//获取应用当前语言
+(NSString *)userLanguage;
//获取应用当前语言是否是英文
+(BOOL)isENLanguage;
//设置当前语言
+(void)setUserlanguage:(NSString *)language;
//获取当前Localde
+ (NSLocale *)currentLocal;
//是否在国内
+ (BOOL)isChina;
//读取国际化资源文件方法
+ (NSString *)localizedStringForKey:(NSString *)key value:(NSString *)value table:(NSString *)tbl;
//本地化时间格式
+ (NSString *)localizedDateString:(NSDate *)date dateStyle:(NSDateFormatterStyle)dateStyle timeStyle:(NSDateFormatterStyle)timeStyle;

@end
