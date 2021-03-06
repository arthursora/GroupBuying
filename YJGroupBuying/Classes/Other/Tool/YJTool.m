//
//  YJTool.m
//  NoteMark
//
//  Created by 朱亚杰 on 2018/1/5.
//  Copyright © 2018年 朱亚杰. All rights reserved.
//

#import "YJTool.h"
#import "FMDatabase.h"
#import <ifaddrs.h>
#import <arpa/inet.h>
#import <sys/utsname.h>
#import <net/if.h>
#import <AudioToolbox/AudioToolbox.h>

#define IOS_CELLULAR    @"pdp_ip0"
#define IOS_WIFI        @"en0"
#define IOS_VPN         @"utun0"
#define IP_ADDR_IPv4    @"ipv4"
#define IP_ADDR_IPv6    @"ipv6"

@implementation YJTool


//将color转为UIImage
+ (UIImage *)createImageWithColor:(UIColor *)color {
    
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return theImage;
}


//判断是什么格式
+ (BOOL) imageHasAlpha: (UIImage *) image {
    
    CGImageAlphaInfo alpha = CGImageGetAlphaInfo(image.CGImage);
    return (alpha == kCGImageAlphaFirst ||
            alpha == kCGImageAlphaLast ||
            alpha == kCGImageAlphaPremultipliedFirst ||
            alpha == kCGImageAlphaPremultipliedLast);
}

//图片转换base64
+ (NSString *)base64ImageData: (UIImage *) image {
    
    NSData *imageData = nil;
    NSString *mimeType = nil;
    
    if ([self imageHasAlpha: image]) {
        imageData = UIImagePNGRepresentation(image);
        mimeType = @"image/png";
    } else {
        imageData = UIImageJPEGRepresentation(image, 0.09f);
        mimeType = @"image/jpg";
    }
    
    return [NSString stringWithFormat:@"data:%@;base64,%@", mimeType,
            [imageData base64EncodedStringWithOptions: NSDataBase64Encoding64CharacterLineLength]];
}


// 根据字符串，行间距，字体大小，最大宽度 获取label的高度
+ (CGFloat) heightWithStr:(NSString *)str lineSpacing:(CGFloat)lineSpacing fontSize:(CGFloat)size maxLabelWidth:(CGFloat)MaxLabelWidth{
    
    if (str==nil) return 25;
    
    NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc] initWithString:str];
    
    NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
    
    if (lineSpacing != 0) {
        
        style.lineSpacing = lineSpacing;
        [attrStr addAttribute:NSParagraphStyleAttributeName value:style range:NSMakeRange(0, attrStr.length)];
    }
    
    //    3.2. 计算文字的高度，根据 label 的宽最大度和行间距
    NSDictionary *dictonary = @{
                                NSFontAttributeName : [UIFont systemFontOfSize:size],
                                NSParagraphStyleAttributeName : style
                                };
    
    CGFloat height = [str boundingRectWithSize:CGSizeMake(MaxLabelWidth, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:dictonary context:nil].size.height;
    return height;
}

// 根据字符串，行间距，字体大小，最大宽度 获取label的高度
+ (CGFloat)widthWithStr:(NSString *)str fontSize:(CGFloat)size {
    
    if (str==nil) return 25;
    
    //    3.2. 计算文字的高度，根据 label 的宽最大度和行间距
    NSDictionary *dictonary = @{
                                NSFontAttributeName : [UIFont systemFontOfSize:size]
                                };
    
    CGFloat height = [str boundingRectWithSize:CGSizeMake(MAXFLOAT, SCREEN_HEIGHT) options:NSStringDrawingUsesLineFragmentOrigin attributes:dictonary context:nil].size.width;
    return height;
}

+ (CGFloat)heightWithStr:(NSString *)str firstLineHeadIndent:(CGFloat)firstLineHeadIndent headIndent:(CGFloat)headIndent lineSpacing:(CGFloat)lineSpacing fontSize:(CGFloat)size maxLabelWidth:(CGFloat)MaxLabelWidth {
    
    if (str==nil) return 25;
    
    NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc] initWithString:str];
    
    NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
    
    if (lineSpacing != 0) {
        style.firstLineHeadIndent = firstLineHeadIndent;
        style.headIndent = headIndent;
        style.lineSpacing = lineSpacing;
        style.alignment = NSTextAlignmentJustified;
        [attrStr addAttribute:NSParagraphStyleAttributeName value:style range:NSMakeRange(0, attrStr.length)];
    }
    
    //    3.2. 计算文字的高度，根据 label 的宽最大度和行间距
    NSDictionary *dictonary = @{
                                NSFontAttributeName : [UIFont systemFontOfSize:size],
                                NSParagraphStyleAttributeName : style
                                };
    
    CGFloat height = [str boundingRectWithSize:CGSizeMake(MaxLabelWidth, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:dictonary context:nil].size.height;
    return height;
}


// Get IP Address
+ (NSString *)getIPAddress {
    
    NSString *address = @"error";
    struct ifaddrs *interfaces = NULL;
    struct ifaddrs *temp_addr = NULL;
    int success = 0;
    // retrieve the current interfaces - returns 0 on success
    success = getifaddrs(&interfaces);
    if (success == 0) {
        // Loop through linked list of interfaces
        temp_addr = interfaces;
        while(temp_addr != NULL) {
            if(temp_addr->ifa_addr->sa_family == AF_INET) {
                // Check if interface is en0 which is the wifi connection on the iPhone
                if([[NSString stringWithUTF8String:temp_addr->ifa_name] isEqualToString:@"en0"]) {
                    // Get NSString from C String
                    address = [NSString stringWithUTF8String:inet_ntoa(((struct sockaddr_in *)temp_addr->ifa_addr)->sin_addr)];
                }
            }
            temp_addr = temp_addr->ifa_next;
        }
    }
    // Free memory
    freeifaddrs(interfaces);
    return address;
}

/**
 * 判断手机号
 *
 */
+ (BOOL)validateMobileNumber:(NSString *)mobileNum {
    
    if ([mobileNum containsString:@"-"]) {
        mobileNum = [mobileNum stringByReplacingOccurrencesOfString:@"-" withString:@""];
    }
    if ([mobileNum containsString:@" "]) {
        mobileNum = [mobileNum stringByReplacingOccurrencesOfString:@" " withString:@""];
    }
    /**
     * 手机号码
     * 移动：134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188
     * 联通：130,131,132,152,155,156,185,186
     * 电信：133,1349,153,180,189
     */
    NSString *MOBILE = @"^1(3[0-9]|5[0-35-9]|8[025-9])\\d{8}$";
    
    /**
     * 中国移动：China Mobile
     * 134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188
     */
    NSString *CM = @"^1(34[0-8]|(3[5-9]|5[017-9]|8[278])\\d)\\d{7}$";
    
    /**
     * 中国联通：China Unicom
     * 130,131,132,152,155,156,185,186
     */
    NSString *CU = @"^1(3[0-2]|5[256]|8[56])\\d{8}$";
    
    /**
     * 中国电信：China Telecom
     * 133,1349,153,180,189
     */
    NSString *CT = @"^1((33|53|8[09])[0-9]|349)\\d{7}$";
    
    /**
     *大陆地区固话及小灵通
     * 区号：010,020,021,022,023,024,025,027,028,029
     *号码：七位或八位
     */
    NSString * PHS = @"^0(10|2[0-5789]|\\d{3})\\d{7,8}$";
    
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
    NSPredicate *regextestcm = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM];
    NSPredicate *regextestcu = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU];
    NSPredicate *regextestct = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT];
    NSPredicate *regextestphs = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", PHS];
    
    if (([regextestmobile evaluateWithObject:mobileNum] == YES) || ([regextestcm evaluateWithObject:mobileNum] == YES) || ([regextestct evaluateWithObject:mobileNum] == YES) || ([regextestcu evaluateWithObject:mobileNum] == YES)|| ([regextestphs evaluateWithObject:mobileNum] == YES)) {
        
        return YES;
    }else {
        return NO;
    }
}

/**
 * 判断手机号
 *
 */
+ (BOOL)validatePhoneNumber:(NSString *)str {
    
    if ([str containsString:@"-"]) {
        str = [str stringByReplacingOccurrencesOfString:@"-" withString:@""];
    }
    if ([str containsString:@" "]) {
        str = [str stringByReplacingOccurrencesOfString:@" " withString:@""];
    }
    if (str.length <11) return NO;
    NSString *phoneRegex = @"^1[34578]\\d{9}$";
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneRegex];
    return [phoneTest evaluateWithObject:str];
}

/**
 *  判断验证码 *
 */
+ (BOOL)validateCodeNumber:(NSString *)code {
    
    NSString *CodeNumberRegex =@"^[A-Zz-z0-9]{4,6}+$";
    
    NSPredicate *CodeNumberpredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",CodeNumberRegex];
    return [CodeNumberpredicate evaluateWithObject:code];
}


/**
 *  判断密码
 *
 */
+ (BOOL)validatePassword:(NSString *)passWord {
    
    NSString *passWordRegex = @"^[a-zA-Z0-9]{6,20}+$";
    NSPredicate *passWordPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",passWordRegex];
    
    return [passWordPredicate evaluateWithObject:passWord];
}

/**
 *  判断用户名
 *
 */
+ (BOOL)validateUserName:(NSString *)name {
    
    NSString *userNameRegex =@"^[A-Zz-z0-9]{6,20}+$";
    
    NSPredicate *userNamepredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",userNameRegex];
    return [userNamepredicate evaluateWithObject:name];
}



+ (BOOL) validateEmail:(NSString *)email
{
    NSString *emailRegex =@"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:email];
}

//验证年月日
+ (BOOL)validateWithDate:(NSString *)date {
    
    NSString *dateRegex= @"(([0-9]{3}[1-9]|[0-9]{2}[1-9][0-9]{1}|[0-9]{1}[1-9][0-9]{2}|[1-9][0-9]{3})-(((0[13578]|1[02])-(0[1-9]|[12][0-9]|3[01]))|((0[469]|11)-(0[1-9]|[12][0-9]|30))|(02-(0[1-9]|[1][0-9]|2[0-8]))))|((([0-9]{2})(0[48]|[2468][048]|[13579][26])|((0[48]|[2468][048]|[3579][26])00))-02-29)";
    
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", dateRegex];
    return [emailTest evaluateWithObject:date];
}

//身份证号
+ (BOOL) validateIdentityCard: (NSString *)identityCard {
    
    BOOL flag;
    
    if (identityCard.length < 18  ) {
        flag = NO;
        return flag;
    }
    NSString *regex2 = @"^(\\d{14}|\\d{17})(\\d|[xX])$";
    NSPredicate *identityCardPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex2];
    return [identityCardPredicate evaluateWithObject:identityCard];
}

// 银行开户
+ (BOOL)validateBankCard: (NSString *)bankCard {
    
    NSString *regex2 = @"^([0-9]{16}|[0-9]{19})$";
    NSPredicate *identityCardPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex2];
    return [identityCardPredicate evaluateWithObject:bankCard];
    
    //    NSString *regex2 = @"^([0-9]{16}|[0-9]{19})$";
    //    NSPredicate *identityCardPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex2];
    //    return [identityCardPredicate evaluateWithObject:bankCard];
    
    //    if(bankCard.length==0)
    //    {
    //        return NO;
    //    }
    //    NSString *digitsOnly = @"";
    //    char c;
    //    for (int i = 0; i < bankCard.length; i++)
    //    {
    //        c = [bankCard characterAtIndex:i];
    //        if (isdigit(c))
    //        {
    //            digitsOnly =[digitsOnly stringByAppendingFormat:@"%c",c];
    //        }
    //    }
    //    int sum = 0;
    //    int digit = 0;
    //    int addend = 0;
    //    BOOL timesTwo = false;
    //    for (NSint i = digitsOnly.length - 1; i >= 0; i--)
    //    {
    //        digit = [digitsOnly characterAtIndex:i] - '0';
    //        if (timesTwo)
    //        {
    //            addend = digit * 2;
    //            if (addend > 9) {
    //                addend -= 9;
    //            }
    //        }
    //        else {
    //            addend = digit;
    //        }
    //        sum += addend;
    //        timesTwo = !timesTwo;
    //    }
    //    int modulus = sum % 10;
    //    return modulus == 0;
}

//昵称
+ (BOOL)validateNickname:(NSString *)nickname {
    
    //国外人名字[u4e00-u9fa5]
    //[\u4E00-\u9FA5]{2,5}(?:·[\u4E00-\u9FA5]{2,5})*
    //     NSString *nicknameRegex = @"^[\u4e00-\u9fa5]{4,8}$";
    NSString *nicknameRegex = @"[\u4e00-\u9fa5]";
    NSPredicate *passWordPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",nicknameRegex];
    return [passWordPredicate evaluateWithObject:nickname];
}

+ (BOOL)isBlankString:(NSString *)string {
    
    if ([string isEqual:[NSNull null]]) {
        
        return YES;
    }
    if ([string isKindOfClass:[NSNull class]]) {
        return YES;
    }
    if ([[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length]==0) {
        return YES;
    }
    return NO;
}

+ (NSString *)numberStringWithString:(NSString *)string {
    
    NSString *result = [[string componentsSeparatedByCharactersInSet:[[NSCharacterSet characterSetWithCharactersInString:@"0123456789"] invertedSet]] componentsJoinedByString:@""];
    return result;
}

+ (NSString *)timeWithTimeIntervalString:(NSString *)timeString {
    
    // 格式化时间
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    formatter.timeZone = [NSTimeZone timeZoneWithName:@"beijing"];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    // 毫秒值转化为秒
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:[timeString doubleValue]/ 1000.0];
    NSString *dateString = [formatter stringFromDate:date];
    return dateString;
}

+ (NSString *)timeWithTimeIntervalString:(NSString *)timeString formatString:(NSString *)formatString {
    
    // 格式化时间
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    formatter.timeZone = [NSTimeZone timeZoneWithName:@"beijing"];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:formatString];
    
    // 毫秒值转化为秒
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:[timeString doubleValue]/ 1000.0];
    NSString *dateString = [formatter stringFromDate:date];
    return dateString;
}

// 改变图片尺寸
+ (UIImage *)thumbnailWithImageWithoutScale:(UIImage *)image size:(CGSize)asize {
    
    UIImage *newimage;
    
    if (nil == image) {
        newimage = nil;
        
    } else {
        CGSize oldsize = image.size;
        CGRect rect;
        
        if (asize.width/asize.height > oldsize.width/oldsize.height) {
            
            rect.size.width = asize.width;
            rect.size.height = asize.height;
            rect.origin.x = (asize.width - rect.size.width)/2;
            rect.origin.y =0;
            
        } else{
            rect.size.width = asize.width;
            rect.size.height = asize.height;
            rect.origin.x =0;
            rect.origin.y = (asize.height - rect.size.height)/2;
        }
        UIGraphicsBeginImageContext(asize);
        CGContextRef context =UIGraphicsGetCurrentContext();
        CGContextSetFillColorWithColor(context, [[UIColor clearColor] CGColor]);
        UIRectFill(CGRectMake(0,0, asize.width, asize.height));//clear background
        [image drawInRect:rect];
        newimage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
    }
    return newimage;
}



+ (NSString *)deviceVersion {
    
    // 需要#import "sys/utsname.h"
    struct utsname systemInfo;
    uname(&systemInfo);
    NSString *deviceString = [NSString stringWithCString:systemInfo.machine encoding:NSUTF8StringEncoding];
    
    //iPhone
    if ([deviceString isEqualToString:@"iPhone1,1"])    return @"iPhone 1G";
    if ([deviceString isEqualToString:@"iPhone1,2"])    return @"iPhone 3G";
    if ([deviceString isEqualToString:@"iPhone2,1"])    return @"iPhone 3GS";
    if ([deviceString isEqualToString:@"iPhone3,1"])    return @"iPhone 4";
    if ([deviceString isEqualToString:@"iPhone3,2"])    return @"Verizon iPhone 4";
    if ([deviceString isEqualToString:@"iPhone4,1"])    return @"iPhone 4S";
    if ([deviceString isEqualToString:@"iPhone5,1"])    return @"iPhone 5";
    if ([deviceString isEqualToString:@"iPhone5,2"])    return @"iPhone 5";
    if ([deviceString isEqualToString:@"iPhone5,3"])    return @"iPhone 5C";
    if ([deviceString isEqualToString:@"iPhone5,4"])    return @"iPhone 5C";
    if ([deviceString isEqualToString:@"iPhone6,1"])    return @"iPhone 5S";
    if ([deviceString isEqualToString:@"iPhone6,2"])    return @"iPhone 5S";
    if ([deviceString isEqualToString:@"iPhone7,1"])    return @"iPhone 6 Plus";
    if ([deviceString isEqualToString:@"iPhone7,2"])    return @"iPhone 6";
    if ([deviceString isEqualToString:@"iPhone8,1"])    return @"iPhone 6s";
    if ([deviceString isEqualToString:@"iPhone8,2"])    return @"iPhone 6s Plus";
    
    return deviceString;
}

#pragma mark - 获取设备当前网络IP地址
+ (NSString *)getIPAddress:(BOOL)preferIPv4
{
    NSArray *searchArray = preferIPv4 ?
    @[ IOS_VPN @"/" IP_ADDR_IPv4, IOS_VPN @"/" IP_ADDR_IPv6, IOS_WIFI @"/" IP_ADDR_IPv4, IOS_WIFI @"/" IP_ADDR_IPv6, IOS_CELLULAR @"/" IP_ADDR_IPv4, IOS_CELLULAR @"/" IP_ADDR_IPv6 ] :
    @[ IOS_VPN @"/" IP_ADDR_IPv6, IOS_VPN @"/" IP_ADDR_IPv4, IOS_WIFI @"/" IP_ADDR_IPv6, IOS_WIFI @"/" IP_ADDR_IPv4, IOS_CELLULAR @"/" IP_ADDR_IPv6, IOS_CELLULAR @"/" IP_ADDR_IPv4 ] ;
    
    NSDictionary *addresses = [self getIPAddresses];
    // YJLog(@"addresses: %@", addresses);
    
    __block NSString *address;
    [searchArray enumerateObjectsUsingBlock:^(NSString *key, NSUInteger idx, BOOL *stop)
     {
         address = addresses[key];
         //筛选出IP地址格式
         if([self isValidatIP:address]) *stop = YES;
     } ];
    return address ? address : @"0.0.0.0";
}


#pragma mark - 获取设备外网IP地址
+(NSDictionary *)deviceWANIPAdress
{
    
    NSError *error;
    
    NSURL *ipURL = [NSURL URLWithString:@"http://pv.sohu.com/cityjson?ie=utf-8"];
    
    NSMutableString *ip = [NSMutableString stringWithContentsOfURL:ipURL encoding:NSUTF8StringEncoding error:&error];
    
    //判断返回字符串是否为所需数据
    
    if ([ip hasPrefix:@"var returnCitySN = "])
        
    {
        
        //对字符串进行处理，然后进行json解析
        
        //删除字符串多余字符串
        
        NSRange range = NSMakeRange(0, 19);
        
        [ip deleteCharactersInRange:range];
        
        NSString * nowIp =[ip substringToIndex:ip.length-1];
        
        //将字符串转换成二进制进行Json解析
        
        NSData * data = [nowIp dataUsingEncoding:NSUTF8StringEncoding];
        
        NSDictionary * dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        
        return dict;
        
    }
    
    return nil;
    
}

+ (BOOL)isValidatIP:(NSString *)ipAddress {
    if (ipAddress.length == 0) {
        return NO;
    }
    NSString *urlRegEx = @"^([01]?\\d\\d?|2[0-4]\\d|25[0-5])\\."
    "([01]?\\d\\d?|2[0-4]\\d|25[0-5])\\."
    "([01]?\\d\\d?|2[0-4]\\d|25[0-5])\\."
    "([01]?\\d\\d?|2[0-4]\\d|25[0-5])$";
    
    NSError *error;
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:urlRegEx options:0 error:&error];
    
    if (regex != nil) {
        NSTextCheckingResult *firstMatch=[regex firstMatchInString:ipAddress options:0 range:NSMakeRange(0, [ipAddress length])];
        
        if (firstMatch) {
            //            NSRange resultRange = [firstMatch rangeAtIndex:0];
            //            NSString *result=[ipAddress substringWithRange:resultRange];
            //输出结果
            //YJLog(@"%@",result);
            return YES;
        }
    }
    return NO;
}

+ (NSDictionary *)getIPAddresses {
    
    NSMutableDictionary *addresses = [NSMutableDictionary dictionaryWithCapacity:8];
    
    // retrieve the current interfaces - returns 0 on success
    struct ifaddrs *interfaces;
    if(!getifaddrs(&interfaces)) {
        // Loop through linked list of interfaces
        struct ifaddrs *interface;
        for(interface=interfaces; interface; interface=interface->ifa_next) {
            if(!(interface->ifa_flags & IFF_UP) /* || (interface->ifa_flags & IFF_LOOPBACK) */ ) {
                continue; // deeply nested code harder to read
            }
            const struct sockaddr_in *addr = (const struct sockaddr_in*)interface->ifa_addr;
            char addrBuf[ MAX(INET_ADDRSTRLEN, INET6_ADDRSTRLEN) ];
            if(addr && (addr->sin_family==AF_INET || addr->sin_family==AF_INET6)) {
                NSString *name = [NSString stringWithUTF8String:interface->ifa_name];
                NSString *type;
                if(addr->sin_family == AF_INET) {
                    if(inet_ntop(AF_INET, &addr->sin_addr, addrBuf, INET_ADDRSTRLEN)) {
                        type = IP_ADDR_IPv4;
                    }
                } else {
                    const struct sockaddr_in6 *addr6 = (const struct sockaddr_in6*)interface->ifa_addr;
                    if(inet_ntop(AF_INET6, &addr6->sin6_addr, addrBuf, INET6_ADDRSTRLEN)) {
                        type = IP_ADDR_IPv6;
                    }
                }
                if(type) {
                    NSString *key = [NSString stringWithFormat:@"%@/%@", name, type];
                    addresses[key] = [NSString stringWithUTF8String:addrBuf];
                }
            }
        }
        // Free memory
        freeifaddrs(interfaces);
    }
    return [addresses count] ? addresses : nil;
}

+ (NSString *)getTypeNameWithType:(NSInteger)type {
    
    NSString *typeName = [NSString stringWithFormat:@"C%ld", type];
    
    if(type > 2 && type <= 4){
        
        typeName = [NSString stringWithFormat:@"B%ld", type - 2];
        
    }else if(type > 4){
        
        typeName = [NSString stringWithFormat:@"A%ld", type - 4];
    }
    return typeName;
}



+(UIImage *)drawOvalWithImage:(UIImage *)image borderWidth:(CGFloat)border borderColor:(UIColor *)borderColor{
    
    //设置边框宽度
    
    CGFloat imageWH = image.size.width;
    
    //计算外圆的尺寸
    
    CGFloat ovalWH = imageWH + 2 * border;
    
    //开启上下文
    
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(ovalWH, ovalWH), NO, 0);
    
    //画一个大的圆形
    
    UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(0, 0, ovalWH, ovalWH)];
    
    [borderColor set];
    
    [path fill];
    
    //设置裁剪区域
    
    UIBezierPath *path1 = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(border, border, imageWH, imageWH)];
    
    [path1 addClip];
    
    //绘制图片
    
    [image drawAtPoint:CGPointMake(border, border)];
    
    //从上下文中获取图片
    
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    //关闭上下文
    
    UIGraphicsEndImageContext();
    
    return newImage;
    
}

+ (CAShapeLayer *)drawRoundWidgetWith:(CGRect)rect corderRadius:(CGFloat)radius{
    
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:rect cornerRadius:radius];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = rect;
    maskLayer.path = maskPath.CGPath;
    
    return maskLayer;
}


- (UIImage *)makeImageWithView:(UIView *)view withSize:(CGSize)size{
    
    UIGraphicsBeginImageContextWithOptions(size, NO, 0.0);
    [view.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
    
}

+(void)setAudioToolBoxWith:(NSString *)musicName and:(NSString *)musicType{
    
    NSBundle * bundle = [NSBundle mainBundle];
    NSString * path = [bundle pathForResource:musicName ofType:musicType];
    NSURL * url = [NSURL URLWithString:path];
    
    SystemSoundID soundID = 0;
    // 将URL所在的音频文件注册为系统声音,soundID音频ID标示该音频
    AudioServicesCreateSystemSoundID((__bridge CFURLRef)(url), &soundID);
    
    //播放音频
    AudioServicesPlaySystemSound(soundID);
    
    //播放系统震动
    //AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
    
    //声音销毁
    AudioServicesPlayAlertSoundWithCompletion(soundID, ^{
        NSLog(@"播放完成");
    });
    
}

+ (NSMutableArray *)resolutionGitImage{
    NSString * path = [[NSBundle mainBundle]pathForResource:@"xiaoqic" ofType:@"gif"];
    NSData * imageData = [NSData dataWithContentsOfFile:path];
    NSMutableArray *frames = [[NSMutableArray alloc] init];
    CGImageSourceRef src = CGImageSourceCreateWithData((CFDataRef)imageData, NULL);
    CGFloat animationTime = 0.f;
    if (src) {
        size_t l = CGImageSourceGetCount(src);
        frames = [NSMutableArray arrayWithCapacity:l];
        for (size_t i = 0; i < l; i++) {
            CGImageRef img = CGImageSourceCreateImageAtIndex(src, i, NULL);
            NSDictionary *properties = (NSDictionary *)CFBridgingRelease(CGImageSourceCopyPropertiesAtIndex(src, i, NULL));
            NSDictionary *frameProperties = [properties objectForKey:(NSString *)kCGImagePropertyGIFDictionary];
            NSNumber *delayTime = [frameProperties objectForKey:(NSString *)kCGImagePropertyGIFUnclampedDelayTime];
            animationTime += [delayTime floatValue];
            if (img) {
                [frames addObject:[UIImage imageWithCGImage:img]];
                CGImageRelease(img);
            }
        }
        CFRelease(src);
    }
    
    return frames;
}
@end
