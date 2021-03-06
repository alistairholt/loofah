module Loofah
  module HTML
    #
    #  Subclass of Nokogiri::HTML::DocumentFragment. Also includes Loofah::ScrubberInstanceMethods.
    #
    #  See Loofah::ScrubberInstanceMethods for additional methods.
    #
    class DocumentFragment < Nokogiri::HTML::DocumentFragment
      include Loofah::ScrubberInstanceMethods

      class << self
        #
        #  Overridden Nokogiri::HTML::DocumentFragment
        #  constructor. Applications should use Loofah.fragment to
        #  parse a fragment.
        #
        def parse tags
          self.new(Loofah::HTML::Document.new, tags)
        end
      end

      #
      #  Returns the HTML markup contained by the fragment or document
      #
      def to_s
        __sanitize_roots.children.to_s
      end
      alias :serialize :to_s

      private

      def __sanitize_roots # :nodoc:
        xpath("./body").first || self
      end

    end
  end
end
