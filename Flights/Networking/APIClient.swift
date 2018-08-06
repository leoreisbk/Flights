//
//  APIClient.swift
//  Flights
//
//  Created by Leonardo Reis on 30/07/18.
//  Copyright © 2018 Leonardo Reis. All rights reserved.
//

import Foundation
import Alamofire
import Moya

enum APIClient {
	case session(apiKey: String)
	case flights(urlString: String, apiKey: String, page: Int)
}

extension APIClient: TargetType {
	var sampleData: Data {
		return Data()
	}

	var headers: [String : String]? {
		switch self {
		case .session:
			return ["Content-Type": "application/x-www-form-urlencoded",
					"Accept": "application/json",
					"X-Forwarded-For": APIClient.getIPAddress()!]
		default:
			return ["Content-Type": "application/json",
					"Accept": "application/json"]
		}
	}
	
	var task: Task {
		let encoding: ParameterEncoding
		switch self.method {
//		case .post:
//			encoding = JSONEncoding.default
		case .get:
			encoding = URLEncoding.queryString
		default:
			encoding = URLEncoding.default
		}
		if let requestParameters = parameters {
			return .requestParameters(parameters: requestParameters, encoding: encoding)
		}
		return .requestPlain
	}
	
	var path: String {
		switch self {
		case .session:
			return "/pricing/v1.0"
		case .flights:
			return ""
		}
	}
	
	var base: String {
		switch self {
		case .flights(let urlString, _, _):
			return urlString
		default:
			return "http://partners.api.skyscanner.net/apiservices"
		}
		
	}
	var baseURL: URL { return URL(string: base)! }
	
	var parameters: [String: Any]? {
		switch self {
		case .session(let apiKey):
			return ["apiKey": apiKey,
					"country": "UK",
					"currency": "GBP",
					"locale": "en-GB",
					"originPlace": "EDI-sky",
					"destinationPlace": "LOND-sky",
					"outboundDate": "2018-08-06",
					"inboundDate": "2018-08-07",
					"adults": "1",
					"cabinclass": "Economy",
					"children": "0",
					"infants": "0",
					"locationSchema": "sky"]
		case .flights( _, let apiKey, let page):
			return ["apiKey": apiKey,
//					"stops": 0,
//					"duration":360,
					"pageIndex": page,
					"pageSize": 10]
		
		}
	}
	
	var method: Moya.Method {
		switch self {
		case .session:
			return .post
		case .flights:
			return .get
		}
	}
}

extension APIClient {
	static func getIPAddress() -> String? {
		var address: String?
		var ifaddr: UnsafeMutablePointer<ifaddrs>? = nil
		if getifaddrs(&ifaddr) == 0 {
			var ptr = ifaddr
			while ptr != nil {
				defer { ptr = ptr?.pointee.ifa_next }

				let interface = ptr?.pointee
				let addrFamily = interface?.ifa_addr.pointee.sa_family
				if addrFamily == UInt8(AF_INET) || addrFamily == UInt8(AF_INET6) {

					if let name: String = String(cString: (interface?.ifa_name)!), name == "en0" {
						var hostname = [CChar](repeating: 0, count: Int(NI_MAXHOST))
						getnameinfo(interface?.ifa_addr, socklen_t((interface?.ifa_addr.pointee.sa_len)!), &hostname, socklen_t(hostname.count), nil, socklen_t(0), NI_NUMERICHOST)
						address = String(cString: hostname)
					}
				}
			}
			freeifaddrs(ifaddr)
		}
		return address
	}
}

private extension String {
	var URLEscapedString: String {
		return self.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlHostAllowed)!
	}
}

func url(_ route: TargetType) -> String {
	return route.baseURL.appendingPathComponent(route.path).absoluteString
}

