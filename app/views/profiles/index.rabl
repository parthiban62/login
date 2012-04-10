object false
node :header do
  {:status=>"200"}
end

node :body do
  {:owner=>partial("", :object=>@current_users),:data=>partial("profiles/profile",:object=>@subject)}
end