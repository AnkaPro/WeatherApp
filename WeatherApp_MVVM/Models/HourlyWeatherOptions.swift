
import Foundation

class HourlyWeatherOptions {
    
    var temperature: [Int]?
    var date: [Int]?
    var main: [String]?
    
    init(temperature: [Int]? = nil, date: [Int]? = nil, main: [String]? = nil) {
        self.temperature = temperature
        self.date = date
        self.main = main
    }
}
