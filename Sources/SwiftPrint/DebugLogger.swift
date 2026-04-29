//
//  DebugLogger.swift
//  SwiftPrint
//
//  Created by Alexandru Pavalache on 29.04.2026.
//

import Foundation

public extension SwiftPrint {
    
    final class DebugLogger {
        
        public static let shared = DebugLogger()
        
        public func clear() {
            try? fileManager.removeItem(at: logFileURL)
        }
        
        public func log(_ message: String) {
            
            serialQueue.async {
                if let data = "\(message)\n".data(using: .utf8) {
                    if self.fileManager.fileExists(atPath: self.logFileURL.path) {
                        if let handle = try? FileHandle(forWritingTo: self.logFileURL) {
                            handle.seekToEndOfFile()
                            handle.write(data)
                            handle.closeFile()
                        }
                    } else {
                        try? data.write(to: self.logFileURL)
                    }
                }
            }
        }
        
        public func printLogs() {
            do {
                let logs = try String(contentsOf: logFileURL)
                print("SwiftPrint - Logs start >>>>>>>>>>>>>>>>>")
                print(logs)
                print("SwiftPrint - Logs end <<<<<<<<<<<<<<<<<<")
            } catch {
                print("SwiftPrint - Error reading logs \(error)")
            }
        }
        
        // MARK: - Private
        
        private let logFileURL: URL
        
        /// We use custom queue because the utility queue is concurrent and we want ordered message writes
        private let serialQueue = DispatchQueue(label: "debug_log_queue")
        
        private var fileManager: FileManager {
            return FileManager.default
        }
        
        private init() {
            let cacheURL = try! FileManager.default.url(for: .cachesDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
            logFileURL = cacheURL.appendingPathComponent("debug.logs")
        }
    }
}
