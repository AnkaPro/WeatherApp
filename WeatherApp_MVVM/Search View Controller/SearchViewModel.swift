
import Foundation

class SearchViewModel {
    
    let jsonParsing = JSONCitiesParse()
    let manager = Manager()
    var filterredData = [String]()
    var initJSONCityArray = [String]()
    var initJSONLatArray = [Double]()
    var initJSONLonArray = [Double]()
    
    func sendDataToTableView() {
        jsonParsing.jsonCitiesParse()
        filterredData = jsonParsing.arrayCitiesEn
        initJSONCityArray = self.jsonParsing.arrayCitiesEn
        initJSONLatArray = self.jsonParsing.latitude
        initJSONLonArray = self.jsonParsing.longtitude
    }
    
    func cityCoordinate(for indexPath: IndexPath) -> [Double] {
        var coordinate = [Double]()
        let latitude = self.jsonParsing.latitude[indexPath.row]
        let longtitude = self.jsonParsing.longtitude[indexPath.row]
        
        coordinate.append(latitude)
        coordinate.append(longtitude)
        return coordinate
    }
    
    func townWasSelect(indexPath: IndexPath) {
        let cityName = self.filterredData[indexPath.row]
        guard let indexOfSearchCity = self.initJSONCityArray.firstIndex(of: cityName) else { return }
        Manager.shared.latitude = String(self.initJSONLatArray[indexOfSearchCity])
        Manager.shared.longtitude = String(self.initJSONLonArray[indexOfSearchCity])
    }
    
}
