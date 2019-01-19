module CbrToEpub
  class Output
    def initialize output
      @output = output
    end
    def for input
      File.join(
        File.expand_path(@output || File.dirname(input)),
        File.basename(input, File.extname(input)) + ".epub",
      )
    end
  end
end
