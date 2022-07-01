import U10t

U10t.builder
    .method(.get)
    .host("localhost")
    .scheme("http")
    .port(3000)
    .header("application/json", for: "Content-Type")
    .endpoint("/posts/{id}")
    .routeParam("1", for: "id")
//    .build()
