Hash.class_eval do
  def is_a_special_hash?
    true
  end
end
#~ %w{ models controllers helpers }.each do |dir|
  #~ path = File.join(directory, 'lib', dir)
  #~ $LOAD_PATH << path
  #~ Dependencies.load_paths << path
  #~ Dependencies.load_once_paths.delete(path)
#~ end