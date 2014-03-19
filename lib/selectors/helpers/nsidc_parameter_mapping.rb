# Parameter mappings from GCMD string to search facet bins.
module NsidcParameterMapping
  MAPPING = {
      # Topic mappings
      'EARTH SCIENCE > Biological Classification.*' => 'Biosphere',
      'EARTH SCIENCE > Biosphere.*' => 'Biosphere',
      'EARTH SCIENCE > Human Dimensions.*' => 'Human Dimensions',

      '.*Aerosol.*' => 'Aerosols',
      '.*Degree Days.*' => 'Air Temperature',
      '.*Dew Point Temperature.*' => 'Air Temperature',
      '.*Maximum/Minimum Temperature.*' => 'Air Temperature',
      '.*Surface Air Temperature.*' => 'Air Temperature',
      '.*Altitude.*' => 'Altitude',
      '.*Atmospheric Chemistry.*' => 'Atmospheric Chemistry',
      '.*Carbon Monoxide.*' => 'Atmospheric Chemistry',
      '.*Condensation.*' => 'Atmospheric Chemistry',
      '.*Emissions.*' => 'Atmospheric Chemistry',
      '.*Atmospheric Pressure.*' => 'Atmospheric Pressure',
      '.*Atmospheric Electricity.*' => 'Atmospheric Properties (other)',
      '.*Evapo.*' => 'Atmospheric Properties (other)',
      '.*Heat Flux.*' => 'Atmospheric Properties (other)',
      '.*Incoming Solar Radiation.*' => 'Atmospheric Properties (other)',
      '.*Longwave Radiation.*' => 'Atmospheric Properties (other)',
      '.*Net Radiation.*' => 'Atmospheric Properties (other)',
      '.*Outgoing Longwave Radiation.*' => 'Atmospheric Properties (other)',
      '.*Particulates.*' => 'Atmospheric Properties (other)',
      '.*Potential Temperature.*' => 'Atmospheric Properties (other)',
      '.*Precipitable Water.*' => 'Atmospheric Properties (other)',
      '.*Radiative Flux.*' => 'Atmospheric Properties (other)',
      '.*Sea Level Pressure.*' => 'Atmospheric Properties (other)',
      '.*Shortwave Radiation.*' => 'Atmospheric Properties (other)',
      '.*Solar Flares.*' => 'Atmospheric Properties (other)',
      '.*Solar Radiation.*' => 'Atmospheric Properties (other)',
      '.*Solar Radio Wave Emissions.*' => 'Atmospheric Properties (other)',
      '.*Storms.*' => 'Atmospheric Properties (other)',
      '.*Sulfur Oxides.*' => 'Atmospheric Properties (other)',
      '.*Sun-earth Interactions.*' => 'Atmospheric Properties (other)',
      '.*Sunspots.*' => 'Atmospheric Properties (other)',
      '.*Tornadoes.*' => 'Atmospheric Properties (other)',
      '.*Transmittance.*' => 'Atmospheric Properties (other)',
      '.*Ultraviolet Radiation.*' => 'Atmospheric Properties (other)',
      '.*Visibility.*' => 'Atmospheric Properties (other)',
      '.*Seafloor Topography.*' => 'Bathymetry',
      '.*Animal Ecology and Behavior.*' => 'Biosphere',
      '.*Animal Management Systems.*' => 'Biosphere',
      '.*Livestock Products.*' => 'Biosphere',
      '.*Photosynthetically Active Radiation.*' => 'Biosphere',
      '.*Pollen.*' => 'Biosphere',
      '.*Vegetable Products.*' => 'Biosphere',
      '.*Clouds.*' => 'Clouds',
      '.*Elevation.*' => 'Elevation',
      '.*Cryosols.*' => 'Frozen Ground',
      '.*Gas Hydrates.*' => 'Frozen Ground',
      '.*Talik.*' => 'Frozen Ground',
      '.*Geomorphology.*' => 'Geomorphology',
      '.*Ablation Zones/Accumulation Zones.*' => 'Glacier/Ice Sheet Properties (other)',
      '.*Glaciation.*' => 'Glaciers',
      '.*Gravitational Field.*' => 'Gravity',
      '.*Ground Water.*' => 'Ground Water',
      '.*Boreholes.*' => 'Ice Core Records',
      '.*Drought/Precipitation Reconstruction.*' => 'Ice Core Records',
      '.*Ice Core Records.*' => 'Ice Core Records',
      '.*Ice Fabric.*' => 'Ice Core Records',
      '.*Isotope.*' => 'Ice Core Records',
      '.*Freeboard.*' => 'Ice Depth/Thickness',
      '.*Glacier Thickness/Ice Sheet Thickness.*' => 'Ice Depth/Thickness',
      '.*Ice Draft.*' => 'Ice Depth/Thickness',
      '.*Polynyas.*' => 'Ice Edges',
      '.*Ice Deformation.*' => 'Ice Growth/Melt',
      '.*Sea Ice Dynamics.*' => 'Ice Growth/Melt',
      '.*Glacier Motion/Ice Sheet Motion.*' => 'Ice Motion',
      '.*Glacier Topography/Ice Sheet Topography.*' => 'Ice Topography',
      '.*Infrared Radiance.*' => 'Infrared Imagery/Radiance',
      '.*Infrared Imagery.*' => 'Infrared Imagery/Radiance',
      '.*Reflected Infrared.*' => 'Infrared Imagery/Radiance',
      '.*Shortwave Infrared.*' => 'Infrared Imagery/Radiance',
      '.*Visible-Near Infrared.*' => 'Infrared Imagery/Radiance',
      '.*Lake Ice.*' => 'Lakes',
      '.*Contours.*' => 'Land Surface Properties',
      '.*Erosion.*' => 'Land Surface Properties',
      '.*Land Heat Capacity.*' => 'Land Surface Properties',
      '.*Land Surface Temperature.*' => 'Land Surface Properties',
      '.*Land Use Classes.*' => 'Land Surface Properties',
      '.*Landforms.*' => 'Land Surface Properties',
      '.*Landscape Ecology.*' => 'Land Surface Properties',
      '.*Landscape Patterns.*' => 'Land Surface Properties',
      '.*Landslides.*' => 'Land Surface Properties',
      '.*Microfossils.*' => 'Land Surface Properties',
      '.*Paleovegetation.*' => 'Land Surface Properties',
      '.*Radiocarbon.*' => 'Land Surface Properties',
      '.*Reference Fields.*' => 'Land Surface Properties',
      '.*Seismic Profile.*' => 'Land Surface Properties',
      '.*Stratigraphic Sequence.*' => 'Land Surface Properties',
      '.*Terrain Elevation.*' => 'Land Surface Properties',
      '.*Thermal Properties.*' => 'Land Surface Properties',
      '.*Topographic Effects.*' => 'Land Surface Properties',
      '.*Topographical Relief.*' => 'Land Surface Properties',
      '.*Weathering.*' => 'Land Surface Properties',
      '.*Magnetic Anomalies.*' => 'Magnetic Field',
      '.*Mass Balance.*' => 'Mass Balance',
      '.*Microwave Imagery.*' => 'Microwave Imagery/Radiance',
      '.*Microwave Radiance.*' => 'Microwave Imagery/Radiance',
      '.*Longshore Currents.*' => 'Ocean Circulation',
      '.*Ocean Circulation.*' => 'Ocean Circulation',
      '.*Ocean Currents.*' => 'Ocean Circulation',
      '.*Turbulence.*' => 'Ocean Circulation',
      '.*Marine Sediments.*' => 'Ocean Properties (other)',
      '.*Ocean Acoustics.*' => 'Ocean Properties (other)',
      '.*Ocean Chemistry.*' => 'Ocean Properties (other)',
      '.*Ocean/Lake Records.*' => 'Ocean Properties (other)',
      '.*Ocean Optics.*' => 'Ocean Properties (other)',
      '.*Ocean Waves.*' => 'Ocean Properties (other)',
      '.*Salinity.*' => 'Ocean Properties (other)',
      '.*Surface Water.*' => 'Ocean Properties (other)',
      '.*Water Pressure.*' => 'Ocean Properties (other)',
      '.*Water Quality/Water Chemistry.*' => 'Ocean Properties (other)',
      '.*Ocean Temperature.*' => 'Ocean Temperature',
      '.*Flight Data Logs.*' => 'Platform/Sensor Characteristics',
      '.*Platform Characteristics.*' => 'Platform/Sensor Characteristics',
      '.*Range To Target.*' => 'Platform/Sensor Characteristics',
      '.*Sensor Characteristics.*' => 'Platform/Sensor Characteristics',
      '.*Sensor Counts.*' => 'Platform/Sensor Characteristics',
      '.*Surface Range.*' => 'Platform/Sensor Characteristics',
      '.*Time-Of-Flight.*' => 'Platform/Sensor Characteristics',
      '.*Precipitation.*' => 'Precipitation',
      '.*Radar.*' => 'Radar Properties',
      '.*River Ice.*' => 'Rivers/Streams',
      '.*Geochemistry.*' => 'Rocks/Minerals',
      '.*Rocks/Minerals.*' => 'Rocks/Minerals',
      '.*Pack Ice.*' => 'Sea Ice Concentration',
      '.*Sea Surface Topography.*' => 'Sea Surface Topography',
      '.*Snow Energy Balance.*' => 'Snow Melt',
      '.*Snow Facies.*' => 'Snow Pit Records',
      '.*Snow Pit Major Ion Chemistry.*' => 'Snow Pit Records',
      '.*Depth Hoar.*' => 'Snow Properties',
      '.*Calcium.*' => 'Soil Chemistry',
      '.*Carbon.*' => 'Soil Chemistry',
      '.*Magnesium.*' => 'Soil Chemistry',
      '.*Nitrogen.*' => 'Soil Chemistry',
      '.*Phosphorus.*' => 'Soil Chemistry',
      '.*Potassium.*' => 'Soil Chemistry',
      '.*Soil pH.*' => 'Soil Chemistry',
      '.*Electrical Conductivity.*' => 'Soil Conductivity',
      '.*Hydraulic Conductivity.*' => 'Soil Conductivity',
      '.*Cation Exchange Capacity.*' => 'Soil Properties (other)',
      '.*Organic Matter.*' => 'Soil Properties (other)',
      '.*Sedimentation.*' => 'Soil Properties (other)',
      '.*Soil Bulk Density.*' => 'Soil Properties (other)',
      '.*Soil Classification.*' => 'Soil Properties (other)',
      '.*Soil Color.*' => 'Soil Properties (other)',
      '.*Soil Consistence.*' => 'Soil Properties (other)',
      '.*Soil Gas/Air.*' => 'Soil Properties (other)',
      '.*Soil Heat Budget.*' => 'Soil Properties (other)',
      '.*Soil Horizons/Profile.*' => 'Soil Properties (other)',
      '.*Soil Mechanics.*' => 'Soil Properties (other)',
      '.*Soil Plasticity.*' => 'Soil Properties (other)',
      '.*Soil Porosity.*' => 'Soil Properties (other)',
      '.*Soil Respiration.*' => 'Soil Properties (other)',
      '.*Soil Salinity/Soil Sodicity.*' => 'Soil Properties (other)',
      '.*Soil Structure.*' => 'Soil Properties (other)',
      '.*Soil Water Holding Capacity.*' => 'Soil Properties (other)',
      '.*Thermal Conductivity.*' => 'Soil Properties (other)',
      '.*Water Vapor Profiles.*' => 'Water Vapor',
      '.*Cyclones.*' => 'Winds',
      '.*Winds.*' => 'Winds'
  }
end