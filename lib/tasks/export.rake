namespace :export do
  task :time_zones_json do
    require 'json'

    data = {
      time_zones: TZInfo::Timezone.all_identifiers
    }

    File.open("public/time_zones.json","w") do |f|
      f.write(data.to_json)
    end
  end
end
