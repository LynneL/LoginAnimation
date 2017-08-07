//
//  Utility.swift
//  SplashLogin
//
//  Created by Lynn on 8/4/17.
//  Copyright © 2017 Lynne. All rights reserved.
//

import Foundation
import AudioToolbox

struct Utility {
    
    private init (){
        
    }
    
    static func vibrate(){
        if (UIDevice.current.value(forKey: "_feedbackSupportLevel") as! Int) == 2{
            let generator = UIImpactFeedbackGenerator(style: .heavy)
            generator.prepare()
            generator.impactOccurred()
        }else{
            AudioServicesPlayAlertSound(kSystemSoundID_Vibrate)
        }
    }
}
