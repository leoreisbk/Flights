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
import PKHUD

class FlightsListViewController: UIViewController {
	@IBOutlet weak var tableView: UITableView!
	@IBOutlet weak var headerView: UIView!
	
	let provider = MoyaProvider<APIClient>()
	var itineraries: [Itinerary] = []
	var flight: Flight?
	
	fileprivate func shadoWView() {		
		let shadow = BPKShadow.shadowSm()
		shadow.apply(to: headerView.layer)
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		shadoWView()
		
		requestSessionId(ManagerKeys.ApiKey)
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
	fileprivate func requestSessionId(_ apiKey: String) {
		HUD.show(.progress)
		provider.request(.session(apiKey: apiKey)) { (result) in
			switch result {
			case .success(let response):
				let responseData = response.response
				if let locationDict = responseData?.allHeaderFields {
					if let locationURL = locationDict["Location"] as? String {
						self.requestFlights(urlString: locationURL, apiKey: apiKey, completion: { results in
							do {
								let flights = try JSONDecoder().decode(Flight.self, from: results as! Data)
								self.itineraries = flights.itineraries
								self.flight = flights
								self.tableView.reloadData()
								HUD.hide()
							} catch let err {
								print(err)
							}
						})
					}
				}
			case .failure(let error):
				print(error)
			}
		}
	}
	
	fileprivate func requestFlights(urlString: String, apiKey: String, completion: @escaping (_ results: Any) -> Void) {
		provider.request(.flights(urlString: urlString, apiKey: apiKey)) { (result) in
			switch result {
			case .success(let response):
				if response.data.count > 0 && response.statusCode == 200 {
					completion(response.data)
				} else {
					self.requestSessionId(apiKey)
				}
			case .failure(let error):
				print(error)
			}
		}
	}
}

extension FlightsListViewController: UIScrollViewDelegate {
	func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
		
	}
	
	func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
		
	}
}
