
import UIKit

class TownsTableViewCell: UITableViewCell {

    let townLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI() {
        self.contentView.addSubview(townLabel)
        townLabel.translatesAutoresizingMaskIntoConstraints = false
        
        
        let cellGuide = self.contentView.layoutMarginsGuide
        
        NSLayoutConstraint.activate([
            townLabel.topAnchor.constraint(equalTo: cellGuide.topAnchor),
            townLabel.bottomAnchor.constraint(equalTo: cellGuide.bottomAnchor),
            townLabel.leadingAnchor.constraint(equalTo: cellGuide.leadingAnchor),
            townLabel.trailingAnchor.constraint(equalTo: cellGuide.trailingAnchor),
        ])
    }
    
    func configure(with text: String) {
        townLabel.text = text
    }

}
