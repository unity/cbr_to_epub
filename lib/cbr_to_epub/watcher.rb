require 'listen'

module CbrToEpub
  class Watcher
    def initialize(input, output, delete)
      @input_path = input
      @output = CbrToEpub::Output.new(output)
      @delete_files = delete
      @queue = []
      @listener.start
    end
    def listener
      Listen.to(input) do |added, modified|
        if(added.count)
          puts "Added File(s) #{added}"
          @queue.concat(added)
        end
        if(modified.count)
          puts "Modified File(s) #{modified}"
          @queue.concat(added)
        end
      end
    end

    def delete input
      puts ">>>>>>>>>>>>>>>>>>> Deleting #{input}"
      FileUtils.rm_rf(input)
    end

    def process
      while (@queue.count)
        input = @queue.shift
        output = @output.for(input)
        puts ">>>>>>>>>>>>>>>>>>> Processing #{input} to #{output}"
        CbrToEpub::Converter.new(
          input,
          output,
          CbrToEpub::Output::Content::Metadata.new(
            author,
            File.basename(input).split('.').first
          )
        ).convert
        @delete(input) if (@delete_files === true)
      end
    end
  end
end
