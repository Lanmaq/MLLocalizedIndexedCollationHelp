//
//  MLLocalizedIndexedCollationHelper.h
//  MLLocalizedIndexedCollationHelper
//
//  Created by Lanmaq on 15/11/10.
//  Copyright © 2015年 Lanmaq@lanmaqmay.com. All rights reserved.

//  MY PROJECT USED THE ADDRESS BOOK, WHEN I WROTE THE CHAOS FROM EIGHT BAD, REDUNDANT CODE. SO I'M DOING A LITTLE FINISHING, I HOPE THIS CAN BE USEFUL TO OTHERS. IF THERE IS ANY PROBLEM IN THE COURSE, ADD SINCERELY HOPE THAT YOU CAN TELL ME, AND I COMMUNITCATE, AND NOW I DO NOT HAVE THIS OPEN SOURCE CODE, IF YOU WANT TO USE THE SOURCE CODE, CONTACT ME WELL, I WILL BE VERY HAPPY AND LEARN IT WITH YOU TOGHTER .


#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
NS_CLASS_AVAILABLE_IOS(3_0)@interface MLLocalizedIndexedCollationHelper : NSObject

/* Returns the singleton instance.
 */
+ (MLLocalizedIndexedCollationHelper *) shareInstance;

/**
 * @param targetArray   target Array. must have count if not will have a error
 * @param selector       * !!!selector must not take any arguments and return an NSString.* must not be null if not will have a error
 * @param resultBlock   return result thought block.
 * @return  dictionary     3key/value pairs keys:"SortedArray"、"SortResultArraySectionIndexTitle"、"SortResultArray". value see runtime.
 * @return  error             If an error occurs, upon return contains an `NSError` object that describes the problem.
 */
-  (void) sortObjects: (nonnull NSArray *)targetArray selector: (nonnull SEL)selector result: (void (^)(NSDictionary *dictionary,NSError *error))resultBlock;

// If you have a large amount of data it is best to use a queue avoid blocking the main thread.(tips:if you set queue nil,it work in main queue)
-  (void) sortObjects: (nonnull NSArray *)targetArray selector: (nonnull SEL)selector onQueue:(dispatch_queue_t)queue result: (void (^)(NSDictionary *dictionary,NSError *error))resultBlock;

@end
NS_ASSUME_NONNULL_END