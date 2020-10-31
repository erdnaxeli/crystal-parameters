# TODO: Write documentation for `Crystal::Parameters`
module Parameters
  VERSION = "1.0.1"

  def self.parse(line : String) : Array(String)?
    delimiter = nil
    args = [] of String
    acc = String::Builder.new

    line.each_char do |c|
      if delimiter.nil?
        if c == ' '
          if acc.empty?
            next
          else
            args << acc.to_s
            acc = String::Builder.new
          end
        elsif c == '"' || c == '\''
          delimiter = c
        else
          acc << c
        end
      else
        if c == delimiter
          delimiter = nil
        else
          acc << c
        end
      end
    end

    if !delimiter.nil?
      # there is a odd number of delimiter, the command is invalid
      nil
    else
      args << acc.to_s
      args
    end
  end
end
