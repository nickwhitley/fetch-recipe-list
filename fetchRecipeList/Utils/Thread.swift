import Foundation

extension Thread {
    private static let threadPattern: NSRegularExpression = try! NSRegularExpression(pattern: "number = (\\d+)", options: [])
    
    var info: String {
        let threadNumber = Thread.parseThreadNumber(from: self.description)
        
        if self.isMainThread {
            return "main (\(threadNumber))"
        } else {
            return "background (\(threadNumber))"
        }
    }
    
    private static func parseThreadNumber(from threadDescription: String) -> String {
        let nsString = threadDescription as NSString
        let matches = threadPattern.matches(in: threadDescription, options: [], range: NSRange(location: 0, length: nsString.length))
        
        if let match = matches.first, match.numberOfRanges > 1 {
            return nsString.substring(with: match.range(at: 1))
        }
        
        return "unknown"
    }
}
