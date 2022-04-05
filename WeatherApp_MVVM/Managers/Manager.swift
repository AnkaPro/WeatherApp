
import Foundation

class Manager {
    
    var latitude = String()
    var longtitude = String()
    static let shared = Manager()
    
    func sendRequest(currentOptions: @escaping (CurrentWeatherOptions) -> (), hourlyOptions: @escaping (HourlyWeatherOptions) -> (), weeklyOptions: @escaping (WeeklyWeatherOptions) -> ()) {
        
        guard let url = URL(string: "https://api.openweathermap.org/data/2.5/onecall?lat=55.775&lon=37.557&units=metric&appid=00056f33495bde97b7eea25630eec4a3") else { return }
        
        var request = URLRequest(url: url)
        request.allHTTPHeaderFields?["Content-Type"] = "application/json"
        request.httpMethod = "GET"
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if error == nil,
               let data = data {
                do {
                    if let json = try JSONSerialization.jsonObject(with: data, options: .mutableLeaves) as? [String: Any] {
                        let currentManager = CurrentWeatherOptions(temperature: nil, date: nil, main: nil, geo: nil)
                        guard let timezone = json["timezone"] as? String else { return }
                        guard let current = json["current"] as? [String: Any] else { return }
                        guard let temp = current["temp"] as? Double else { return }
                        guard let dt = current["dt"] as? Double else { return }
                        guard let weather = current["weather"] as? [Any] else { return }
                        for i in 0..<weather.count {
                            if let first = weather[i] as? [String: Any] {
                                guard let mainWeather = first["main"] as? String else { return }
                                currentManager.main = mainWeather
                            }
                        }
                        currentManager.geo = timezone
                        currentManager.date = dt
                        currentManager.temperature = String(Int(temp))
//                        completion(timezone)
//                        temperature(currentTemp)
//                        date(dt)
                        
                        guard let daily = json["daily"] as? [Any] else { return }
                        let weeklyManager = WeeklyWeatherOptions(temperature: [], date: [], main: [])
                        for i in 0..<daily.count {
                            
                            if let first = daily[i] as? [String: Any] {
                                guard let dt = first["dt"] as? Int else { return }
                                guard let tempFirst = first["temp"] as? [String: Any] else { return }
                                guard let tempDay = tempFirst["day"] as? Double else { return }
                                guard let weather = first["weather"] as? [Any] else { return }
                                
                                if let weatherFirst = weather.first as? [String: Any] {
                                    guard let main = weatherFirst["main"] as? String else { return }
                                    weeklyManager.main?.append(main)
//                                    weeklyManager.main.append(main)
                                }
                                weeklyManager.temperature?.append(Int(tempDay))
                                weeklyManager.date?.append(dt)
//                                weeklyManager.tempDay.append(Int(tempDay))
//                                weeklyManager.date.append(dt)
                            }
                        }
                        
                        guard let hourly = json["hourly"] as? [Any] else { return }
                        let hourlyManager = HourlyWeatherOptions(temperature: [], date: [], main: [])
                        for i in 0..<hourly.count {
                            if let first = hourly[i] as? [String: Any] {
                                guard let dt = first["dt"] as? Int else { return }
                                guard let temp = first["temp"] as? Double else { return }
                                guard let weather = first["weather"] as? [Any] else { return }
                                
                                if let weatherFirst = weather.first as? [String: Any] {
                                    guard let main = weatherFirst["main"] as? String else { return }
                                    hourlyManager.main?.append(main)
//                                    hourlyManager.main.append(main)
                                }
                                hourlyManager.temperature?.append(Int(temp))
                                hourlyManager.date?.append(dt)
//                                hourlyManager.temp.append(Int(temp))
//                                hourlyManager.date.append(dt)
                            }
                        }
                        currentOptions(currentManager)
                        weeklyOptions(weeklyManager)
                        hourlyOptions(hourlyManager)
                    }
                } catch let error {
                    print(error)
                }
            }
        }
        
        task.resume()
    }
}

