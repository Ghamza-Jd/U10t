# U10t (UnirestSwift)

A simple `REST` client built on top of `URLSession` and heavliy inspired by [Unirest](http://kong.github.io/unirest-java/)

Example Usage:
```swift
import SwiftUI
import U10t

struct Post: Codable {
    let id: Int?
    let title: String
    let author: String
}

struct ContentView: View {
    var body: some View {
        Button("Press me") {
            Task {
                do {
                    // Specifing the type so that .send can inference the type and encode it
                    let posts: Post? = try await U10t
                        .builder
                        .method(.get)
                        .endpoint("/posts/{id}")
                        .routeParam("3", for: "id")
                        .cachePolicy(.useProtocolCachePolicy)
                        .build()
                        .send()
                    if let post = posts {
                        print(post.title)
                    }
                } catch {
                    print("Something Went Wrong")
                }
            }
        }
    }
    
    init() {
        // one time config across the app, values can be overridden on each request explicitly
        U10t.config([
            .host("localhost"),
            .scheme("http"),
            .port(3000),
            .headers([
                "Content-Type": "application/json",
            ])
        ])
    }
}
```
