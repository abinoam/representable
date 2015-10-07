module Representable::XML
  module Collection
    include Representable::XML

    def self.included(base)
      base.send :include, Representable::XML
      base.send :include, Representable::Hash::Collection
      base.send :include, Methods
    end


    module Methods
      def create_representation_with(doc, options, format)
        bin = representable_mapper(format, options).bindings(represented, options).first
        bin.write(doc, super)
      end

      def update_properties_from(doc, *args)
        super(doc.search("./*"), *args) # pass the list of collection items to Hash::Collection#update_properties_from.
      end
    end
  end
end
