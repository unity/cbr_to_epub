require 'listen'
require_relative "output/folder"

module CbrToEpub
  class Watcher
    def initialize(input, output, donedir, delete)
      @input_path = input
      @output = CbrToEpub::Output::Folder.new(output)
      @delete_files = delete
      @donedir = donedir
      @queue = []
      listener(@input_path)
      process
    end

    private

    def listener input
      puts "----------"
      puts "Watching folder #{input}"
      puts "----------"
      @_listener ||= Listen.to(input) do |added, modified|
        if(added.count)
          push(added)
        end
        if(modified.count)
          push(modified)
        end
      end
      @_listener.start()
      @_listener
    end

    def trash input
      puts ">>>>>>>>>>>>>>>>>>> Deleting #{input}"
      FileUtils.rm_rf(input)
    end

    def push files
      files.each do |file|
        extname = File.extname(file).downcase
        if extname === ".cbr" or extname === ".cbz"
          puts "Adding File #{file} to #{@queue}"
          @queue.push(file)
          process unless @processing
        end
      end
    end

    def move input, output
      puts ">>>>>>>>>>> Moving #{input} to #{output}" if Dir.exists? output
      FileUtils.mv(input, output) unless output.nil? or not Dir.exists?(output) or File.exists?("#{output}/#{input}")
    end

    def process
      while (@queue.count > 0)
        puts "#{@queue.count} #{@queue}"
        @processing = true
        input = @queue.shift
        output = @output.for(input)
        puts ">>>>>>>>>>>>>>>>>>> Processing #{input} to #{output}"
        CbrToEpub::Converter.new(
          input,
          output,
          CbrToEpub::Output::Content::Metadata.new(
            nil,
            File.basename(input).split('.').first
          )
        ).convert
        move(input, @donedir) if @donedir
      end
      @processing = false
    end
  end
end
