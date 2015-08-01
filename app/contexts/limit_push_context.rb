class LimitPushContext
  attr_reader :question_id

  def initialize(question_id)
    @question_id = question_id
    @uri = URI.parse(Rails.configuration.parse_url)
    @notification_body =  {
      where: {}, data: { action: 'ar.com.unstuckme.PUSH_RECEIVED',  data: {} }
    }
  end

  def send
    req = add_request_body(new_push_request)
    req.body = notification_body.to_json
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true
    http.request(req)
  end

  private

  def new_push_request
    request = Net::HTTP::Post.new(uri.request_uri)
    request['X-Parse-Application-Id'] = Rails.application.secrets.parse_app_id
    request['X-Parse-REST-API-Key'] = Rails.application.secrets.parse_api_key
    request['Content-Type'] = 'application/json'
    request
  end

  def aps
    {
      alert: { 'loc-args' => '', 'loc-key' => '' },
      badge: 1, sound: 'default'
    }
  end

  def add_request_body(req)
    notification_body[:data][:aps] = aps
    notification_body[:where][:deviceToken] = Question.find(question_id).creator
    notification_body[:data][:data][:question_id] = question_id
    req
  end
end
