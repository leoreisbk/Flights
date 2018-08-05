//
//  PricingOption.swift
//  Flights
//
//  Created by Leonardo Reis on 30/07/18.
//  Copyright © 2018 Leonardo Reis. All rights reserved.
//

import UIKit

struct PricingOption: Codable {

//	"Agents": [
//	2363321
//	],
//	"QuoteAgeInMinutes": 38,
//	"Price": 78.8,

	let agentsIdentifiers: [Int]
	var agents: [Agent] = []
	let quoteAgeInMinutes: Int
	let price: Double

	private enum CodingKeys: String, CodingKey {
		case agents = "Agents"
		case quoteAgeInMinutes = "QuoteAgeInMinutes"
		case price = "Price"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		agentsIdentifiers = try values.decode([Int].self, forKey: .agents)
		quoteAgeInMinutes = try values.decode(Int.self, forKey: .quoteAgeInMinutes)
		price = try values.decode(Double.self, forKey: .price)
	}

	func encode(to encoder: Encoder) throws {
		var container = encoder.container(keyedBy: CodingKeys.self)
		try container.encode(agentsIdentifiers, forKey: .agents)
		try container.encode(quoteAgeInMinutes, forKey: .quoteAgeInMinutes)
		try container.encode(price, forKey: .price)
	}

}
