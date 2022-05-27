import UIKit
import Foundation

class CurrentGeoTableViewCell: UITableViewCell {
    
    let viewModel = CurrentGeoTableViewCellViewModel()
    let dateLabel = UILabel()
    let degreeLabel = UILabel()
    let weatherLabel = UILabel()
    let celsiusIcon = UIImageView()
    var weatherIcon = UIImageView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setupUI()
        self.bind()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI() {
        self.backgroundColor = UIColor(red: 255.0, green: 255.0, blue: 255.0, alpha: 0.001)
        self.dateLabel.numberOfLines = 3
        self.dateLabel.font = UIFont(name: "Inter-ExtraLight", size: 18)
        self.dateLabel.textAlignment = .left
        self.dateLabel.translatesAutoresizingMaskIntoConstraints = false
        self.contentView.addSubview(dateLabel)
        
        self.degreeLabel.numberOfLines = 3
        self.degreeLabel.font = UIFont(name: "Inter-ExtraLight", size: 28)
        self.degreeLabel.textAlignment = .right
        self.degreeLabel.textColor = .black
        self.degreeLabel.translatesAutoresizingMaskIntoConstraints = false
        self.contentView.addSubview(degreeLabel)
        
        self.weatherLabel.numberOfLines = 3
        self.weatherLabel.font = UIFont(name: "Inter-ExtraLight", size: 18)
        self.weatherLabel.textAlignment = .right
        self.weatherLabel.translatesAutoresizingMaskIntoConstraints = false
        self.contentView.addSubview(weatherLabel)
        
        self.celsiusIcon.image = UIImage(named: "celsius black")
        self.celsiusIcon.sizeToFit()
        self.celsiusIcon.translatesAutoresizingMaskIntoConstraints = false
        self.contentView.addSubview(celsiusIcon)
        
        self.weatherIcon.contentMode = .scaleAspectFit
        self.weatherIcon.translatesAutoresizingMaskIntoConstraints = false
        self.contentView.addSubview(weatherIcon)
        
        let cellGuide = self.contentView.layoutMarginsGuide
        
        NSLayoutConstraint.activate([
            self.dateLabel.leadingAnchor.constraint(equalTo: cellGuide.leadingAnchor),
            self.dateLabel.topAnchor.constraint(equalTo: cellGuide.topAnchor),
            self.dateLabel.bottomAnchor.constraint(equalTo: cellGuide.bottomAnchor),
            
            self.degreeLabel.trailingAnchor.constraint(equalTo: cellGuide.trailingAnchor, constant: -20),
            self.degreeLabel.topAnchor.constraint(equalTo: cellGuide.topAnchor),
            self.degreeLabel.bottomAnchor.constraint(equalTo: cellGuide.bottomAnchor),
            
            self.weatherLabel.leadingAnchor.constraint(equalTo: self.weatherIcon.centerXAnchor, constant: 50),
            self.weatherLabel.topAnchor.constraint(equalTo: cellGuide.topAnchor),
            self.weatherLabel.bottomAnchor.constraint(equalTo: cellGuide.bottomAnchor),
            
            self.celsiusIcon.leadingAnchor.constraint(equalTo: self.degreeLabel.trailingAnchor, constant: 10),
            self.celsiusIcon.topAnchor.constraint(equalTo: self.degreeLabel.topAnchor),
            self.celsiusIcon.heightAnchor.constraint(equalToConstant: 20),
            self.celsiusIcon.widthAnchor.constraint(equalToConstant: 15),
            
            self.weatherIcon.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            self.weatherIcon.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            self.weatherIcon.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 1/2)
        ])
    }
    
    func bind() {
        viewModel.dateLabelText.bind { text in
            self.dateLabel.text = text
        }
        viewModel.degreeLabelText.bind { text in
            self.degreeLabel.text = text
        }
        viewModel.weatherLabelText.bind { text in
            self.weatherLabel.text = text
        }
        viewModel.weatherIconImage.bind { image in
            self.weatherIcon.image = image
        }
    }

}
