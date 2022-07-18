//
//  ViewController.swift
//  weather
//
//  Created by Huan Le A. on 11/07/2022.
//

import UIKit
import Combine

enum Indentifier {
    static let key = "CityViewCell"
    
}

class WeatherViewController: UIViewController {
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var indicator: UIActivityIndicatorView!

    var weatherArray: [WeatherViewModel] = []
    private var viewModel: WeatherViewModel = WeatherViewModel()
    private var bindings = Set<AnyCancellable>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        indicator.isHidden = true
        setUpBindings()
        tableView.register(UINib(nibName: "CityViewCell", bundle: nil), forCellReuseIdentifier: Indentifier.key)
        tableView.delegate = self
        tableView.dataSource = self
    }
    
//    override func loadView() {
//        view = contentView
//    }
    
    private func setUpBindings() {
        func bindViewToViewModel() {
            searchBar.searchTextField.textPublisher
                .debounce(for: 1, scheduler: RunLoop.main)
                .removeDuplicates()
                .assign(to: \.searchText, on: viewModel)
                .store(in: &bindings)
        }
        
        func bindViewModelToView() {
            //lang nghe - listenß
            viewModel.$weatherInfo
                .receive(on: RunLoop.main)
                .sink(receiveValue: { [weak self] _ in
                    self?.tableView.reloadData()
                })
                .store(in: &bindings)
            
            let stateValueHandler: (WeatherViewModelState) -> Void = { [weak self] state in
                switch state {
                case .loading:
                    self?.indicator.isHidden = false
//                    self?.indicator.startAnimating()
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                        self?.indicator.isHidden = true
//                        self?.indicator.stopAnimating()
                    }
                case .finishedLoading:
                    self?.indicator.isHidden = true
//                    self?.indicator.stopAnimating()
                case .error:
                    self?.indicator.isHidden = true
//                    self?.indicator.stopAnimating()
                    self?.tableView.reloadData()
                }
            }
            
            viewModel.$state
                .receive(on: RunLoop.main)
                .sink(receiveValue: stateValueHandler)
                .store(in: &bindings)
        }
        
        bindViewToViewModel()
        bindViewModelToView()
    }
    
    private func showError(_ error: Error) {
        let alertController = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "OK", style: .default) { [unowned self] _ in
            self.dismiss(animated: true, completion: nil)
        }
        alertController.addAction(alertAction)
        present(alertController, animated: true, completion: nil)
    }

    private func setAccessibility() {
        self.navigationItem.isAccessibilityElement = true
        self.navigationItem.accessibilityLabel = "Weather Forecast"
        searchBar.searchTextField.isAccessibilityElement = true
    }
    
}

extension WeatherViewController : UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (viewModel.weatherInfo == nil) {return 0}
        return viewModel.weatherInfo!.list.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 140
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        tableView.estimatedRowHeight = 500
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Indentifier.key, for: indexPath) as? CityViewCell else {
            return UITableViewCell()
        }
        
        let item = viewModel.weatherInfo?.list[indexPath.row]
        cell.setDate(date: self.viewModel.getDateInWeak()[indexPath.item])
        cell.updateUIValue(name: "cityName", value: "\(viewModel.weatherInfo!.city.name)")
        cell.updateUIValue(name: "min", value: item?.temp.min.description)
        cell.updateUIValue(name: "max", value: item?.temp.max.description)
        cell.updateUIValue(name: "humidity", value: item?.humidity.description)
        cell.updateUIValue(name: "description", value: item?.weather[0].description.description)
        
        cell.loadWheatherIconFrom(iconValue: item?.weather[0].icon.description)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let vc = self.storyboard?.instantiateViewController(withIdentifier: "WeatherDetailViewController") as? WeatherDetailViewController else {
            return
        }
        vc.viewModel = viewModel.viewModelForDetail(indexPath: indexPath)
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

