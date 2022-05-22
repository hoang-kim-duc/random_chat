Dir["#{Rails.root}/lib/data_structure/*.rb"].each { |file| require file }

$user_queue = DataStructure::UserQueue.new
