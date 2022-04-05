
import UIKit
import CoreLocation

enum Weather: String {
    case Clear
    case Clouds
    case Rain
    case Snow
}

class CurrentGeoViewController: UIViewController, CLLocationManagerDelegate {
    
    let viewModel = CurrentGeoViewModel()
    let topView = UIView()
    let hourlyCollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout.init())
    let weeklyTableView = UITableView()
    let geoLabel = UILabel()
    let degreelabel = UILabel()
    var celsiusIcon = UIImageView()
    var weatherIcon = UIImageView()
    var geoIcon = UIImageView()
    var dateLabel = UILabel()
    var weatherLabel = UILabel()
    var tableViewLabel = UILabel()
    let searchButton = UIButton()
    let currentGeoButton = UIButton()
    let locationManager = CLLocationManager()
    let tabelViewCellId = "tabelViewCellId"
    let collectionViewCellId = "collectionViewCellId"
    let dateFormatter = DateFormatter()
    let spinner = UIActivityIndicatorView()
    var weather = Weather(rawValue: "Clear")
    let searchViewController = SearchViewController()
    
    lazy var animatableWeatherIconConstraints = {
        return (square: weatherIcon.widthAnchor.constraint(equalTo: topView.widthAnchor, multiplier: 1/6),
                rectangle: weatherIcon.widthAnchor.constraint(equalTo: topView.widthAnchor, multiplier: 1/4))
    }()
    
   
    override func viewDidLoad() {
        super.viewDidLoad()
        self.spinnerActivate()
        self.view.backgroundColor = .white
        self.setupView()
        self.weeklyTableView.delegate = self
        self.weeklyTableView.dataSource = self
        self.weeklyTableView.register(CurrentGeoTableViewCell.self, forCellReuseIdentifier: tabelViewCellId)
        self.hourlyCollectionView.delegate = self
        self.hourlyCollectionView.dataSource = self
        self.hourlyCollectionView.register(CurrentGeoCollectionViewCell.self, forCellWithReuseIdentifier: collectionViewCellId)
        viewModel.sendRequest()
        self.bind()
        
        searchButton.addAction(UIAction(handler: { _ in
            self.present(self.searchViewController, animated: true)
        }), for: .touchUpInside)
        
        dateFormatter.locale = Locale(identifier: "en_US")
        dateFormatter.dateFormat = "EEE, MMMM d"
    }
    
    
    func setupView() {
        self.view.addSubview(topView)
        topView.translatesAutoresizingMaskIntoConstraints = false
        weeklyTableView.rowHeight = 80
        weeklyTableView.backgroundColor = .white
        weeklyTableView.alpha = 0.6
        weeklyTableView.layer.cornerRadius = 15
        self.view.addSubview(weeklyTableView)
        weeklyTableView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(hourlyCollectionView)
        hourlyCollectionView.translatesAutoresizingMaskIntoConstraints = false
        hourlyCollectionView.backgroundColor = .white
        hourlyCollectionView.alpha = 0.6
        hourlyCollectionView.layer.cornerRadius = 15
        if let flowLayout = hourlyCollectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            flowLayout.scrollDirection = .horizontal
        }
        
        geoIcon = UIImageView(image: UIImage(named: "Frame"))
        geoIcon.sizeToFit()
        geoLabel.font = UIFont(name: "Inter-ExtraLight", size: 25)
        geoLabel.textAlignment = .left
        geoLabel.textColor = .white
//        geoLabel.text = "Moscow"
        
        weatherIcon.sizeToFit()
        weatherIcon.image = UIImage(named: "sun")
        
        degreelabel.font = UIFont(name: "Inter", size: 100)
        degreelabel.textAlignment = .left
        degreelabel.textColor = .white
//        degreelabel.text = "7"
        
        celsiusIcon = UIImageView(image: UIImage(named: "celsius white"))
        celsiusIcon.sizeToFit()
        
        dateLabel.font = UIFont(name: "Inter-ExtraLight", size: 20)
        dateLabel.textAlignment = .left
        dateLabel.textColor = .white
//        dateLabel.text = "Mon, 20 March"
        
        weatherLabel.font = UIFont(name: "Inter-ExtraLight", size: 23)
        weatherLabel.textAlignment = .left
        weatherLabel.textColor = .white
//        weatherLabel.text = "Cloudy"
        
        searchButton.setImage(UIImage(systemName: "magnifyingglass")?.withTintColor(.white, renderingMode: .alwaysOriginal), for: .normal)
        currentGeoButton.setImage(UIImage(systemName: "location.circle.fill")?.withTintColor(.white, renderingMode: .alwaysOriginal), for: .normal)
        
        NSLayoutConstraint.activate([
            topView.topAnchor.constraint(equalTo: self.view.topAnchor),
            topView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            topView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            topView.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 1/3),
            
            weeklyTableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 10),
            weeklyTableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -10),
            weeklyTableView.topAnchor.constraint(equalTo: hourlyCollectionView.bottomAnchor, constant: 10),
            weeklyTableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -10),
            
            hourlyCollectionView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 10),
            hourlyCollectionView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -10),
            hourlyCollectionView.topAnchor.constraint(equalTo: topView.bottomAnchor, constant: 20),
            hourlyCollectionView.heightAnchor.constraint(equalToConstant: 150),
            
            
        ])
        
        topView.addSubview(geoIcon)
        geoIcon.translatesAutoresizingMaskIntoConstraints = false
        topView.addSubview(geoLabel)
        geoLabel.translatesAutoresizingMaskIntoConstraints = false
        topView.addSubview(weatherIcon)
        weatherIcon.translatesAutoresizingMaskIntoConstraints = false
        topView.addSubview(degreelabel)
        degreelabel.translatesAutoresizingMaskIntoConstraints = false
        topView.addSubview(celsiusIcon)
        celsiusIcon.translatesAutoresizingMaskIntoConstraints = false
        topView.addSubview(dateLabel)
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        topView.addSubview(searchButton)
        searchButton.translatesAutoresizingMaskIntoConstraints = false
        topView.addSubview(currentGeoButton)
        currentGeoButton.translatesAutoresizingMaskIntoConstraints = false
            
        NSLayoutConstraint.activate([
            degreelabel.topAnchor.constraint(equalTo: topView.topAnchor, constant: 85),
            degreelabel.leadingAnchor.constraint(equalTo: topView.leadingAnchor, constant: 40),
            

            geoLabel.topAnchor.constraint(equalTo: geoIcon.topAnchor),
            geoLabel.leadingAnchor.constraint(equalTo: geoIcon.trailingAnchor, constant: 20),

            geoIcon.topAnchor.constraint(equalTo: degreelabel.bottomAnchor, constant: 10),
            geoIcon.leadingAnchor.constraint(equalTo: topView.leadingAnchor, constant: 40),
            geoIcon.heightAnchor.constraint(equalToConstant: 20),
            geoIcon.widthAnchor.constraint(equalToConstant: 20),
            
            weatherIcon.centerYAnchor.constraint(equalTo: degreelabel.centerYAnchor),
            weatherIcon.leadingAnchor.constraint(equalTo: degreelabel.trailingAnchor, constant: 50),
            weatherIcon.heightAnchor.constraint(equalTo: topView.heightAnchor, multiplier: 1/4),

            celsiusIcon.topAnchor.constraint(equalTo: degreelabel.topAnchor),
            celsiusIcon.leadingAnchor.constraint(equalTo: degreelabel.trailingAnchor, constant: 20),
            celsiusIcon.widthAnchor.constraint(equalToConstant: 20),
            celsiusIcon.heightAnchor.constraint(equalToConstant: 30),
            
            dateLabel.leadingAnchor.constraint(equalTo: geoIcon.leadingAnchor),
            dateLabel.topAnchor.constraint(equalTo: geoLabel.bottomAnchor, constant: 10),
            dateLabel.widthAnchor.constraint(equalTo: topView.widthAnchor, multiplier: 1/2),
            dateLabel.heightAnchor.constraint(equalTo: topView.heightAnchor, multiplier: 1/7),
            
            searchButton.topAnchor.constraint(equalTo: topView.topAnchor, constant: 70),
            searchButton.trailingAnchor.constraint(equalTo: topView.trailingAnchor, constant: -20),
            
            currentGeoButton.topAnchor.constraint(equalTo: searchButton.topAnchor),
            currentGeoButton.leadingAnchor.constraint(equalTo: topView.leadingAnchor, constant: 20)
        ])
    }
    
    func setupGradient(weather: Weather) {
        let gradient = CAGradientLayer()
        gradient.frame = self.view.bounds
        self.view.layer.insertSublayer(gradient, at: 0)
        
        switch weather {
        case .Clear:
            gradient.colors = [#colorLiteral(red: 0.782977581, green: 0.5219194889, blue: 0.6528584361, alpha: 1).cgColor, #colorLiteral(red: 0.437513113, green: 0.3495872617, blue: 0.5295580029, alpha: 1).cgColor]
        case .Clouds:
            gradient.colors = [#colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1).cgColor, #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1).cgColor]
        case .Rain:
            gradient.colors = [#colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1).cgColor, #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1).cgColor]
        case .Snow:
            gradient.colors = [#colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1).cgColor, #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1).cgColor]
        }
    }
    
    func bind() {
        self.viewModel.currentOptions.bind { [weak self] currentOptions in
            guard let currentDate = currentOptions.date else { return }
            let dateInterval = Date(timeIntervalSince1970: currentDate)
            let date = self?.dateFormatter.string(from: dateInterval)
            DispatchQueue.main.async {
                self?.spinnerDeactivate()
                self?.geoLabel.text = currentOptions.geo
                self?.degreelabel.text = currentOptions.temperature
                self?.dateLabel.text = date
                guard let main = currentOptions.main else { return }
                self?.weatherIcon.image = UIImage(named: (main))
                if main == "Clouds" {
                    self?.setupGradient(weather: Weather.Clouds)
                    self?.animatableWeatherIconConstraints.rectangle.isActive = true
                } else if main == "Rain" {
                    self?.setupGradient(weather: Weather.Rain)
                    self?.animatableWeatherIconConstraints.rectangle.isActive = true
                } else if main == "Clear" {
                    self?.setupGradient(weather: Weather.Clear)
                    self?.animatableWeatherIconConstraints.square.isActive = true
                } else if main == "Snow" {
                    self?.setupGradient(weather: Weather.Snow)
                    self?.animatableWeatherIconConstraints.square.isActive = true
                }
            }
        }
        
        self.viewModel.weeklyOptions.bind { [weak self] weeklyOptions in
            DispatchQueue.main.async {
                self?.weeklyTableView.reloadData()
            }
        }
        
        self.viewModel.hourlyOptions.bind { [weak self] _ in
            DispatchQueue.main.async {
                self?.hourlyCollectionView.reloadData()
            }
        }
    }
    
    func spinnerActivate() {
        self.view.addSubview(spinner)
        spinner.translatesAutoresizingMaskIntoConstraints = false
        spinner.startAnimating()
        spinner.color = .black
        spinner.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        spinner.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
    }
    
    func spinnerDeactivate() {
        self.spinner.stopAnimating()
        self.spinner.isHidden = true
    }
}



