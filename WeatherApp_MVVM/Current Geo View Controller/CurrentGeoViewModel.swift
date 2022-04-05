
import Foundation
import CoreLocation

class CurrentGeoViewModel: NSObject, CLLocationManagerDelegate {
    
    let locationManager = CLLocationManager()
    var currentOptions = Bindable<CurrentWeatherOptions>(CurrentWeatherOptions(temperature: nil, date: nil, main: nil, geo: nil))
    var hourlyOptions = Bindable<HourlyWeatherOptions>(HourlyWeatherOptions(temperature: nil, date: nil, main: nil))
    var weeklyOptions = Bindable<WeeklyWeatherOptions>(WeeklyWeatherOptions(temperature: nil, date: nil, main: nil))

    
    
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
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = manager.location?.coordinate else { return }
        Manager.shared.latitude = String(location.latitude)
        Manager.shared.longtitude = String(location.longitude)
        print(location)
    }
    
}

