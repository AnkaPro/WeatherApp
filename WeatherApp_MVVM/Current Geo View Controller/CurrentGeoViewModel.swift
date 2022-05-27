
import Foundation
import CoreLocation

class CurrentGeoViewModel: NSObject, CLLocationManagerDelegate {
    
    let locationManager = CLLocationManager()
    var currentOptions = Bindable<CurrentWeatherOptions>(CurrentWeatherOptions(temperature: nil, date: nil, main: nil, geo: nil))
    var hourlyOptions = Bindable<HourlyWeatherOptions>(HourlyWeatherOptions(temperature: nil, date: nil, main: nil))
    var weeklyOptions = Bindable<WeeklyWeatherOptions>(WeeklyWeatherOptions(temperature: nil, date: nil, main: nil))
    var textForGeoLabel = Bindable<String?>(nil)
    
    func sendRequest() {
        Manager.shared.sendRequest { [weak self] options in
            self?.currentOptions.value = options
        } hourlyOptions: { [weak self] options in
            self?.hourlyOptions.value = options
        } weeklyOptions: { [weak self] options in
            self?.weeklyOptions.value = options
        }
    }
    
    func location() {
        locationManager.desiredAccuracy = kCLLocationAccuracyBestForNavigation
        locationManager.delegate = self
        locationManager.requestAlwaysAuthorization()
        locationManager.startUpdatingLocation()
        guard let location = locationManager.location?.coordinate else { return }
        Manager.shared.latitude = String(location.latitude)
        Manager.shared.longtitude = String(location.longitude)
        print(Manager.shared.latitude)
        nameOfCurrentCity()
    }
    
    func nameOfCurrentCity() {
        let latitude = Double(Manager.shared.latitude) ?? 0
        let longtitude = Double(Manager.shared.longtitude) ?? 0
        let location = CLLocation(latitude: latitude, longitude: longtitude)
        location.fetchCityAndCountry { city, country, error in
            self.textForGeoLabel.value = city
        }
    }
}




extension CLLocation {
    func fetchCityAndCountry(completion: @escaping (_ city: String?, _ country:  String?, _ error: Error?) -> ()) {
        CLGeocoder().reverseGeocodeLocation(self) { completion($0?.first?.locality, $0?.first?.country, $1) }
    }
}

