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
	var itineraries: [Itinerary] = []
	var legs: [Leg]
	let segments: [Segment]
	var segmentsFiltered: [Segment] = []
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
		let itinerariesJSON = try values.decode([Itinerary].self, forKey: .itineraries)
		legs = try values.decode([Leg].self, forKey: .legs)
		segments = try values.decode([Segment].self, forKey: .segments)
		carriers = try values.decode([Carrier].self, forKey: .carriers)
		
		let itinerariesArray = itinerariesJSON.map { (itineraryJson) -> Itinerary in
			var itinerary = itineraryJson
			let _ = legs.map { (legJson) -> Void in
				var leg  = legJson
				let _ = legJson.segmentIdentifiers.map({ (identifier) ->  Void in
					let segmentFiltered = segments.filter({ (segment) -> Bool in
						return segment.identifier == identifier
					})
					leg.segments = segmentFiltered
				})
				
				if itineraryJson.inboundLegId == leg.identifier {
					itinerary.inboundLeg = leg
				}
				
				if itineraryJson.outboundLegId == leg.identifier {
					itinerary.outboundLeg = leg
				}
			}
			
			return itinerary
		}
		
		itineraries = itinerariesArray
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
