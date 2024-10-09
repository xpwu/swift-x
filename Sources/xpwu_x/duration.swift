//
//  Duration.swift
//  stream
//
//  Created by xpwu on 2021/3/24.
//

import Foundation

public typealias Duration = UInt64

public extension Duration {
  static let Microsecond:UInt64 = 1
  static let Millisecond = 1000 * Microsecond
  static let Second = 1000 * Millisecond
  static let Minute = 60 * Second
  static let Hour = 60 * Minute
}

public extension Duration {
	static let INFINITE = UInt64.max
}

public extension Duration {
	func microSecond() -> UInt64 {
		return self/Duration.Microsecond
	}
	func milliSecond() -> UInt64 {
		return self/Duration.Millisecond
	}
  func second() -> UInt64 {
    return self/Duration.Second
  }
  func minute() -> UInt64 {
    return self/Duration.Minute
  }
	func hour() -> UInt64 {
		return self/Duration.Hour
	}
	func timeInterval() -> TimeInterval {
		return TimeInterval(self.second())
	}
}

// UInt64 已经实现了 CustomStringConvertible::description
// 所以无法通过 CustomStringConvertible::description 实现 Duration 的输出
public extension Duration {
	var toString: String {
		get {
			var ret = ""
			var left = self
			
			var v = left.hour()
			if v != 0 {
				ret += "\(v)h"
				left -= v * .Hour
			}
			v = left.minute()
			if v != 0 {
				ret += "\(v)min"
				left -= v * .Minute
			}
			v = left.second()
			if v != 0 {
				ret += "\(v)s"
				left -= v * .Second
			}
			v = left.milliSecond()
			if v != 0 {
				ret += "\(v)ms"
				left -= v * .Millisecond
			}
			v = left.microSecond()
			if v != 0 {
				ret += "\(v)us"
			}
			
			if ret.isEmpty {
				ret = "0us"
			}
			
			return ret
		}
	}
	
	static func from(string: String)-> Duration? {
		if string.isEmpty {
			return nil
		}
		
		guard let regex = try? NSRegularExpression(
			pattern: "^(([0-9]+)h)?(([0-9]+)min)?(([0-9]+)s)?(([0-9]+)ms)?(([0-9]+)us)?$"
			, options: .caseInsensitive) else {
			return nil
		}
		
		let results = regex.matches(in: string, range: NSRange(string.startIndex..., in: string))
		
		if results.isEmpty {
			return nil
		}
		
		let res = results[0]
		if res.numberOfRanges < 2*1 + 1 || res.numberOfRanges > 5*2+1 {
			return nil
		}
		
		let units = [Duration.Hour, Duration.Minute, Duration.Second, Duration.Millisecond, Duration.Microsecond]
		var ret: UInt64 = 0
		
		for i in 1 ... (res.numberOfRanges-1)/2 {
			// (([1-9][0-9]*)h)
			if res.range(at: i*2-1).location == NSNotFound {
				continue
			}
			// ([1-9][0-9]*)
			let match = String(string[Range(res.range(at: i*2), in: string)!])
			
			ret += UInt64(match)! * units[i-1]
		}
		
		return ret
	}
}
