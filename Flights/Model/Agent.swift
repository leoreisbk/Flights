//
//  Agent.swift
//  Flights
//
//  Created by Leonardo Reis on 05/08/18.
//  Copyright © 2018 Leonardo Reis. All rights reserved.
//

import UIKit

struct Agent: Codable {

//	"Id": 2043147,
//	"Name": "Bravofly",
//	"ImageUrl": "http://s1.apideeplink.com/images/websites/bfuk.png",
//	"Status": "UpdatesComplete",
//	"OptimisedForMobile": true,
//	"BookingNumber": "0203 499 5179",
//	"Type": "TravelAgent"

	let identifier: Int
	let name: String
	let imageURL: String
	let type: String

	private enum CodingKeys: String, CodingKey {
		case identifier = "Id"
		case name = "Name"
		case imageURL = "ImageUrl"
		case type = "Type"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		identifier = try values.decode(Int.self, forKey: .identifier)
		name = try values.decode(String.self, forKey: .name)
		imageURL = try values.decode(String.self, forKey: .imageURL)
		type = try values.decode(String.self, forKey: .type)
	}

	func encode(to encoder: Encoder) throws {
		var container = encoder.container(keyedBy: CodingKeys.self)
		try container.encode(identifier, forKey: .identifier)
		try container.encode(name, forKey: .name)
		try container.encode(imageURL, forKey: .imageURL)
		try container.encode(type, forKey: .type)
	}
}
