//
//  Helper.swift
//  Apple Repos
//
//  Created by Calvin Saragih on 15/07/20.
//  Copyright © 2020 Calvin. All rights reserved.
//

import Foundation
import UIKit
class Helper {
    
    static func getValueJson(json:Data,key:String) -> String{
        do {
            if let json = try JSONSerialization.jsonObject(with: json, options: []) as? [String: Any] {
                if let string = json[key] as? String {
                    return string
                }
            }
        } catch let error as NSError {
            print("Failed to load: \(error.localizedDescription)")
            return ""
        }
        return ""
    }
}

extension UIViewController{
    
    func showToast(message : String, font: UIFont) {
        
        let toastLabel = UILabel(frame: CGRect(x: self.view.frame.size.width/2 - 75, y: self.view.frame.size.height-100, width: 150, height: 35))
        toastLabel.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        toastLabel.textColor = UIColor.white
        toastLabel.font = font
        toastLabel.textAlignment = .center;
        toastLabel.text = message
        toastLabel.alpha = 1.0
        toastLabel.layer.cornerRadius = 10;
        toastLabel.clipsToBounds  =  true
        self.view.addSubview(toastLabel)
        UIView.animate(withDuration: 4.0, delay: 0.1, options: .curveEaseOut, animations: {
            toastLabel.alpha = 0.0
        }, completion: {(isCompleted) in
            toastLabel.removeFromSuperview()
        })
    }
    
}


