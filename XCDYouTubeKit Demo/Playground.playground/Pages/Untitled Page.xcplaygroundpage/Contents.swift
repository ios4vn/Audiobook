import XCDYouTubeKit
#if swift(>=3.0)
	import PlaygroundSupport
	struct YouTubeVideoQuality {
		static let hd720 = NSNumber(value: XCDYouTubeVideoQuality.HD720.rawValue)
		static let medium360 = NSNumber(value: XCDYouTubeVideoQuality.medium360.rawValue)
		static let small240 = NSNumber(value: XCDYouTubeVideoQuality.small240.rawValue)
	}
#else
	import XCPlayground
	typealias Error = NSError
	struct YouTubeVideoQuality {
		static let hd720 = NSNumber(unsignedLong: XCDYouTubeVideoQuality.HD720.rawValue)
		static let medium360 = NSNumber(unsignedLong: XCDYouTubeVideoQuality.Medium360.rawValue)
		static let small240 = NSNumber(unsignedLong: XCDYouTubeVideoQuality.Small240.rawValue)
	}
#endif

setenv("XCDYouTubeKitLogLevel", "0", 1)



client.getVideoWithIdentifier("xxxxxxxxxxx") { (video: XCDYouTubeVideo?, error: Error?) -> Void in
	video
	error?.localizedDescription
}

#if swift(>=3.0)
	PlaygroundPage.current.needsIndefiniteExecution = true
#else
	XCPlaygroundPage.currentPage.needsIndefiniteExecution = true
#endif
