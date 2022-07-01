enum U10tOption {
    case host(String)
    case scheme(String)
    case port(Int)
    case headers(Dictionary<String, String>)
}

struct U10tConfig {
    static var host = ""
    static var scheme = ""
    static var headers: Dictionary<String, String> = [:]
    static var port: Int? = nil
}
