# Cbr to Epub Converter

This gem lets you convert .cbr and .cbz comic books to epub files.
This may come in handy if you want to be able to read them on your iPad.

The tool has been written for and tested on macOS, so if you want to use it on other platforms you'll need to port Input::CbrExtractor and Output::EpubCompressor classes, as they rely on shell utilities for macOS system.

## FORK INFO: 
This fork also passes images through an optimizer to reduce their sizes drastically (4-5x) with minimal visible loss in quality.

It also tweaks the EPUB template to display full-page images as best it can

## INSTALL FOR THE FORKED VERSION:
- Clone,
- `cd` into Dir,
- `gem install /full/path/to/your.gem`

## BUILD GEM

- `gem build cbr_to_epub.gemspec`

## Installation

In order to use it, make sure you have a few tools installed in your system. You can do it via homebrew:

`brew install unrar imagemagick advancecomp gifsicle jhead jpegoptim jpeg optipng pngcrush pngquant jonof/kenutils/pngout`


Then install some gems (for pngout support):
`gem install image_optim image_optim_pack`

And finally the `cbr_to_epub` gem
`gem install cbr_to_epub`

## Usage

`cbr_to_epub -i input.cbr`

You can also specify author and title for metadata that will be embedded in the epub file:

`cbr_to_epub -i input.cbr --title "Batman 1" --author "Comic Book Guy"`

Use `-o` option if you want to specify output file manually.

## Batch Usage

`cbr_to_epub --inputs=*.cbr [--output=/destination/dir]`

converts all matching cbr and cbz to output, or their current directory

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/rafalcymerys/cbr_to_epub.

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
