require 'net/http/response'

# Mock types for testing the `Youtube` module.
module Mocks

  class MockResponse < Net::HTTPResponse

    def stream_check  # Avoid: `stream_check': undefined method `closed?' for nil:NilClass (NoMethodError)
      return
    end

  end

  class MockSession
    def initialize(url)
      @res = MockResponse.new(1.0, 200, "OK")
    end

    def set_res_body(content)
      @res.read_body  # Update body content and set.
      @res.body = content
    end

    def get(path)
      return @res
    end
  end

end
