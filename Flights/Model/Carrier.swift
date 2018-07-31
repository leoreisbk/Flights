//
//  Carrier.swift
//  Flights
//
//  Created by Leonardo Reis on 30/07/18.
//  Copyright © 2018 Leonardo Reis. All rights reserved.
//

import UIKit

struct Carrier: Codable {

//	"Id": 885,
//	"Code": "BE",
//	"Name": "Flybe",
//	"ImageUrl": "http://s1.apideeplink.com/images/airlines/BE.png",
//	"DisplayCode": "BE"
	
	let identifier: Int
	let code: String
	let name: String
	let imageURL: String
	let displayCode: String
	
	private enum CodingKeys: String, CodingKey {
		case identifier = "Id"
		case code = "Code"
		case name = "Name"
		case imageURL = "ImageUrl"
		case displayCode = "DisplayCode"
	}
	
	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		identifier = try values.decode(Int.self, forKey: .identifier)
		code = try values.decode(String.self, forKey: .code)
		name = try values.decode(String.self, forKey: .name)
		imageURL = try values.decode(String.self, forKey: .imageURL)
		displayCode = try values.decode(String.self, forKey: .displayCode)
	}
	
	func encode(to encoder: Encoder) throws {
		var container = encoder.container(keyedBy: CodingKeys.self)
		try container.encode(identifier, forKey: .identifier)
		try container.encode(code, forKey: .code)
		try container.encode(name, forKey: .name)
		try container.encode(imageURL, forKey: .imageURL)
		try container.encode(displayCode, forKey: .displayCode)
	}
}
