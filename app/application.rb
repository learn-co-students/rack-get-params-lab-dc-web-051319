class Application

    @@items = ["Apples","Carrots","Pears"]

    @@cart = Array.new

    def call(env)
        resp = Rack::Response.new
        req = Rack::Request.new(env)

        case
        when req.path.match(/items/)
            @@items.each do |item|
                resp.write "#{item}\n"
            end
        when req.path.match(/search/)
            search_term = req.params["q"]
            resp.write handle_search(search_term)
        when req.path.match(/cart/)
            item = req.params["q"]
            handle_cart(item, resp)
        when req.path.match(/add/)
            item = req.params["item"]
            resp.write handle_add(item)
        else
            resp.write "Path Not Found"
        end

        resp.finish
    end

    def handle_search(search_term)
        if @@items.include?(search_term)
            return "#{search_term} is one of our items"
        else
            return "Couldn't find #{search_term}"
        end
    end

    def handle_cart(item, resp)
        unless @@cart.empty?
            @@cart.each do |item|
                resp.write "#{item}\n"
            end
        else 
            resp.write "Your cart is empty"
        end
    end

    def handle_add(item)
        if @@items.include?(item)
            @@cart << item
            return "added #{item}"
        else
            return "We don't have that item!"
        end
    end
end
