# TODO: Write documentation for `Crystal::Parameters`
module Parameters
  VERSION = "1.0.5"

  def self.parse(line : String) : Array(String)?
    # We call "simple" a paramater without quotes, and "complex" a parameter
    # delimited by simple or double quotes.
    # Note that simple and complex parameters are concatened when not separated
    # by a space.

    # *delimiter* will contains the current parameter delimiter seen. It can be
    # a simple or a double quotes.
    delimiter = nil
    # *args* will contains the list of parameters.
    args = [] of String
    # *acc* will contains the current parameters. It is flushed to args when
    # encountering a space character.
    acc = String::Builder.new
    # Should we ignore an empty parameter?
    # An empty simple parameter is ignored, but an empty complex parameter is
    # not.
    ignore_empty = true

    line.each_char do |c|
      if delimiter.nil?
        # We are reading a simple parameter.
        if c == ' '
          # The parameters ends.
          if acc.empty?
            # We ignore empty simple parameters.
            next
          else
            args << acc.to_s
            # We reinitialize the current parameter state.
            acc = String::Builder.new
            ignore_empty = true
          end
        elsif c == '"' || c == '\''
          # That's the begining of a complex parameter
          ignore_empty = false
          delimiter = c
        else
          # That's neiter the end of the parameter nor the start of a complex
          # on, so we just add the character to the current parameter.
          acc << c
        end
      else
        # We are reading a simple parameter.
        if c == delimiter
          # That's the end of the complex parameter. We do not flush it now the
          # args, as a simple parameter may be concatened to it.
          delimiter = nil
        else
          # That's not the end end of the complex parameter, so we just add the
          # character to the current parameter.
          acc << c
        end
      end
    end

    if !delimiter.nil?
      # We didn't encounter the end of a complex parameter, the command is
      # invalid.
      return nil
    elsif !ignore_empty || !acc.empty?
      # Eitther we don't ignore an empty parameter because it was a complex one,
      # or the parameter is not empty, so we flush the parameters to *args*.
      args << acc.to_s
    end

    args
  end
end
