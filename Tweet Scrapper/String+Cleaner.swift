//
//  String+Cleaner.swift
//  Tweet Scrapper
//
//  Created by Rahardyan Bisma Setya Putra on 02/05/19.
//  Copyright © 2019 Rahardyan Bisma Setya Putra. All rights reserved.
//

import Foundation

extension String {
    
    var emojilessStringWithSubstitution: String {
        let emojiPatterns = [UnicodeScalar(0x1F601)!...UnicodeScalar(0x1F64F)!, UnicodeScalar(0x2702)!...UnicodeScalar(0x27B0)!]
        return self.unicodeScalars
            .filter { ucScalar in !(emojiPatterns.contains{ $0 ~= ucScalar }) }
            .reduce("") { $0 + String($1) }
    }
    
    var removingUrl: String {
        guard let detector = try? NSDataDetector(types: NSTextCheckingResult.CheckingType.link.rawValue) else {
            return self
        }
        return detector.stringByReplacingMatches(in: self,
                                                 options: [],
                                                 range: NSRange(location: 0, length: self.utf16.count),
                                                 withTemplate: "")
    }
    
    var removeSymbol: String {
        let dotRemoved = self.replacingOccurrences(of: ".", with: "")
        let slashRemoved = dotRemoved.replacingOccurrences(of: "\\", with: "")
        let backSlashRemoved = slashRemoved.replacingOccurrences(of: "/", with: "")
        let quotesRemoved = backSlashRemoved.replacingOccurrences(of: "\"", with: "")
        let doubleDotRemoved = quotesRemoved.replacingOccurrences(of: ":", with: "")
        let commaRemoved = doubleDotRemoved.replacingOccurrences(of: ",", with: "")
        
        return commaRemoved
    }
}
