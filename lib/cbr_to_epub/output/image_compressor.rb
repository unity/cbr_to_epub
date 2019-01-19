require 'image_optim'
require 'image_optim_pack'
require 'parallel'

module CbrToEpub
  module Output
    class ImageCompressor
      def initialize(input_image_files)
        @input_image_files = input_image_files
        @image_optim = ImageOptim.new(
          :svgo => false,
          :allow_lossy => true,
          :pngout => false,
          :jpegoptim => {
            :allow_lossy => true,
            :strip => 'all'
          },
          :jpegrecompress => {
            :allow_lossy => true,
            :quality => 2
          }
        )
      end

      def compress_images
        Parallel.each_with_index(@input_image_files, in_processes: 4, progress: "Compressing Images") { |image_file|
          system("mogrify -resize 2048x2048 \"#{image_file}\"")
          @image_optim.optimize_image!(image_file)
        }
      end

      private

      attr_reader :images
    end
  end
end
