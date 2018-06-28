//
//  RSSParser.swift
//  test parser
//
//  Created by Mathieu Janneau on 20/06/2018.
//  Copyright © 2018 Mathieu Janneau. All rights reserved.
//

import Foundation
import SwiftyXMLParser

enum Endpoints: String {
  case betclic = "http://xml.cdn.betclic.com/odds_fr.xml"
}

protocol RSSReader {
  associatedtype Result
  var endpoint: Endpoints { get }
  func fetchData(completionHandler: @escaping (([Sport]) -> Void))
  func map<Result>(_ data: XML.Accessor) -> Result?
}

extension RSSReader where Self: BetclicParser {
  typealias Result = [Sport]
  
  func map<Result>(_ data: XML.Accessor) -> Result? {
    
    let sports = data["sports", "sport"]
    var tempSports = [Sport]()
    for sport in sports {
      guard let sportName = sport.attributes["name"] else { return nil}
      let events = sport["event"]
      var tempEvents = [Event]()
      for event in events {
        guard let eventName = event.attributes["name"] else {return nil}
        let matchs = event["match"]
        var tempMatchs = [Match]()
        
        for match in matchs {
          let matchName = match.attributes["name"]!
          let matchDate = match.attributes["start_date"]!
          
          var tempBets = [Bet]()
          let bets = match["bets", "bet"]
          for bet in bets {
            // parse bet names
            guard let betName = bet.attributes["name"] else { return nil}
            // find choices data
            let choices = bet["choice"]
            // temporary stores for choices
            var tempChoices = [Choice]()
            
            // parse all choices
            for choice in choices {
              // parse attributes for name and odd
              guard let choiceName = choice.attributes["name"],
                let choiceOdd = choice.attributes["odd"] else { return nil}
              
              // Create choices and add them
              let newChoice = Choice(name: choiceName, odd: choiceOdd)
              tempChoices.append(newChoice)
            }
            
            // create bets and add them
            let newBet = Bet(name: betName, choices: tempChoices)
            tempBets.append(newBet)
          }
          
          // create matchs and add them
          let newMatch = Match(name: matchName, startDate: matchDate, bets: tempBets)
          tempMatchs.append(newMatch)
        }
        let newEvent = Event(title: eventName, match: tempMatchs)
        tempEvents.append(newEvent)
      }
      let newSport = Sport(title: sportName, events: tempEvents)
      tempSports.append(newSport)
      
    }
    print(tempSports.count)
    return tempSports as? Result
  }
}

class BetclicParser: NSObject, XMLParserDelegate, RSSReader {
 var endpoint: Endpoints = .betclic
  
  func fetchData(completionHandler: @escaping (([Sport]) -> Void)) {
    var tempData = [Sport]()
    let session = URLSession.shared
    guard let url = URL(string: endpoint.rawValue) else { return }
    let task = session.dataTask(with:url) { (data, response, error) in
      if error != nil {
        print(error!.localizedDescription)
      }
      
      guard let feed = data else { return}
      let xml = XML.parse(feed)
      
      tempData = self.map(xml)!
      completionHandler(tempData)
    }
    task.resume()
  }
  


  
}
