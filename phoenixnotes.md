# Notes About Phoenix

Plug is a library that combines tons of small web-related functions and has a common input/output interface thing

Each plug produces and consumes a common data structure: conn

What is the philosophy? Each individual function takes a conn, does _something small_, and then returns a conn.

The conn contains enormous amounts of stuff that a web app needs to do all of its web appy things.
Protocols, headers, etc. 

"Plugs are functions. Your web applications are pipelines of plugs."

Even the rendering is a plug that happens at the end of the pipeline, returning the conn at that point is a single isolated task that gets done.

MIX_ENV environmeny variable determines what environment phoenix will be running in

"Your application is a series of plugs, beginning with an endpoint and ending with a controller"

And of course plugs inbetween / all the way down. The router is at the end of the plugs in the endpoint.

Router.ex starts with plugs and ends with routes. A pipeline is just a bigger plug that consumes and returns a `conn` struct.

Traditional Phoenix application structure:

**Connection**
* |> endpoint
* |> router
* |> pipeline
* |> controller 

Controllers are at the end, and touch on views and templates.
