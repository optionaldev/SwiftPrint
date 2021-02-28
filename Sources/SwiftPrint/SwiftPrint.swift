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
                                        logType: LogType,
                                        filePath: String,
                                        lineOfCode: UInt) -> String? {
        guard canPrint(logType),
              messageOrNil != nil || (messageOrNil == nil && Setup.printNilMessages) else
        {
            return nil
        }
        
        let iconString: String
        if let string = icon(forAddress: address(of: object)) {
            iconString = "\(string) "
        } else {
            iconString = ""
        }
        
        let prefix: String
        if let icon = logType.prefix {
            prefix = "\(icon) "
        } else {
            prefix = ""
        }
        
        let message = messageOrNil != nil ? "\(messageOrNil!)" : "nil"
        
        return "\(currentDateAsString) | \(fileNameFromPath(filePath)):\(lineOfCodeString(lineOfCode)) \(iconString)| \(prefix)\(message)"
    }
    
    // MARK: - Internal
    
    internal static var addressIcons = AddressIcons()
    internal static var weakArray: [WeakReference] = []
    
    internal static func address(of object: AnyObject?) -> String? {
        if object != nil {
            let reference = WeakReference(object: object)
            weakArray.append(reference)
            return reference.string
        }
        return nil
    }
    
    internal static func icon(forAddress addressString: String?) -> String? {
        if let addressString = addressString {
            return addressIcons.icon(for: addressString)
        }
        return nil
    }
    
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
    
    internal static func canPrint(_ logType: LogType) -> Bool {
        guard Setup.isEnabled else {
            return false
        }
        switch Setup.logLevel {
        case .all:
            return true
        case .none:
            return false
        case .errorsAndUnexpected:
            return logType == .error || logType == .unexpected
        case .unexpectedOnly:
            return logType == .unexpected
        }
    }
}
