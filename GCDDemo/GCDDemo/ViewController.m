//
//  ViewController.m
//  GCDDemo
//
//  Created by lmh on 2018/1/16.
//  Copyright © 2018年 SK. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    [self asyncConcurrent];
//    [self syncSerial];
    // 等同于 [self syncConcurrent]
    
//    [self asyncSerial];
    
//       dispatch_queue_t queue = dispatch_queue_create("test.queue", DISPATCH_QUEUE_CONCURRENT);
//
//    dispatch_async(queue, ^{
//
//
//        [self syncMain];
//
//
//    });
    

//    [self asyncMain];
    
//    [self barrier];
    
    [self apply];
    

    
}



- (void)syncConcurrent
{
    NSLog(@"synConcurrent --- begin");
    
    dispatch_queue_t queue = dispatch_queue_create("test.queue", DISPATCH_QUEUE_CONCURRENT);
    
    dispatch_sync(queue, ^{
        
        
        for (int i = 0 ; i < 2; ++i) {
            
            NSLog(@"1-------%@", [NSThread currentThread]);
        }
    });
    dispatch_sync(queue, ^{
        
        
        for (int i = 0 ; i < 2; ++i) {
            
            NSLog(@"2-------%@", [NSThread currentThread]);
        }
    });
    
    dispatch_sync(queue, ^{
        
        
        for (int i = 0 ; i < 2; ++i) {
            
            NSLog(@"3-------%@", [NSThread currentThread]);
        }
    });
    
     NSLog(@"synConcurrent --- end");
    
    
}

- (void)asyncConcurrent
{
    NSLog(@"asyncConcurrent --- begin");
    
    dispatch_queue_t queue = dispatch_queue_create("test.queue", DISPATCH_QUEUE_CONCURRENT);
    
    dispatch_async(queue, ^{
        
        
        for (int i = 0 ; i < 2; ++i) {
            
            NSLog(@"1-------%@", [NSThread currentThread]);
        }
    });
    dispatch_async(queue, ^{
        
        
        for (int i = 0 ; i < 2; ++i) {
            
            NSLog(@"2-------%@", [NSThread currentThread]);
        }
    });
    
    dispatch_async(queue, ^{
        
        
        for (int i = 0 ; i < 2; ++i) {
            
            NSLog(@"3-------%@", [NSThread currentThread]);
        }
    });
    
    NSLog(@"asynConcurrent --- end");
}

- (void)syncSerial
{
    NSLog(@"syncSerial --- begin");
    
    dispatch_queue_t queue = dispatch_queue_create("test.queue", DISPATCH_QUEUE_SERIAL);
    
    dispatch_sync(queue, ^{
        
        
        for (int i = 0 ; i < 2; ++i) {
            
            NSLog(@"1-------%@", [NSThread currentThread]);
        }
    });
    dispatch_sync(queue, ^{
        
        
        for (int i = 0 ; i < 2; ++i) {
            
            NSLog(@"2-------%@", [NSThread currentThread]);
        }
    });
    
    dispatch_sync(queue, ^{
        
        
        for (int i = 0 ; i < 2; ++i) {
            
            NSLog(@"3-------%@", [NSThread currentThread]);
        }
    });
    
    NSLog(@"syncSerial --- end");
}


- (void)asyncSerial
{
    NSLog(@"asyncSerial --- begin");
    
    dispatch_queue_t queue = dispatch_queue_create("test.queue", DISPATCH_QUEUE_SERIAL);
    
    dispatch_async(queue, ^{
        
        
        for (int i = 0 ; i < 2; ++i) {
            
            NSLog(@"1-------%@", [NSThread currentThread]);
        }
    });
    dispatch_async(queue, ^{
        
        
        for (int i = 0 ; i < 2; ++i) {
            
            NSLog(@"2-------%@", [NSThread currentThread]);
        }
    });
    
    dispatch_async(queue, ^{
        
        
        for (int i = 0 ; i < 2; ++i) {
            
            NSLog(@"3-------%@", [NSThread currentThread]);
        }
    });
    
    NSLog(@"asyncSerial --- end");
}

- (void)syncMain
{
    
    // 死锁
    
    NSLog(@"syncMain --- begin");
    
    dispatch_queue_t queue = dispatch_get_main_queue();
    
    
    dispatch_sync(queue, ^{
        
        
        for (int i = 0 ; i < 2; ++i) {
            
            NSLog(@"1-------%@", [NSThread currentThread]);
        }
    });
    dispatch_sync(queue, ^{
        
        
        for (int i = 0 ; i < 2; ++i) {
            
            NSLog(@"2-------%@", [NSThread currentThread]);
        }
    });
    
    dispatch_sync(queue, ^{
        
        
        for (int i = 0 ; i < 2; ++i) {
            
            NSLog(@"3-------%@", [NSThread currentThread]);
        }
    });
    
    NSLog(@"syncMain --- end");
}

- (void)asyncMain
{
    
    // 死锁
    
    NSLog(@"asyncMain --- begin");
    
    dispatch_queue_t queue = dispatch_get_main_queue();
    
    
    dispatch_async(queue, ^{
        
        
        for (int i = 0 ; i < 2; ++i) {
            
            NSLog(@"1-------%@", [NSThread currentThread]);
        }
    });
    dispatch_async(queue, ^{
        
        
        for (int i = 0 ; i < 2; ++i) {
            
            NSLog(@"2-------%@", [NSThread currentThread]);
        }
    });
    
    dispatch_async(queue, ^{
        
        
        for (int i = 0 ; i < 2; ++i) {
            
            NSLog(@"3-------%@", [NSThread currentThread]);
        }
    });
    
    NSLog(@"asyncMain --- end");
}

- (void)barrier
{
    dispatch_queue_t queue = dispatch_queue_create("test.queue", DISPATCH_QUEUE_CONCURRENT);
    
    
    
    dispatch_async(queue, ^{
        
        NSLog(@"------1-------%@", [NSThread currentThread]);
        
        
    });
    
    dispatch_async(queue, ^{
        
        NSLog(@"-----2-------%@", [NSThread currentThread]);
        
        
    });
    
    
    dispatch_barrier_async(queue, ^{
       
        NSLog(@"---------barrier---------%@", [NSThread currentThread]);
        
    });
    
    dispatch_async(queue, ^{
        
        
        NSLog(@"--------3-------%@", [NSThread currentThread]);
        
    });
    
    
    dispatch_async(queue, ^{
        
        
        NSLog(@"--------4-------%@", [NSThread currentThread]);
        
    });

    
}


- (void)apply
{
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    
    
    dispatch_apply(6, queue, ^(size_t index) {
       
        
        NSLog(@"%zd----------%@", index, [NSThread currentThread]);
        
        
    });
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
