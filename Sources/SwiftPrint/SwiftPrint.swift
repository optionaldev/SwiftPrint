//
// The SwiftPrint project.
// Created by optionaldev on 22/02/2021.
// Copyright © 2021 optionaldev. All rights reserved.
//

import struct Foundation.Date

public enum SwiftPrint {
    
    // MARK: - Public
    
    public static func generateOutput(message messageOrNil: Any?,
                                        object: AnyObject?,
                                        filePath: String,
                                        lineOfCode: UInt) -> String? {
        guard messageOrNil != nil || (messageOrNil == nil && Setup.printNilMessages) else
        {
            return nil
        }
        
        let message = messageOrNil != nil ? "\(messageOrNil!)" : "nil"
        
        return "\(currentDateAsString) | \(fileNameFromPath(filePath)):\(lineOfCodeString(lineOfCode)) | \(message)"
    }
    
    // MARK: - Internal
    
    // Prefixes number of lines of code with 2 spaces for numbers 0-10 and with 1 space for numbers 10-99
    internal static func lineOfCodeString(_ lineOfCode: UInt) -> String {
        return lineOfCode < 10 ? "  \(lineOfCode)" : (lineOfCode < 100 ? " \(lineOfCode)" : "\(lineOfCode)")
    }
    
    // Having "/" in the name is not valid, so the only question remainins:
    // Are there situations in which you have swift files with multiple periods?
    internal static func fileNameFromPath(_ filePath: String) -> String {
        return String(filePath.split(separator: "/").last?.split(separator: ".").first ?? "")
    }
    
    internal static var currentDateAsString: String {
        Setup.timestampDateFormatter.string(from: Date())
    }
}
