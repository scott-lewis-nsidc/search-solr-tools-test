require 'require_all'
require_rel '../selectors'

module SearchSolrTools
  module Helpers
    # This hash grabs all the selector files inside the selectors directory,
    # to add a new source we need to create a selector file and add it to this hash.
    SELECTORS = {
      cisl:   Selectors::CISL,
      echo:   Selectors::ECHO,
      ices:   Selectors::ICES,
      nmi:    Selectors::NMI,
      nodc:   Selectors::NODC,
      pdc:    Selectors::PDC,
      rda:    Selectors::RDA,
      tdar:   Selectors::TDAR,
      usgs:   Selectors::USGS
    }
  end
end
