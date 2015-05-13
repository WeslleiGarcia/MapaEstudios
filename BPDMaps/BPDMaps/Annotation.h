//
//  Annotation.h
//  BPDMaps
//
//  Created by Wesllei on 13/05/15.
//  Copyright (c) 2015 Wesllei. All rights reserved.
//

#import <Foundation/Foundation.h>
@import  MapKit;
@interface Annotation : NSObject<MKAnnotation>

@property(nonatomic, assign)CLLocationCoordinate2D coordinate;
@property(nonatomic, copy) NSString *title;
@property(nonatomic, copy) NSString *subtitle;

@end
