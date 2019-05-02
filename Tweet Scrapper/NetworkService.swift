//
//  NetworkService.swift
//  Tweet Scrapper
//
//  Created by Rahardyan Bisma Setya Putra on 02/05/19.
//  Copyright © 2019 Rahardyan Bisma Setya Putra. All rights reserved.
//

import Foundation
import Alamofire

class NetworkService {
    public static let instance = NetworkService()
    
    func getTwitFrom(displayName: [String]) {
        var twit: [String] = []
        let headers = [
            "Authorization": "Bearer AAAAAAAAAAAAAAAAAAAAALxC%2BQAAAAAAmz7zxFumbmFgxg7MnrQH5Yh%2Ftn4%3DWFccfgStwE68GqT0uL1qbhsef7x64MvZ8XqJajAl3TIAZNMLCj",
        ]
        
        
        let params = [
            "screen_name": displayName[0],
            "count": "100"
        ]
        Alamofire.request(URL(string: "https://api.twitter.com/1.1/statuses/user_timeline.json?")!, method: .get, parameters: params, headers: headers).responseJSON { (response) in
            
            if let results = response.result.value as? [[String: Any]] {
                for result in results {
                    guard let text = result["text"] as? String else { return }
                    twit.append(text.emojilessStringWithSubstitution.removingUrl.removeSymbol)
                }
                
                print("result \(twit)")
            }
            
            
        }
    }
}
