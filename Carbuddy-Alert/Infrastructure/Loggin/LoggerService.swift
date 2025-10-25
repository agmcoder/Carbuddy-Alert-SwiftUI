//
//  File.swift
//  Carbuddy-Alert
//
//  Created by agmcoder on 10/22/25.
//

import OSLog
import Foundation

enum LogPrivacy {
    case auto
    case `public`
    case `private`
    case sensitive
}

enum LogLevel: String {
    case trace
    case debug
    case info
    case notice
    case warning
    case error
    case critical
}

enum LogCategory: String {
    case presentation
    case domain
    case data
    case unknown
}

protocol Loggable {
    func log(_ level: LogLevel,
                 _ message: String,
                 _ privacy: LogPrivacy,
                 metadata: [String: Any]?,
                 file: String,
                 function: String,
                 line: Int)
}

protocol LogLevelLoggable {
    func log(_ level: LogLevel,
             _ message: String,
             _ privacy: LogPrivacy,
             metadata: [String: Any]?,
             file: String,
             function: String,
             line: Int)
    
    func trace(_ message: @autoclosure () -> String,
               metadata: @autoclosure () -> [String: Any]?,
               privacy: LogPrivacy,
               source: @autoclosure () -> String?,
               file: String,
               function: String,
               line: UInt)
    
    func debug(_ message: @autoclosure () -> String,
               metadata: @autoclosure () -> [String: Any]?,
               privacy: LogPrivacy,
               source: @autoclosure () -> String?,
               file: String,
               function: String,
               line: UInt)
    
    func info(_ message: @autoclosure () -> String,
              metadata: @autoclosure () -> [String: Any]?,
              privacy: LogPrivacy,
              source: @autoclosure () -> String?,
              file: String,
              function: String,
              line: UInt)
    
    func notice(_ message: @autoclosure () -> String,
                metadata: @autoclosure () -> [String: Any]?,
                privacy: LogPrivacy,
                source: @autoclosure () -> String?,
                file: String,
                function: String,
                line: UInt)
    
    func warning(_ message: @autoclosure () -> String,
                 metadata: @autoclosure () -> [String: Any]?,
                 privacy: LogPrivacy,
                 source: @autoclosure () -> String?,
                 file: String,
                 function: String,
                 line: UInt)
    
    func error(_ message: @autoclosure () -> String,
               metadata: @autoclosure () -> [String: Any]?,
               privacy: LogPrivacy,
               source: @autoclosure () -> String?,
               file: String,
               function: String,
               line: UInt)
    
    func critical(_ message: @autoclosure () -> String,
                  metadata: @autoclosure () -> [String: Any]?,
                  privacy: LogPrivacy,
                  source: @autoclosure () -> String?,
                  file: String,
                  function: String,
                  line: UInt)
    
}

protocol LogCategoryInferable {
    func inferCategory(fromFilePath path: String) -> LogCategory?
}

protocol LogMessageFormattable {
    func formatMessage(_ message: String,
                          metadata: [String: Any]?,
                          file: String,
                          function: String,
                          line: Int) -> String
}

protocol LogLevelFilterable {
    func log(level: LogLevel,
             privacy: LogPrivacy,
             message: String,
             using logger: os.Logger)
}

final class OSLogger: LogLevelLoggable {
    
    private let loggers: [LogCategory: os.Logger]
    private let categoryInferer: LogCategoryInferable
    private let messageFormatter: LogMessageFormattable
    private let levelFilter: LogLevelFilterable
    
    init(subsystem: String = Bundle.main.bundleIdentifier ?? "com.carbuddy.alert",
         categoryInferer: LogCategoryInferable = LogCategoryInterferer(),
         messageFormatter: LogMessageFormattable = LogMessageFormatter(),
         levelFilter: LogLevelFilterable = LogLevelFilterer()) {
        
        self.loggers = [
            .data: os.Logger(subsystem: subsystem, category: LogCategory.data.rawValue),
            .domain: os.Logger(subsystem: subsystem, category: LogCategory.domain.rawValue),
            .presentation: os.Logger(subsystem: subsystem, category: LogCategory.presentation.rawValue),
            .unknown: os.Logger(subsystem: subsystem, category: LogCategory.unknown.rawValue)
        ]
        
        self.categoryInferer = categoryInferer
        self.messageFormatter = messageFormatter
        self.levelFilter = levelFilter
    }
    
    func log(_ level: LogLevel,
             _ message: String,
             _ privacy: LogPrivacy,
             metadata: [String: Any]? = nil,
             file: String = #file,
             function: String = #function,
             line: Int = #line) {
        
        let category = categoryInferer.inferCategory(fromFilePath: file) ?? .unknown
        let logger = loggers[category] ?? loggers[.unknown]!
        
        let formattedMessage = messageFormatter.formatMessage(
            message,
            metadata: metadata,
            file: file,
            function: function,
            line: line
        )
        
        levelFilter.log(level: level, privacy: privacy, message: formattedMessage, using: logger)
    }
}

struct LogCategoryInterferer: LogCategoryInferable {
    func inferCategory(fromFilePath path: String) -> LogCategory? {
        let lower = path.lowercased()
        switch true {
        case lower.contains("/data/") || lower.contains("data/") || lower.contains("/data."):
            return .data
        case lower.contains("/domain/") || lower.contains("domain/") || lower.contains("/domain."):
            return .domain
        case lower.contains("/presentation/") || lower.contains("presentation/") || lower.contains("/presentation."):
            return .presentation
        default:
            return .unknown
        }
    }
}

struct LogMessageFormatter: LogMessageFormattable {
    func formatMessage(_ message: String,
                      metadata: [String: Any]?,
                      file: String,
                      function: String,
                      line: Int) -> String {
        
        let fileName = (file as NSString).lastPathComponent
        let location = "[\(fileName):\(line)] \(function)"
        let metadataString = formatMetadata(metadata)
        return metadataString.isEmpty ? "\(location) → \(message)" : "\(location) → \(message) | \(metadataString)"
    }
    
    private func formatMetadata(_ metadata: [String: Any]?) -> String {
        guard let metadata = metadata, !metadata.isEmpty else { return "" }
        return metadata.map { "\($0.key): \($0.value)" }.joined(separator: ", ")
    }
}

struct LogLevelFilterer: LogLevelFilterable {
    func log(level: LogLevel,
             privacy: LogPrivacy,
             message: String,
             using logger: os.Logger) {
        
        let finalMessage = addEmojiIfNeeded(to: message, for: level)
        
        switch level {
        case .trace:
            logMessage(finalMessage, privacy: privacy, using: logger.debug)
        case .debug:
            logMessage(finalMessage, privacy: privacy, using: logger.debug)
        case .info:
            logMessage(finalMessage, privacy: privacy, using: logger.info)
        case .notice:
            logMessage(finalMessage, privacy: privacy, using: logger.notice)
        case .warning:
            logMessage(finalMessage, privacy: privacy, using: logger.warning)
        case .error:
            logMessage(finalMessage, privacy: privacy, using: logger.error)
        case .critical:
            logMessage(finalMessage, privacy: privacy, using: logger.critical)
        }
    }
    
    private func logMessage(_ message: String,
                            privacy: LogPrivacy,
                            using logFunction: (OSLogMessage) -> Void) {
        switch privacy {
        case .auto:
            logFunction("\(message, privacy: .auto)")
        case .public:
            logFunction("\(message, privacy: .public)")
        case .private:
            logFunction("\(message, privacy: .private)")
        case .sensitive:
            logFunction("\(message, privacy: .sensitive)")
        }
    }
    
    private func addEmojiIfNeeded(to message: String, for level: LogLevel) -> String {
        switch level {
        case .warning: return "⚠️ \(message)"
        case .error: return "❌ \(message)"
        case .critical: return "🔥 \(message)"
        default: return message
        }
    }
}

// MARK: - Log Level extension
extension LogLevelLoggable {
    func trace(_ message: @autoclosure () -> String,
               metadata: @autoclosure () -> [String: Any]? = nil,
               privacy: LogPrivacy = .auto,
               source: @autoclosure () -> String? = nil,
               file: String = #file,
               function: String = #function,
               line: UInt = #line) {
        log(.trace, message(), privacy, metadata: metadata(), file: file, function: function, line: Int(line))
    }
    
    func debug(_ message: @autoclosure () -> String,
               metadata: @autoclosure () -> [String: Any]? = nil,
               privacy: LogPrivacy = .auto,
               source: @autoclosure () -> String? = nil,
               file: String = #file,
               function: String = #function,
               line: UInt = #line) {
        log(.debug, message(), privacy, metadata: metadata(), file: file, function: function, line: Int(line))
    }
    
    func info(_ message: @autoclosure () -> String,
              metadata: @autoclosure () -> [String: Any]? = nil,
              privacy: LogPrivacy = .auto,
              source: @autoclosure () -> String? = nil,
              file: String = #file,
              function: String = #function,
              line: UInt = #line) {
        log(.info, message(), privacy, metadata: metadata(), file: file, function: function, line: Int(line))
    }
    
    func notice(_ message: @autoclosure () -> String,
                metadata: @autoclosure () -> [String: Any]? = nil,
                privacy: LogPrivacy = .auto,
                source: @autoclosure () -> String? = nil,
                file: String = #file,
                function: String = #function,
                line: UInt = #line) {
        log(.notice, message(), privacy, metadata: metadata(), file: file, function: function, line: Int(line))
    }
    
    func warning(_ message: @autoclosure () -> String,
                 metadata: @autoclosure () -> [String: Any]? = nil,
                 privacy: LogPrivacy = .auto,
                 source: @autoclosure () -> String? = nil,
                 file: String = #file,
                 function: String = #function,
                 line: UInt = #line) {
        log(.warning, message(), privacy, metadata: metadata(), file: file, function: function, line: Int(line))
    }
    
    func error(_ message: @autoclosure () -> String,
               metadata: @autoclosure () -> [String: Any]? = nil,
               privacy: LogPrivacy = .auto,
               source: @autoclosure () -> String? = nil,
               file: String = #file,
               function: String = #function,
               line: UInt = #line) {
        log(.error, message(), privacy, metadata: metadata(), file: file, function: function, line: Int(line))
    }
    
    func critical(_ message: @autoclosure () -> String,
                  metadata: @autoclosure () -> [String: Any]? = nil,
                  privacy: LogPrivacy = .auto,
                  source: @autoclosure () -> String? = nil,
                  file: String = #file,
                  function: String = #function,
                  line: UInt = #line) {
        log(.critical, message(), privacy, metadata: metadata(), file: file, function: function, line: Int(line))
    }
}
