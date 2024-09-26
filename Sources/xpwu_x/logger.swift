//
//  Created by xpwu on 2024/9/24.
//

import Foundation

public enum LoggerType: String {
	case Debug, Info, Warning, Error
}

public protocol Logger {
	func OutPut(type: LoggerType, tag: ()->String, msg: ()->String, file: String, line: Int)
}

public extension Logger {
	func Debug(_ tag: @autoclosure()->String, _ msg: @autoclosure()->String, _ file: String = #fileID, _ line: Int = #line) {
		self.OutPut(type: .Debug, tag: tag, msg: msg, file: file, line: line)
	}
	
	func Info(_ tag: @autoclosure()->String, _ msg: @autoclosure()->String, _ file: String = #fileID, _ line: Int = #line) {
		self.OutPut(type: .Info, tag: tag, msg: msg, file: file, line: line)
	}
	
	func Warning(_ tag: @autoclosure()->String, _ msg: @autoclosure()->String, _ file: String = #fileID, _ line: Int = #line) {
		self.OutPut(type: .Warning, tag: tag, msg: msg, file: file, line: line)
	}
	
	func Error(_ tag: @autoclosure()->String, _ msg: @autoclosure()->String, _ file: String = #fileID, _ line: Int = #line) {
		self.OutPut(type: .Error, tag: tag, msg: msg, file: file, line: line)
	}
}


public struct PrintLogger {}

extension PrintLogger: Logger {
	public func OutPut(type: LoggerType, tag: ()->String, msg: ()->String, file: String, line: Int) {
		let options: ISO8601DateFormatter.Options = [.withInternetDateTime, .withDashSeparatorInDate, .withColonSeparatorInTime, .withTimeZone, .withFractionalSeconds]
		let time = ISO8601DateFormatter.string(from: Date(), timeZone: .current, formatOptions: options)
		
		var index = file.startIndex
		if let x = file.lastIndex(of: "/") {
			index = file.index(after: x)
		}
		let fileLine = "\(file[index...]):\(line)"
		
		print("\(time) \(fileLine) \(type): \(tag())  --->  \(msg())")
	}
}

