//
//  itinerary.swift
//  Flights
//
//  Created by Leonardo Reis on 30/07/18.
//  Copyright © 2018 Leonardo Reis. All rights reserved.
//

import UIKit

struct Itinerary: Codable {
	let outboundLegId: String
	let inboundLegId: String
	let pricingOptions: [PricingOption]
	var inboundLeg: Leg? 
	var outboundLeg: Leg?

	private enum CodingKeys: String, CodingKey {
		case outboundLegId = "OutboundLegId"
		case inboundLegId = "InboundLegId"
		case pricingOptions = "PricingOptions"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		outboundLegId = try values.decode(String.self, forKey: .outboundLegId)
		inboundLegId = try values.decode(String.self, forKey: .inboundLegId)
		pricingOptions = try values.decode([PricingOption].self, forKey: .pricingOptions)
	}

	func encode(to encoder: Encoder) throws {
		var container = encoder.container(keyedBy: CodingKeys.self)
		try container.encode(outboundLegId, forKey: .outboundLegId)
		try container.encode(inboundLegId, forKey: .inboundLegId)
		try container.encode(pricingOptions, forKey: .pricingOptions)
	}

}
