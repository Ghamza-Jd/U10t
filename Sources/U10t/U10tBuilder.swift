import Foundation

typealias U10tCachePolicy = URLRequest.CachePolicy

enum U10tMethod: String {
    case get = "GET"
    case post = "POST"
    case update = "UPDATE"
    case delete = "DELETE"
}

struct U10tBuilderParams {
    var method: U10tMethod = .get
    var scheme = U10tConfig.scheme
    var host = U10tConfig.host
    var port: Int? = U10tConfig.port
    var queryStrings: Dictionary<String, String> = [:]
    var routeParams: Dictionary<String, String> = [:]
    var endpoint: String = ""
    var cachePolicy: U10tCachePolicy? = nil
    var headers: Dictionary<String, String> = U10tConfig.headers
    var body: Data? = nil
}

struct U10tBuilder {
    private(set) var params = U10tBuilderParams()
    
    @discardableResult
    func method(_ mthd: U10tMethod) -> Self {
        var builder = self
        builder.params.method = mthd
        return builder
    }
    
    @discardableResult
    func header(_ value: String, for key: String) -> Self {
        var builder = self
        builder.params.headers[key] = value
        return builder
    }
    
    @discardableResult
    func queryString(_ value: String, for key: String) -> Self {
        var builder = self
        builder.params.queryStrings[key] = value
        return builder
    }
    
    @discardableResult
    func routeParam(_ value: String, for key: String) -> Self {
        var builder = self
        builder.params.routeParams[key] = value
        return builder
    }
    
    @discardableResult
    func endpoint(_ ep: String) -> Self {
        var builder = self
        builder.params.endpoint = ep
        return builder
    }
    
    @discardableResult
    func host(_ hst: String) -> Self {
        var builder = self
        builder.params.host = hst
        return builder
    }
    
    @discardableResult
    func scheme(_ schm: String) -> Self {
        var builder = self
        builder.params.scheme = schm
        return builder
    }
    
    @discardableResult
    func body<T>(_ bdy: T) -> Self where T : Encodable {
        var builder = self
        if let encoded = try? JSONEncoder().encode(bdy) {
            builder.params.body = encoded
        }
        return builder
    }
    
    @discardableResult
    func port(_ prt: Int) -> Self {
        var builder = self
        builder.params.port = prt
        return builder
    }
    
    @discardableResult
    func cachePolicy(_ cache: U10tCachePolicy) -> Self {
        var builder = self
        builder.params.cachePolicy = cache
        return builder
    }
}
