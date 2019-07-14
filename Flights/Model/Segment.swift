//
//  Segment.swift
//  Flights
//
//  Created by Leonardo Reis on 30/07/18.
//  Copyright © 2018 Leonardo Reis. All rights reserved.
//

import UIKit

struct Segment: Codable {

	let identifier: Int
	let originStation: Int
	let destinationStation: Int
	let departureDateTime: String
	let arrivalDateTime: String
	let carrier: Int
	let operatingCarrier: Int
	let duration: Int
	let flightNumber: String
	let journeyMode: String
	let directionality: String

	private enum CodingKeys: String, CodingKey {
		case identifier = "Id"
		case originStation = "OriginStation"
		case destinationStation = "DestinationStation"
		case departureDateTime = "DepartureDateTime"
		case arrivalDateTime = "ArrivalDateTime"
		case carrier = "Carrier"
		case operatingCarrier = "OperatingCarrier"
		case duration = "Duration"
		case flightNumber = "FlightNumber"
		case journeyMode = "JourneyMode"
		case directionality = "Directionality"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		identifier = try values.decode(Int.self, forKey: .identifier)
		originStation = try values.decode(Int.self, forKey: .originStation)
		destinationStation = try values.decode(Int.self, forKey: .destinationStation)
		departureDateTime = try values.decode(String.self, forKey: .departureDateTime)
		arrivalDateTime = try values.decode(String.self, forKey: .arrivalDateTime)
		carrier = try values.decode(Int.self, forKey: .carrier)
		operatingCarrier = try values.decode(Int.self, forKey: .operatingCarrier)
		duration = try values.decode(Int.self, forKey: .duration)
		flightNumber = try values.decode(String.self, forKey: .flightNumber)
		journeyMode = try values.decode(String.self, forKey: .journeyMode)
		directionality = try values.decode(String.self, forKey: .directionality)
	}

	func encode(to encoder: Encoder) throws {
		var container = encoder.container(keyedBy: CodingKeys.self)
		try container.encode(identifier, forKey: .identifier)
		try container.encode(originStation, forKey: .originStation)
		try container.encode(destinationStation, forKey: .destinationStation)
		try container.encode(departureDateTime, forKey: .departureDateTime)
		try container.encode(arrivalDateTime, forKey: .arrivalDateTime)
		try container.encode(duration, forKey: .duration)
		try container.encode(flightNumber, forKey: .flightNumber)
		try container.encode(journeyMode, forKey: .journeyMode)
		try container.encode(carrier, forKey: .carrier)
		try container.encode(operatingCarrier, forKey: .operatingCarrier)
		try container.encode(directionality, forKey: .directionality)
	}

}
