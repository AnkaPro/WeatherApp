
import Foundation
import UIKit

class CurrentGeoCollectionViewCellViewModel {
    
    var degreeLabelText = Bindable<String?>(nil)
    var hourLabelText = Bindable<String?>(nil)
    var weatherImage = Bindable<UIImage?>(nil)
    let dateFormatter = DateFormatter()
    
    func configure(config: CollectionCellConfigure) {
        dateFormatter.locale = Locale(identifier: "en_US")
        dateFormatter.dateFormat = "h a"
        let dateInterval = Date(timeIntervalSince1970: TimeInterval(config.date ?? 0))
        let date = dateFormatter.string(from: dateInterval)
        
        if let temp = config.temperature {
        self.degreeLabelText.value = String(temp)
        }
        self.hourLabelText.value = String(date)
        
        switch config.main {
        case "Clear": self.weatherImage.value = UIImage(named: "Clear")
        case "Snow": self.weatherImage.value = UIImage(named: "Snow")
        case "Rain": self.weatherImage.value = UIImage(named: "Rain")
        case "Clouds": self.weatherImage.value = UIImage(named: "Clouds")
        default: self.weatherImage.value = UIImage(named: "Clear")
        }
    }
}
