
import UIKit
import CoreLocation

class CurrentGeoViewController: UIViewController {
    
    let viewModel = CurrentGeoViewModel()
    let topView = UIView()
    private lazy var hourlyCollectionView: UICollectionView = {
            let layout = UICollectionViewFlowLayout()
            layout.minimumInteritemSpacing = 5
            layout.scrollDirection = .horizontal
            let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = UIColor(red: 255.0, green: 255.0, blue: 255.0, alpha: 0.001)
        collectionView.layer.cornerRadius = 15
            return collectionView
        }()
    private var weeklyTableView: UITableView = {
        let tableView = UITableView()
        tableView.rowHeight = 80
        tableView.backgroundColor = .clear
        tableView.layer.cornerRadius = 15
        return tableView
    }()
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
    let tabelViewCellId = "tabelViewCellId"
    let collectionViewCellId = "collectionViewCellId"
    let dateFormatter = DateFormatter()
    let geoLabelNewCity = UILabel()
    let searchViewController = SearchViewController()
    
    override func loadView() {
        super.loadView()
        viewModel.location()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.weeklyTableView.delegate = self
        self.weeklyTableView.dataSource = self
        self.weeklyTableView.register(CurrentGeoTableViewCell.self, forCellReuseIdentifier: tabelViewCellId)
        self.hourlyCollectionView.delegate = self
        self.hourlyCollectionView.dataSource = self
        self.hourlyCollectionView.register(CurrentGeoCollectionViewCell.self, forCellWithReuseIdentifier: collectionViewCellId)
        viewModel.sendRequest()
        searchViewController.delegate = self
        self.bind()
        self.setupView()
        searchButton.addTarget(self, action: #selector(self.presentSearchVC), for: .touchUpInside)
        currentGeoButton.addTarget(self, action: #selector(self.currentGeoReturn), for: .touchUpInside)
        dateFormatter.locale = Locale(identifier: "en_US")
        dateFormatter.dateFormat = "EEE, MMMM d"
    }
    
    
    func setupView() {
        
        self.view.addSubview(topView)
        topView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(weeklyTableView)
        weeklyTableView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(hourlyCollectionView)
        hourlyCollectionView.translatesAutoresizingMaskIntoConstraints = false
        
        geoIcon = UIImageView(image: UIImage(named: "Frame"))
        geoIcon.sizeToFit()
        geoLabel.font = UIFont(name: "Inter-ExtraLight", size: 25)
        geoLabel.textAlignment = .left
        geoLabel.textColor = .white
        
        geoLabelNewCity.font = UIFont(name: "Inter-ExtraLight", size: 25)
        geoLabelNewCity.textAlignment = .left
        geoLabelNewCity.textColor = .white
        geoLabelNewCity.isHidden = true
        
        weatherIcon.contentMode = .scaleAspectFit
        weatherIcon.image = UIImage(named: "sun")
        
        degreelabel.font = UIFont(name: "Inter", size: 100)
        degreelabel.textAlignment = .left
        degreelabel.textColor = .white
        
        celsiusIcon = UIImageView(image: UIImage(named: "celsius white"))
        celsiusIcon.sizeToFit()
        
        dateLabel.font = UIFont(name: "Inter-ExtraLight", size: 20)
        dateLabel.textAlignment = .left
        dateLabel.textColor = .white
        
        weatherLabel.font = UIFont(name: "Inter-ExtraLight", size: 23)
        weatherLabel.textAlignment = .left
        weatherLabel.textColor = .white
        
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
            hourlyCollectionView.heightAnchor.constraint(equalToConstant: 150)
        ])
        
        topView.addSubview(geoIcon)
        geoIcon.translatesAutoresizingMaskIntoConstraints = false
        topView.addSubview(geoLabel)
        geoLabel.translatesAutoresizingMaskIntoConstraints = false
        topView.addSubview(geoLabelNewCity)
        geoLabelNewCity.translatesAutoresizingMaskIntoConstraints = false
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
            
            geoLabelNewCity.topAnchor.constraint(equalTo: geoIcon.topAnchor),
            geoLabelNewCity.leadingAnchor.constraint(equalTo: geoIcon.trailingAnchor, constant: 20),

            geoIcon.topAnchor.constraint(equalTo: degreelabel.bottomAnchor, constant: 10),
            geoIcon.leadingAnchor.constraint(equalTo: topView.leadingAnchor, constant: 40),
            geoIcon.heightAnchor.constraint(equalToConstant: 20),
            geoIcon.widthAnchor.constraint(equalToConstant: 20),
            
            weatherIcon.centerYAnchor.constraint(equalTo: degreelabel.centerYAnchor),
            weatherIcon.centerXAnchor.constraint(equalTo: degreelabel.centerXAnchor, constant: 150),
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
    
    func setupGradient(weather: String) {
        
        if weather == "Clouds" {
            self.view.backgroundColor = #colorLiteral(red: 0.6642242074, green: 0.6642400622, blue: 0.6642315388, alpha: 1)
        } else if weather == "Rain" {
            self.view.backgroundColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        } else if weather == "Clear" {
            self.view.backgroundColor = #colorLiteral(red: 0.7841619849, green: 0.63756001, blue: 0.7690585852, alpha: 1)
        } else if weather == "Snow" {
            self.view.backgroundColor = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)
        }
    }
    
    func bind() {
        self.viewModel.currentOptions.bind { [weak self] currentOptions in
            guard let currentDate = currentOptions.date else { return }
            let dateInterval = Date(timeIntervalSince1970: currentDate)
            let date = self?.dateFormatter.string(from: dateInterval)
            DispatchQueue.main.async {
                self?.geoLabel.text = self?.viewModel.textForGeoLabel.value
                self?.degreelabel.text = currentOptions.temperature
                self?.dateLabel.text = date
                guard let main = currentOptions.main else { return }
                if main == "Clouds" {
                    self?.setupGradient(weather: main)
                } else if main == "Rain" {
                    self?.setupGradient(weather: main)
                } else if main == "Clear" {
                    self?.setupGradient(weather: main)
                } else if main == "Snow" {
                    self?.setupGradient(weather: main)
                }
                self?.weatherIcon.image = UIImage(named: (main))
            }
        }
        
        self.viewModel.weeklyOptions.bind { [weak self] _ in
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
    
    @objc func presentSearchVC() {
        self.present(self.searchViewController, animated: true)
    }
    
    @objc func currentGeoReturn() {
        viewModel.location()
        viewModel.sendRequest()
    }
}

    


