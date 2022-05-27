
import Foundation
import UIKit

class SearchViewModel {
    
    let jsonParsing = JSONCitiesParse()
    let manager = Manager()
    var filterredData = Bindable<[String]?>(nil)
    var initJSONCityArray = Bindable<[String]?>(nil)
    var initJSONLatArray = Bindable<[Double]?>(nil)
    var initJSONLonArray = Bindable<[Double]?>(nil)
    
    func sendDataToTableView() {
        jsonParsing.jsonCitiesParse()
        filterredData.value = jsonParsing.arrayCitiesEn
        initJSONCityArray.value = self.jsonParsing.arrayCitiesEn
        initJSONLatArray.value = self.jsonParsing.latitude
        initJSONLonArray.value = self.jsonParsing.longtitude
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
        guard let cityName = self.filterredData.value?[indexPath.row] else { return }
        guard let indexOfSearchCity = self.initJSONCityArray.value?.firstIndex(of: cityName) else { return }
        guard let latutideOfSearchCity = self.initJSONLatArray.value?[indexOfSearchCity] else { return }
        guard let longtitudeOfSearchCity = self.initJSONLonArray.value?[indexOfSearchCity] else { return }
        manager.latitude = String(latutideOfSearchCity)
        manager.longtitude = String(longtitudeOfSearchCity)
        Manager.shared.latitude = String(latutideOfSearchCity)
        Manager.shared.longtitude = String(longtitudeOfSearchCity)
    }
    
    func filterData(searchText: String, tableView: UITableView) {
        self.filterredData.value = []
        
        if searchText.isEmpty {
            self.filterredData.value = self.initJSONCityArray.value
        } else {
            self.filterredData.value = self.initJSONCityArray.value?.filter { $0.contains(searchText)}
        }
        guard let newFilteredData = self.filterredData.value else { return }
        self.jsonParsing.arrayCitiesEn = newFilteredData
        tableView.reloadData()
    }
    
    
}


