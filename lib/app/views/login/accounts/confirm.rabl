object false
node :header do |u|
  {:status=>"200", :access_token=>u.authentication_token}
end

node do
  {:body=>partial("owners/register", :object=>@profiles)}
end

  