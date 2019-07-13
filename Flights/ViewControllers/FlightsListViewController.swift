//
//  FlightsListViewController.swift
//  Flights
//
//  Created by Leonardo Reis on 30/07/18.
//  Copyright © 2018 Leonardo Reis. All rights reserved.
//

import UIKit
import Moya
import Alamofire
import PagingTableView

class FlightsListViewController: UIViewController {
	@IBOutlet weak var tableView: PagingTableView!
	@IBOutlet weak var headerView: UIView!
	
	let provider = MoyaProvider<APIClient>()
	var itineraries: [Itinerary] = []
	let numberOfItemsPerPage = 10
	var urlString = ""
	
	fileprivate func shadoWView() {
		let shadow = BPKShadow.shadowSm()
		shadow.apply(to: headerView.layer)
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		self.title = "Edinburgh to London"
		tableView.dataSource = self
		tableView.pagingDelegate = self
		shadoWView()
	}
}

// MARK: - Table view data source

extension FlightsListViewController: UITableViewDelegate, UITableViewDataSource {
	func numberOfSections(in tableView: UITableView) -> Int {
		return 1
	}
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return itineraries.count
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "flightCell", for: indexPath) as! FlightTableViewCell
		cell.setupCell(itineraries[indexPath.row])
		return cell
	}
}

// MARK: - Networking

extension FlightsListViewController {
	fileprivate func requestURLSession(_ apiKey: String, completion: @escaping (_ completed: Bool) -> Void) {
		provider.request(.session(apiKey: apiKey)) { (result) in
			switch result {
			case .success(let response):
				let responseData = response.response
                if let locationDict = responseData?.allHeaderFields {
                    if let locationURL = locationDict["Location"] as? String {
                        self.urlString = locationURL
                        completion(true)
                    } else {
                        completion(false)
                    }
                } else {
					completion(false)
				}
			case .failure(let error):
				if error.response != nil {
					completion(false)
				}
				
			}
		}
	}
	
	fileprivate func requestFlights(page: Int, urlString: String, apiKey: String, completion: @escaping (_ results: [Itinerary]) -> Void) {
		provider.request(.flights(urlString: urlString, apiKey: apiKey, page: page)) { (result) in
			switch result {
			case .success(let response):
                if response.data.count > 0 && response.statusCode == 200 {
                    do {
                        let flights = try JSONDecoder().decode(Flight.self, from: response.data)
                        self.itineraries.append(contentsOf:flights.itineraries)
                        
                        let firstIndex = page * self.numberOfItemsPerPage
                        guard firstIndex < self.itineraries.count else {
                            completion([])
                            return
                        }
                        let lastIndex = (page + 1) * self.numberOfItemsPerPage < self.itineraries.count ?
                            (page + 1) * self.numberOfItemsPerPage : self.itineraries.count
                        completion(Array(self.itineraries[firstIndex ..< lastIndex]))
                    } catch let err {
                        print(err)
                    }
                } else {
					self.requestURLSession(ManagerKeys.ApiKey, completion: { (completed) in
						self.tableView.isLoading = !completed
					})
				}
			case .failure(let error):
				print(error)
			}
		}
	}
}

// MARK: - PagingTableView

extension FlightsListViewController: PagingTableViewDelegate {
	func paginate(_ tableView: PagingTableView, to page: Int) {
		self.tableView.isLoading = true
		requestURLSession(ManagerKeys.ApiKey) { (completed) in
			if completed {
				self.requestFlights(page: page, urlString: self.urlString, apiKey: ManagerKeys.ApiKey, completion: { (results) in
					self.itineraries.append(contentsOf: results)
					self.tableView.isLoading = false
					
				})
			}
		}
	}
}
