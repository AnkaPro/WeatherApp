
import Foundation
import UIKit

class CurrentGeoTableViewCellViewModel {
    
    let dateLabelText = Bindable<String?>(nil)
    let degreeLabelText = Bindable<String?>(nil)
    let weatherLabelText = Bindable<String?>(nil)
    let weatherIconImage = Bindable<UIImage?>(nil)
    let dateFormatter = DateFormatter()
    
    func configure(config: CollectionCellConfigure) {
        dateFormatter.locale = Locale(identifier: "en_US")
        dateFormatter.dateFormat = "EEE, MMMM d"
        let dateInterval = Date(timeIntervalSince1970: TimeInterval(config.date ?? 0))
        let date = dateFormatter.string(from: dateInterval)
        
        self.dateLabelText.value = date
        if let temp = config.temperature {
        self.degreeLabelText.value = String(temp)
        }
        self.weatherLabelText.value = config.main
        switch config.main {
        case "Clear": self.weatherIconImage.value = UIImage(named: "Clear")
        case "Snow": self.weatherIconImage.value = UIImage(named: "Snow")
        case "Rain": self.weatherIconImage.value = UIImage(named: "Rain")
        case "Clouds": self.weatherIconImage.value = UIImage(named: "Clouds")
        default: self.weatherIconImage.value = UIImage(named: "Clear")
        }
    }
    
}
