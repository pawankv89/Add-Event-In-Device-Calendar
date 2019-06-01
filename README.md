# Add Event In Device Calendar

=========

## Add Event In Device Calendar in Swift 5.

------------
Added Some screens here.

![](https://github.com/pawankv89/Add-Event-In-Device-Calendar/blob/master/images/screen_1.png)
![](https://github.com/pawankv89/Add-Event-In-Device-Calendar/blob/master/images/screen_2.png)

## Usage
------------

####  Transition Demo

```swift


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



```




## License

This code is distributed under the terms and conditions of the [MIT license](LICENSE).

## Change-log

A brief summary of each this release can be found in the [CHANGELOG](CHANGELOG.mdown). 
