//
//  BaseViewModel.swift
//  moviedb-mandiri
//
//  Created by Calvin Saragih on 19/07/20.
//  Copyright © 2020 Calvin. All rights reserved.
//

import Foundation

class BaseViewModel {
    
    public enum ErrorReporter {
        case internetError(String)
        case serverMessage(String)
    }
}
