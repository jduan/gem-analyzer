require "gems"
require "net/http"

class GemDownloader
    LATEST_GEMS_URL = "http://rubygems.org/latest_specs.4.8.gz"
    ALL_GEMS_URL = "http://rubygems.org/specs.4.8.gz"

    # return a list of all the latest gems
    def latest_gems
        Marshal.load(latest_gems_file)
    end

    def all_gems
        Marshal.load(all_gems_file)
    end

    private
    def latest_gems_file
        fetch_gems_file(LATEST_GEMS_URL)
    end

    def all_gems_file
        fetch_gems_file(ALL_GEMS_URL)
    end

    def fetch_gems_file(url)
        response = fetch(url)
        Gem.gunzip(response.body)
    end

    # Do a GET and follow redirection
    def fetch(uri_str, limit = 10)
        raise ArgumentError, 'too many HTTP redirects' if limit == 0

        response = Net::HTTP.get_response(URI(uri_str))

        case response
        when Net::HTTPSuccess then
            response
        when Net::HTTPRedirection then
            location = response['location']
            puts "redirected to #{location}"
            fetch(location, limit - 1)
        else
            response.value
        end
    end
end
