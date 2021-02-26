//
// The SwiftPrint project.
// Created by optionaldev on 26/02/2021.
// Copyright © 2021 optionaldev. All rights reserved.
// 

public extension SwiftPrint {
    
    enum LogType: Int {
        
        case unexpected = 10
        case error = 20
        case info = 30
        
        internal var prefix: String? {
            switch self {
            case .unexpected:
                return "❌"
            case .error:
                return "⚠️"
            case .info:
                return nil
            }
        }
    }
}
