//
//  ViewModel.swift
//  test parser
//
//  Created by Mathieu Janneau on 20/06/2018.
//  Copyright © 2018 Mathieu Janneau. All rights reserved.
//

import Foundation


class ViewModel: NSObject {
  
  func getRSSFeed(completion: @escaping(([Sport]) -> Void)){
    let feeder = BetclicParser()
    var tempData = [Sport]()
  
    feeder.fetchData(completionHandler: { (result) in
        tempData = result
      completion(tempData)
      })
    
    
    
  }
  
}

