# MLLocalizedIndexedCollationHelp

## Introduction

My project to use the address book, and when I wrote eight bad chaos, redundant code. So I do a little finishing, I hope this can be useful to others. If the process of any problems, please add sincerely hope you can tell me and communicate with me, now I do not have this open source code, if you want to use the source code, please contact me well, I will be very happy to learn it is with you together.（bad english,you know）


## Features

-  Sort data model array very easy
-  To an array of contacts as sorted as iphone

![sample](https://raw.githubusercontent.com/Lanmaq/MLLocalizedIndexedCollationHelp/master/Demo.gif)

For first-hand experience, just open the project and run it.

## Requirements

- iOS 7.0+
- ARC

##Usage

See the code snippet below for an example of how to implement, or example project would be easy to understand.

```objective-c
[[MLLocalizedIndexedCollationHelper shareInstance] sortObjects:_testDataArray selector:@selector(description) result:^(NSDictionary *dictionary,NSError *error) {
    if (!dictionary){
    NSLog(@"%@",error);
    }
    //doing something here
}];

```

comstom queue

```objective-c
dispatch_queue_t queue = dispatch_queue_create(DISPATCH_QUEUE_PRIORITY_DEFAULT, NULL);

[[MLLocalizedIndexedCollationHelper shareInstance] sortObjects:_testDataArray selector:@selector(description) onQueue:queue result:^(NSDictionary * _Nonnull dictionary, NSError * _Nonnull error) {
    if (!dictionary){
    NSLog(@"%@",error);
    }
    //do something you want
    dispatch_async(dispatch_get_main_queue(), ^{
    //update UI
    });
}];

```

## License

See the LICENSE file for more info
Copyright (c) 2015 Lanmaq

