//
//  Data.h
//  Ardunio_IOS
//
//  Created by MEC0825 on 12-11-7.
//  Copyright (c) 2012年 Hiscene. All rights reserved.
//

/*-------------------------------------------*/
/*    Description:   Core Operation Format   */
/*    Author:        MEC0825                 */
/*    Version:       1.0.0                   */
/*    Lastupdate:    12-11-7                 */
/*-------------------------------------------*/

//  Operation Format

/*-------------------------------------------*/
/*|    class    |  operation  |    value    |*/
/*-------------------------------------------*/

#import <UIKit/UIKit.h>

#define DATA_LENGTH 3 * (1 << 10)

@interface Data : NSObject {
    UInt8   data_[DATA_LENGTH];
    int     ptr_;
}

- (UInt8*)data;
- (int)dataLength;

#define ADD(__object__,__opr__,__adr__,__val__) \
\
[__object__ addClass:__opr__  \
           operation:__adr__  \
               value:__val__]

- (BOOL)addClass:(UInt8)opr
       operation:(UInt8)adr
           value:(UInt8)val;

#define CLR(__object__) \
\
[__object__ clearAllData];

- (void)clearAllData;

#define PNT(__object__) \
\
[__object__ printAllData];

- (void)printAllData;

@end
