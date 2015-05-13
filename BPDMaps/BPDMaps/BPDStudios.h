//
//  BPDStudios.h
//  BPDMaps
//
//  Created by Wesllei on 13/05/15.
//  Copyright (c) 2015 Wesllei. All rights reserved.
//

#import <Foundation/Foundation.h>
@import UIKit;
@import CoreData;

@interface BPDStudios : NSManagedObject

@property (nonatomic, retain) NSString * id;
@property (nonatomic, retain) NSString * nome;
@property (nonatomic, retain) NSString * diaFuncionamento;
@property (nonatomic, retain) NSString * horaDisponivel;
@property (nonatomic, retain) NSNumber * valorHora;


@property (nonatomic, retain) NSNumber * latitude;
@property (nonatomic, retain) NSNumber * longitude;



@end
