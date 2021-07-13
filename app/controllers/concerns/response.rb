module Response
  def json_response(object, _include = [], status = :ok)
    render json: object, include: _include, status: status
  end
end