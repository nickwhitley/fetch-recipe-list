import Foundation
import OSLog

class BasicLogger<Source>: Logger {
    private let logger: OSLog
    private let sourceName: String
    
    init() {
        let sourceName = String(describing: Source.self)
        self.sourceName = sourceName
        self.logger = OSLog(subsystem: Bundle.main.bundleIdentifier ?? "fetch-recipes", category: "BasicLogger")
    }
    
    func info(_ message: String) {
        write(message, type: .info)
    }
    
    func error(_ message: String) {
        write(message, type: .error)
    }
    
    func debug(_ message: String) {
        write(message, type: .debug)
    }
    
    private func write(_ message: String, type: OSLogType) {
        let timestamp = Date().ISO8601Format()
        let threadInfo = Thread.current.info
        os_log("[%{public}@] [%{public}@] [Thread: %{public}@] %{public}@", log: logger, type: type, sourceName, timestamp, threadInfo, message)
    }
}

protocol Logger {
    func info(_ message: String)
    func error(_ message: String)
    func debug(_ message: String)
}
