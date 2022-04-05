
import Foundation

class CurrentWeatherOptions {
   
    var temperature: String?
    var date: Double?
    var main: String?
    var geo: String?
    
    init(temperature: String? = nil, date: Double? = nil, main: String? = nil, geo: String? = nil) {
        self.temperature = temperature
        self.date = date
        self.main = main
        self.geo = geo
    }
    
}
