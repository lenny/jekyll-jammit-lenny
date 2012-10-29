RSpec::Matchers.define :include_line_matching do |expected|
  match do |actual|
    actual.lines.any? { |l| l.match(expected) }
  end
end