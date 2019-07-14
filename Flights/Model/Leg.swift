//
//  Leg.swift
//  Flights
//
//  Created by Leonardo Reis on 30/07/18.
//  Copyright © 2018 Leonardo Reis. All rights reserved.
//

import UIKit

struct Leg: Codable {

	let identifier: String
	let segmentIdentifiers: [Int]
	var segments: [Segment] = []
	let originStation:  Int
	let destinationStation: Int
	let departure: String
	let arrival: String
	let duration: String
	let journeyMode: String
	let stops: [Int]
	let carriersIdentifiers: [Int]
	var carriers: [Carrier] = []
	let directionality: String

	private enum CodingKeys: String, CodingKey {
		case identifier = "Id"
		case segmentIdentifiers = "SegmentIds"
		case originStation = "OriginStation"
		case destinationStation = "DestinationStation"
		case departure = "Departure"
		case arrival = "Arrival"
		case duration = "Duration"
		case journeyMode = "JourneyMode"
		case stops = "Stops"
		case carriers = "Carriers"
		case directionality = "Directionality"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		identifier = try values.decode(String.self, forKey: .identifier)
		segmentIdentifiers = try values.decode([Int].self, forKey: .segmentIdentifiers)
		originStation = try values.decode(Int.self, forKey: .originStation)
		destinationStation = try values.decode(Int.self, forKey: .destinationStation)
		let departureStr = try values.decode(String.self, forKey: .departure)
		let arrivalStr = try values.decode(String.self, forKey: .arrival)
		let durationInt = try values.decode(Int.self, forKey: .duration)
		journeyMode = try values.decode(String.self, forKey: .journeyMode)
		stops = try values.decode([Int].self, forKey: .stops)
		carriersIdentifiers = try values.decode([Int].self, forKey: .carriers)
		directionality = try values.decode(String.self, forKey: .directionality)

        let format = "dd/MM HH:mm"
		departure = Date.getFormattedDate(stringDate: departureStr, formatter: format)
		arrival = Date.getFormattedDate(stringDate: arrivalStr, formatter: format)
		duration = durationInt.minutesToHoursMinutes()

	}

	func encode(to encoder: Encoder) throws {
		var container = encoder.container(keyedBy: CodingKeys.self)
		try container.encode(identifier, forKey: .identifier)
		try container.encode(segmentIdentifiers, forKey: .segmentIdentifiers)
		try container.encode(originStation, forKey: .originStation)
		try container.encode(destinationStation, forKey: .destinationStation)
		try container.encode(departure, forKey: .departure)
		try container.encode(arrival, forKey: .arrival)
		try container.encode(duration, forKey: .duration)
		try container.encode(journeyMode, forKey: .journeyMode)
		try container.encode(stops, forKey: .stops)
		try container.encode(carriersIdentifiers, forKey: .carriers)
		try container.encode(directionality, forKey: .directionality)

	}
}
