//
//  Pin.h
//  Ardunio_IOS
//
//  Created by MEC0825 on 12-11-8.
//  Copyright (c) 2012年 Hiscene. All rights reserved.
//

#ifndef Ardunio_IOS_Pin_h
#define Ardunio_IOS_Pin_h

/*----------------------------------------*/
/*    Description:   I/O of Arduino UNO   */
/*    Author:        MEC0825              */
/*    Version:       1.0.0                */
/*    Lastupdate:    12-11-7              */
/*----------------------------------------*/

//  Logic Pins

#define PIN_00      0x00    //  RX - receive
#define PIN_01      0x01    //  TX - transport
#define PIN_02      0x02
#define PIN_03      0x03    //  ~
#define PIN_04      0x04
#define PIN_05      0x05    //  ~
#define PIN_06      0x06    //  ~
#define PIN_07      0x07
#define PIN_08      0x08
#define PIN_09      0x09    //  ~
#define PIN_10      0x0a    //  ~
#define PIN_11      0x0b    //  ~
#define PIN_12      0x0c
#define PIN_13      0x0d    //  Light

//  Analog Read Pins

#define ANA_00      0x0e
#define ANA_01      0x0f
#define ANA_02      0x10
#define ANA_03      0x11
#define ANA_04      0x12
#define ANA_05      0x13
#define ANA_06      0x14

//  Analog Write Pins

#define PWM_00      PIN_03
#define PWM_01      PIN_05
#define PWM_02      PIN_06
#define PWM_03      PIN_09
#define PWM_04      PIN_10
#define PWM_05      PIN_11

/*----------------------------------------*/
/*    Description:   I/O of L298P Shield  */
/*    Author:        MEC0825              */
/*    Version:       1.0.0                */
/*    Lastupdate:    12-11-7              */
/*----------------------------------------*/

//  Motor Pins

#define ANA_E1      PIN_05  //  Controll speed
#define ANA_E2      PIN_06  //  Controll speed
#define PIN_M1      PIN_04  //  Run back
#define PIN_M2      PIN_07  //  Run back

#endif
