
import Foundation

class JSONCitiesParse {
    
    var arrayCitiesEn = [String]()
    var latitude = [Double]()
    var longtitude = [Double]()
    
    func jsonCitiesParse() {
        guard let path = Bundle.main.path(forResource: "CityJsonData", ofType: "json") else { return }
        
        do {
            let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
            let jsonSerilization = try JSONSerialization.jsonObject(with: data, options: .mutableLeaves)
            
            if let json = jsonSerilization as? [Any] {
                for i in 0..<json.count {
                    if let first = json[i] as? [String: Any] {
                        guard let cityEn = first["city_en"] as? String else { return }
                        guard let lat = first["lat"] as? Double else { return }
                        guard let lng = first["lng"] as? Double else { return }
                    
                        arrayCitiesEn.append(cityEn)
                        latitude.append(lat)
                        longtitude.append(lng)
                    }
                }
            }
        } catch let error {
            print(error)
        }
    }
}
