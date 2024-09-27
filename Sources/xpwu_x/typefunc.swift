//
//  Created by xpwu on 2024/9/24.
//

import Foundation

public typealias Byte = UInt8

public extension Array where Element == Byte {
	func toData()->Data {
		self.withUnsafeBytes {
			Data($0)
		}
	}
}

public extension Data {
	func toBytes()->[Byte] {
		return self.withUnsafeBytes {
			Array($0)
		}
	}
}

public func UniqFlag()-> String {
	return String(UInt32.random(in: 0x10000000..<UInt32.max), radix: 16)
}
