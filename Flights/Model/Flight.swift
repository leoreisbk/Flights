//
//  Flight.swift
//  Flights
//
//  Created by Leonardo Reis on 30/07/18.
//  Copyright © 2018 Leonardo Reis. All rights reserved.
//

import UIKit

struct Flight: Codable {
	let status: String
	let itineraries: [Itinerary]
	let legs: [Leg]
	let segments: [Segment]
	let carriers: [Carrier]

	private enum CodingKeys: String, CodingKey {
		case status = "Status"
		case itineraries = "Itineraries"
		case legs = "Legs"
		case segments = "Segments"
		case carriers = "Carriers"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		status = try values.decode(String.self, forKey: .status)
		itineraries = try values.decode([Itinerary].self, forKey: .itineraries)
		legs = try values.decode([Leg].self, forKey: .legs)
		segments = try values.decode([Segment].self, forKey: .segments)
		carriers = try values.decode([Carrier].self, forKey: .carriers)
	}

	func encode(to encoder: Encoder) throws {
		var container = encoder.container(keyedBy: CodingKeys.self)
		try container.encode(status, forKey: .status)
		try container.encode(itineraries, forKey: .itineraries)
		try container.encode(legs, forKey: .legs)
		try container.encode(segments, forKey: .segments)
		try container.encode(carriers, forKey: .carriers)
	}
}
