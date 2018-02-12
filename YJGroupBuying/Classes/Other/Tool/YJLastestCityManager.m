//
//  YJLastestCityManager.m
//  YJGroupBuying
//
//  Created by 朱亚杰 on 2018/2/7.
//  Copyright © 2018年 朱亚杰. All rights reserved.
//

#import "YJLastestCityManager.h"

static FMDatabase *_fmdb;
static YJLastestCityManager *_instance;

@implementation YJLastestCityManager

// 单例模式
+ (id)allocWithZone:(struct _NSZone *)zone{
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [super allocWithZone:zone];
    });
    return _instance;
}

+ (instancetype)sharedLastestCity {
    
    if (_instance == nil) {
        _instance = [[YJLastestCityManager alloc] init];
    }
    return _instance;
}

- (instancetype)init {
    
    self = [super init];
    if (self) {
        [self openDB];
        [self createTable];
    }
    return self;
}

#pragma mark - 数据库操作方法
#pragma mark 打开数据库
- (void)openDB {
    
    NSString *docDir = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
    docDir = [docDir stringByAppendingPathComponent:@"hospital.db"];
    
    _fmdb = [FMDatabase databaseWithPath:docDir] ;
    if (![_fmdb open]) {
        YJLog(@"不能打开数据库");
        return ;
    }else {
        YJLog(@"成功打开数据库");
    }
}

#pragma mark 创建数据表
- (void)createTable {
    
    NSString *sqlCreateTable = @"create table if not exists yj_city_history (city_id integer not null primary key autoincrement, name text NOT NULL, add_date text)";
    BOOL res = [_fmdb executeUpdate:sqlCreateTable];
    
    if (!res) {
        YJLog(@"建表失败");
    } else {
        YJLog(@"建表成功");
    }
    [_fmdb close];
}

/**  插入模型数据 */
- (BOOL)insertCity:(YJGCity *)city {
    
    BOOL res = NO;
    if ([_fmdb open]) {
        
        NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
        fmt.dateFormat = @"yyyy-MM-dd HH:mm:ss";
        NSString *addDate = [fmt stringFromDate:[NSDate date]];
        
        res = [_fmdb executeUpdateWithFormat:@"INSERT INTO yj_city_history(name, add_date) VALUES (%@, %@);", city.name, addDate];
        [self logWithName:@"城市" type:@"新增" res:res];
    }
    return res;
}

/** 查询数据 */
- (NSArray *)queryCities {
    
    NSMutableArray *hospitals = [NSMutableArray array];
    
    if ([_fmdb open]) {
        
        NSString *querySql = [NSString stringWithFormat:@"SELECT * FROM yj_city_history order by add_date desc;"];
        
        FMResultSet *set = [_fmdb executeQuery:querySql];
        
        while ([set next]) {
            
            YJGCity *city = [[YJGCity alloc] init];
            city.cityId = [set intForColumn:@"city_id"];
            city.name = [set stringForColumn:@"name"];
            
            [hospitals addObject:city];
        }
        [_fmdb close];
    }
    return hospitals;
}

/** 修改数据 */
- (BOOL)modifyCity:(NSString *)cityName {
    
    BOOL res = NO;
    
    NSMutableArray *cities = [NSMutableArray array];
    if ([_fmdb open]) {
        
        NSInteger cityId = 0;
        
        NSString *querySql = [NSString stringWithFormat:@"SELECT * FROM yj_city_history where name = '%@';", cityName];
        FMResultSet *set = [_fmdb executeQuery:querySql];
        
        while ([set next]) {
            
            YJGCity *city = [[YJGCity alloc] init];
            city.cityId = [set intForColumn:@"city_id"];
            cityId = city.cityId;
            city.name = [set stringForColumn:@"name"];
            [cities addObject:city];
        }
        
        NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
        fmt.dateFormat = @"yyyy-MM-dd HH:mm:ss";
        NSString *addDate = [fmt stringFromDate:[NSDate date]];
        
        if (cities.count > 0) {
            
            NSString *modifySql = [NSString stringWithFormat:@"UPDATE yj_city_history SET add_date = '%@' WHERE city_id = %ld", addDate, cityId];
            res = [_fmdb executeUpdate:modifySql];
            
            [self logWithName:@"城市" type:@"修改" res:res];
        }else {
            
            res = [_fmdb executeUpdateWithFormat:@"INSERT INTO yj_city_history(name, add_date) VALUES (%@, %@);", cityName, addDate];
            [self logWithName:@"城市" type:@"新增" res:res];
        }
    }
    return res;
}

- (void)logWithName:(NSString *)name type:(NSString *)type res:(BOOL)res {
    
    NSString *successOrFail = res ? @"成功" : @"失败";
    YJLog(@"%@历史记录－%@%@", name, type, successOrFail);
}


@end
