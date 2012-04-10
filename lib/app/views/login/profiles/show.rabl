object false
node :header do
  {:status=>"200"}
end
node :body do
  {:subject=>partial("profiles/profile", :object=>@subject)}
end