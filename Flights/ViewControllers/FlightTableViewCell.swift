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
    @IBOutlet weak var arrivalOutboundDate: UILabel!
    @IBOutlet weak var arrivalInboundDate: UILabel!
    
	override func awakeFromNib() {
		super.awakeFromNib()
		if let itinerary =  itinerary {
			setupCell(itinerary)
		}
	}
}

extension FlightTableViewCell {
	func setupCell(_ itinerary: Itinerary) {
		if let inboundLeg = itinerary.inboundLeg, let outboundLeg = itinerary.outboundLeg {
			if let departureCarrier = inboundLeg.carriers.first, let arrivalCarrier = outboundLeg.carriers.first {
				let departureImageURL = URL(string: departureCarrier.imageURL)
				let arrivalImageURL = URL(string: arrivalCarrier.imageURL)
				departureImage.kf.setImage(with: departureImageURL)
				arrivalImage.kf.setImage(with: arrivalImageURL)

				departureOrigin.text = departureCarrier.name
				arrivalOrigin.text = arrivalCarrier.name
			}

			if let price = itinerary.priceOptions.first {
				flightPrice.text = "£ \(price.price)"
			} else {
				flightPrice.isHidden = true
			}

			departureDate.text = "Departure - " + outboundLeg.departure
            arrivalOutboundDate.text = "Arrival - " + outboundLeg.arrival
			arrivalDate.text = "Departure - " + inboundLeg.departure
            arrivalInboundDate.text = "Arrival - " + inboundLeg.arrival
			departureTime.text = outboundLeg.duration
			arrivalTime.text = inboundLeg.duration
		}
	}
}
