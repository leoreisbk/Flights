//
//  FlightTableViewCell.swift
//  Flights
//
//  Created by Leonardo Reis on 30/07/18.
//  Copyright © 2018 Leonardo Reis. All rights reserved.
//

import UIKit
import Kingfisher

class FlightTableViewCell: UITableViewCell {
	var itinerary: Itinerary?
	
	@IBOutlet weak var departureImage: UIImageView!
	@IBOutlet weak var arrivalImage: UIImageView!
	@IBOutlet weak var departureDate: UILabel!
	@IBOutlet weak var arrivalDate: UILabel!
	@IBOutlet weak var inboundStops: UILabel!
	@IBOutlet weak var outboundStops: UILabel!
	@IBOutlet weak var departureOrigin: UILabel!
	@IBOutlet weak var arrivalOrigin: UILabel!
	@IBOutlet weak var departureTime: UILabel!
	@IBOutlet weak var arrivalTime: UILabel!
	@IBOutlet weak var flightPrice: UILabel!
	
	override func awakeFromNib() {
		super.awakeFromNib()
		if let itinerary =  itinerary {
			setupCell(itinerary)
		}
	}
}

extension FlightTableViewCell {
	func setupCell(_ itinerary: Itinerary) {
		let departureImageURL = URL(string: (itinerary.inboundLeg?.carriers.first?.imageURL)!)
		let arrivalImageURL = URL(string: (itinerary.outboundLeg?.carriers.first?.imageURL)!)
		departureImage.kf.setImage(with: departureImageURL)
		arrivalImage.kf.setImage(with: arrivalImageURL)
	}
}
