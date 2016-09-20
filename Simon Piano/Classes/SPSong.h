//
//  SPSong.h
//  Simon Piano
//
//  Created by Elliot Schrock on 9/19/16.
//  Copyright © 2016 Triller. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Mantle.h"

@interface SPSong : MTLModel <MTLJSONSerializing>
@property (nonatomic) int noteId;
@property (nonatomic, strong) NSString *songDescription;
@property (nonatomic, strong) NSArray *notes;
@end
