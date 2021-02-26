//
// The SwiftPrint project.
// Created by optionaldev on 23/02/2021.
// Copyright © 2021 optionaldev. All rights reserved.
// 

import class Foundation.DateFormatter

public extension SwiftPrint {
    
    final class Setup {
        
        internal static let timestampDateFormatter: DateFormatter = {
            let formatter = DateFormatter()
            formatter.dateFormat = "HH:mm:ss.SSS"
            return formatter
        }()
        
        public static var logLevel: LogLevel = .all
        public static var isEnabled = true
        public static var printNilMessages: Bool = false
        
        // MARK: - Private
        
        private init() {}
    }
}
