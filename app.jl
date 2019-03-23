# using Morsel
# using HttpCommon    # For FileResponse(), which serves static files
# using JSON
# using ExcelReaders # require pip install xlrd
#
# app = Morsel.app()
#
# route(app, GET | POST | PUT, "/") do req, res
#     "This is the root"
# end
#
# get(app, "/about") do req, res
#     "This app is running on Morsel !!"
# end
#
# start(app, int(ARGS[1]))

using HTTP

HTTP.listen("127.0.0.1", 8081) do http
    HTTP.setheader(http, "Content-Type" => "text/html")
    write(http, "target uri: $(http.message.target)<BR>")
    write(http, "request body:<BR><PRE>")
    write(http, read(http))
    write(http, "</PRE>")
end

HTTP.listen("127.0.0.1", 8081) do http
    @show http.message
    @show HTTP.header(http, "Content-Type")
    while !eof(http)
        println("body data: ", String(readavailable(http)))
    end
    HTTP.setstatus(http, 404)
    HTTP.setheader(http, "Foo-Header" => "bar")
    startwrite(http)
    write(http, "response body")
    write(http, "more response body")
end
