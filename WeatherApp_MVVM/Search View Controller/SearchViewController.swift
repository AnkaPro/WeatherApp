
import UIKit

class SearchViewController: UIViewController {
    
    let viewModel = SearchViewModel()
    let jsonParsing = JSONCitiesParse()
    let tableViewTowns = UITableView()
    let searchBar = UISearchBar()
    let currentViewModel = CurrentGeoViewModel()

    let cellId = "TownsCellId"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupView()
        self.tableViewTowns.delegate = self
        self.tableViewTowns.dataSource = self
        self.tableViewTowns.register(TownsTableViewCell.self, forCellReuseIdentifier: cellId)
        self.searchBar.delegate = self
        self.viewModel.sendDataToTableView()
        
//        jsonParsing.jsonCitiesParse()
//        filterredData = jsonParsing.arrayCitiesEn
//        initJSONCityArray = self.jsonParsing.arrayCitiesEn
//        initJSONLatArray = self.jsonParsing.latitude
//        initJSONLonArray = self.jsonParsing.longtitude
    }
    
    func setupView() {
        self.view.backgroundColor = .white
        self.view.addSubview(searchBar)
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(tableViewTowns)
        tableViewTowns.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            searchBar.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 40),
            searchBar.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            searchBar.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            searchBar.heightAnchor.constraint(equalToConstant: 50),
            
            tableViewTowns.topAnchor.constraint(equalTo: self.searchBar.bottomAnchor),
            tableViewTowns.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            tableViewTowns.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            tableViewTowns.trailingAnchor.constraint(equalTo: self.view.trailingAnchor)
        ])
    }



}
