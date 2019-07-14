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
	let carriers: [Carrier]
	let agents: [Agent]

	private enum CodingKeys: String, CodingKey {
		case status = "Status"
		case itineraries = "Itineraries"
		case legs = "Legs"
		case segments = "Segments"
		case carriers = "Carriers"
		case agents = "Agents"
	}

	fileprivate func filterItineraries(_ itinerariesJSON: [Itinerary]) -> [Itinerary] {
		return itinerariesJSON.map { (itineraryJson) -> Itinerary in
			var itinerary = itineraryJson
            let _ = legs.map { (legJson) -> Void in
                var leg  = legJson
                leg.segments = segments.filter({ legJson.segmentIdentifiers.contains($0.identifier)})
                leg.carriers = carriers.filter({ legJson.carriersIdentifiers.contains($0.identifier)})
                
                if itineraryJson.inboundLegId == leg.identifier {
                    itinerary.inboundLeg = leg
                }
                
                if itineraryJson.outboundLegId == leg.identifier {
                    itinerary.outboundLeg = leg
                }
            }
			let priceOptionsArray = itinerary.pricingOptions.map({ (priceOptionJSON) -> PricingOption in
				var priceOption = priceOptionJSON
                priceOption.agents = agents.filter({priceOptionJSON.agentsIdentifiers.contains($0.identifier)})
				return priceOption
			})
			
			itinerary.priceOptions = priceOptionsArray
			
			return itinerary
		}
	}
	
	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		status = try values.decode(String.self, forKey: .status)
		let itinerariesJSON = try values.decode([Itinerary].self, forKey: .itineraries)
		legs = try values.decode([Leg].self, forKey: .legs)
		segments = try values.decode([Segment].self, forKey: .segments)
		carriers = try values.decode([Carrier].self, forKey: .carriers)
		agents = try values.decode([Agent].self, forKey: .agents)
		
		let itinerariesArray = filterItineraries(itinerariesJSON)
		
		itineraries = itinerariesArray
	}

	func encode(to encoder: Encoder) throws {
		var container = encoder.container(keyedBy: CodingKeys.self)
		try container.encode(status, forKey: .status)
		try container.encode(itineraries, forKey: .itineraries)
		try container.encode(legs, forKey: .legs)
		try container.encode(segments, forKey: .segments)
		try container.encode(carriers, forKey: .carriers)
		try container.encode(agents, forKey: .agents)
	}
}
