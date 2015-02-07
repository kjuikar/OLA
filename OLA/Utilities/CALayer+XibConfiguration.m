//
//  CALayer+XibConfiguration.m
//  Tabtor
//
//  Created by Swapnil Patil on 12/10/13.
//
//

#import "CALayer+XibConfiguration.h"

@implementation CALayer (XibConfiguration)

-(void)setBorderUIColor:(UIColor*)color{
    
    self.borderColor = color.CGColor;
}

-(UIColor*)borderUIColor{
    
    return [UIColor colorWithCGColor:self.borderColor];
}

@end
