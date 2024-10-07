//
//  File.swift
//  
//
//  Created by xpwu on 2024/10/7.
//

import Foundation


public struct MatchResult {
	public let result: NSTextCheckingResult
	public let text: String
}

public extension NSRegularExpression {
	func matches(_ string: String) -> [MatchResult] {
		return matches(in: string, range: NSRange(string.startIndex..., in: string)).map {
			MatchResult(result: $0, text: string)
		}
	}
	
	func numberOfMatches(_ string: String)-> Int {
		return numberOfMatches(in: string, range: NSRange(string.startIndex..., in: string))
	}
	
	func firstMatch(_ string: String) -> MatchResult? {
		if let result =  firstMatch(in: string, range: NSRange(string.startIndex..., in: string)) {
			return MatchResult(result: result, text: string)
		}
		return nil
	}
	
	func rangeOfFirstMatch(_ string: String) -> NSRange {
		return rangeOfFirstMatch(in: string, range: NSRange(string.startIndex..., in: string))
	}
}

public extension MatchResult {
	func string(at index:Int)->String {
		guard let rang = Range(self.result.range(at: index), in: self.text) else {
			return ""
		}
		return String(self.text[rang])
	}
	
	public var count: Int { get{ self.result.numberOfRanges } }
}


