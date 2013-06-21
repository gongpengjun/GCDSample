//
//  main.m
//  AsyncArrayCrash
//
//  Created by 巩 鹏军 on 13-6-21.
//  Copyright (c) 2013年 巩 鹏军. All rights reserved.
//

#import <Foundation/Foundation.h>

int main(int argc, const char * argv[])
{
    @autoreleasepool
    {
        CFAbsoluteTime beginTime = CFAbsoluteTimeGetCurrent();
        NSLog(@"%s,%d BEGIN",__FUNCTION__,__LINE__);
        dispatch_group_t group = dispatch_group_create();
        dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
        NSMutableArray *array = [[NSMutableArray alloc] init];
        for(int i = 0; i < 10000; i++)
        {
            dispatch_group_async(group,queue, ^{
                [array addObject:[NSNumber numberWithInt:i]];
            });
        }
        dispatch_group_notify(group, queue, ^{
            NSLog(@"%s,%d dispatch_group_notify took time:%f seconds",__FUNCTION__,__LINE__,(CFAbsoluteTimeGetCurrent()-beginTime));
        });
        NSLog(@"%s,%d sumbit task took time:%f seconds",__FUNCTION__,__LINE__,(CFAbsoluteTimeGetCurrent()-beginTime));
        dispatch_group_wait(group, DISPATCH_TIME_FOREVER);
        NSLog(@"%s,%d END took time:%f seconds",__FUNCTION__,__LINE__,(CFAbsoluteTimeGetCurrent()-beginTime));
    }
    return 0;
}

