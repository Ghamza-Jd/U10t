import Foundation

@available(macOS 12, iOS 15, watchOS 8, tvOS 15, *)
public struct U10t {
    private var u10tReq: URLRequest?
    
    static var builder: U10tBuilder {
        .init()
    }
    
    init(
        host: String,
        scheme: String = "http",
        queryStrings: Dictionary<String, String> = [:],
        endpoint: String = "",
        method: String = "GET",
        headers: Dictionary<String, String> = [:],
        body: Data? = nil,
        routeParams: Dictionary<String, String> = [:],
        port: Int? = nil,
        cachePolity: URLRequest.CachePolicy? = nil
    ) {
        var urlComponents = URLComponents()
        
        urlComponents.scheme = scheme
        urlComponents.host = host
        if let port = port {
            urlComponents.port = port
        }
        urlComponents.queryItems = queryStrings.map { (key, val) in
            URLQueryItem(name: key, value: val)
        }
        
        var endpnt = endpoint
        
        for (key, value) in routeParams {
            endpnt = endpoint.replacingOccurrences(of: "{\(key)}", with: value)
        }
        
        guard var url = urlComponents.url else {
            return
        }
        url.appendPathComponent(endpnt)
        
        var req = URLRequest(url: url)
        req.httpMethod = method
        
        if let body = body {
            req.httpBody = body
        }
        if let cachePolity = cachePolity {
            req.cachePolicy = cachePolity
        }
        
        for (key, value) in headers {
            req.setValue(value, forHTTPHeaderField: key)
        }
        
        u10tReq = req
    }

    func send<T: Decodable>() async throws -> T {
        guard let req = u10tReq else {
            throw U10tException.corruptedRequest
        }
        do {
            let (data, _) = try await URLSession.shared.data(for: req)
            let decoder = JSONDecoder()
            let response = try decoder.decode(T.self, from: data)
            return response
        } catch {
            throw U10tException.corruptedData
        }
    }

    static func config(_ options: [U10tOption]) {
        for option in options {
            switch option {
            case let .host(h):
                U10tConfig.host = h
                
            case let .scheme(s):
                U10tConfig.scheme = s
                
            case let .headers(h):
                U10tConfig.headers = h
                
            case let .port(p):
                U10tConfig.port = p
            }
        }
    }
}
