#! ruby -Ku
# encoding: utf-8

require "erb"
require "yaml"

erb = File.read("text.erb")
Dir.glob("texts/*.yml").sort.each do |path|
  STDERR.puts path
  y = YAML.load_file(path)
  y["filename"] = "#{File.basename(path, ".yml")}.html"
  y["text"].gsub!(/\n/, "<br>\n")
  html = ERB.new(erb).result(binding)
  File.binwrite("docs/#{y["filename"]}", html)
end
