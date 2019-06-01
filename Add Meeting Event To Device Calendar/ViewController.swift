//
//  ViewController.swift
//  Add Meeting Event To Device Calendar
//
//  Created by Pawan kumar on 15/05/19.
//  Copyright © 2019 Pawan Kumar. All rights reserved.
//

import UIKit
import EventKit

class ViewController: UIViewController {

    let store = EKEventStore()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let eventStartDate: Date = Date.init()
        let eventEndDate: Date = Date.init() + 1
        
        createEventinTheCalendar(with: "Cab Time", forDate: eventStartDate, toDate: eventEndDate)
        
    }

    func createEventinTheCalendar(with title:String, forDate eventStartDate:Date, toDate eventEndDate:Date) {
        
        store.requestAccess(to: .event) { (success, error) in
            if  error == nil {
                let event = EKEvent.init(eventStore: self.store)
                event.title = title
                event.calendar = self.store.defaultCalendarForNewEvents // this will return deafult calendar from device calendars
                event.startDate = eventStartDate
                event.endDate = eventEndDate
                
                let alarm = EKAlarm.init(absoluteDate: Date.init(timeInterval: -3600, since: event.startDate))
                event.addAlarm(alarm)
                
                do {
                    try self.store.save(event, span: .thisEvent)
                    //event created successfullt to default calendar
                } catch let error as NSError {
                    print("failed to save event with error : \(error)")
                }
                
            } else {
                //we have error in getting access to device calnedar
                print("error = \(String(describing: error?.localizedDescription))")
            }
        }
    }
}

