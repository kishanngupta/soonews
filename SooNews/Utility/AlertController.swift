//
//  AlertController.swift
//  SooNews
//
//  Created by Kishan Gupta on 26/04/19.
//  Copyright © 2019 KishanGupta. All rights reserved.
//

import Foundation
import UIKit

class AlertController {
    func showAlert(title: String, message: String, completion : @escaping () -> Void) -> UIAlertController{
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let actionOk = UIAlertAction(title: Key.ok, style: .default) { (_) in
            completion()
        }
        let actionCancel = UIAlertAction(title: Key.cancel, style: .destructive) { (_) in
            
        }
        alert.addAction(actionOk)
        alert.addAction(actionCancel)
        return alert
        
    }
}
